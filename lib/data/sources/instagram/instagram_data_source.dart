// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:igreports/data_source/source/headers_datasource.dart';
// import 'package:igreports/models/ig_headers.dart';

import 'dart:convert';

import 'package:igplus_ios/data/models/account_info_model.dart';
import 'package:http/http.dart' as http;

import 'package:igplus_ios/data/models/user_stories_model.dart';
import 'package:igplus_ios/domain/entities/User_story.dart';

import 'package:igplus_ios/domain/entities/friend.dart';

import '../../constants.dart';
import '../../failure.dart';
import '../../models/friend_model.dart';
import '../../models/story_model.dart';

abstract class InstagramDataSource {
  Future<AccountInfoModel> getAccountInfoByUsername({required String username, required Map<String, String> headers});
  Future<AccountInfoModel> getAccountInfoById({required String igUserId, required Map<String, String> headers});
  Future<List<FriendModel>> getFollowers({
    required String igUserId,
    required Map<String, String> headers,
    String? maxIdString,
    required List<Friend> cachedFollowersList,
    required int newFollowersNumber,
  });
  Future<List<FriendModel>> getFollowings({required String igUserId, required Map<String, String> headers});
  Future<List<UserStoryModel>> getUserStories({required Map<String, String> headers});
  Future<List<StoryModel>> getStories({required String userId, required Map<String, String> headers});
  Future<bool> followUser({required int userId, required Map<String, String> headers});
  Future<bool> unfollowUser({required int userId, required Map<String, String> headers});
}

class InstagramDataSourceImp extends InstagramDataSource {
  final http.Client client;

  InstagramDataSourceImp({required this.client});

  @override
  Future<AccountInfoModel> getAccountInfoById({required String igUserId, required Map<String, String> headers}) async {
    final response = await client.get(Uri.parse(InstagramUrls.getAccountInfoById(igUserId)), headers: headers);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['user']['is_private'] == null) {
        throw const InstagramSessionExpiredFailure("Instagram session expired");
      } else {
        return AccountInfoModel.fromJsonById(jsonResponse);
      }
    } else {
      throw const ServerFailure("Failed to get account info by ID");
    }
  }

  @override
  Future<AccountInfoModel> getAccountInfoByUsername(
      {required String username, required Map<String, String> headers}) async {
    final response = await client.get(Uri.parse(InstagramUrls.getAccountInfoByUsername(username)), headers: headers);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      if (jsonResponse['user']['is_private'] == null) {
        throw const InstagramSessionExpiredFailure("Instagram session expired");
      } else {
        return AccountInfoModel.fromJsonByUsername(jsonResponse);
      }
    } else {
      throw const ServerFailure("Failed to get account info by username");
    }
  }

  @override
  Future<List<FriendModel>> getFollowers({
    required String igUserId,
    required Map<String, String> headers,
    String? maxIdString,
    required List<Friend> cachedFollowersList,
    required int newFollowersNumber,
  }) async {
    List<FriendModel> friendsList = [];
    String? nextMaxId = "";
    int nbrRequests = 1;
    const int requestsLimit = 20;

    final response =
        await client.get(Uri.parse(InstagramUrls.getFollowers(igUserId, maxIdString ?? "")), headers: headers);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      // search for last cached friend to get only new friends
      if (cachedFollowersList.isNotEmpty) {
        bool lastCachedFollowersDetected = false;
        int currentCase = 0;
        final List<dynamic> users = body['users'];
        List<FriendModel> friends = users.map((friend) => FriendModel.fromJson(friend)).toList();
        FriendModel lastFollowers = friends.last;

        int lastCachedFriendIndex =
            cachedFollowersList.indexWhere((element) => element.igUserId == lastFollowers.igUserId);
        List<Friend> tmpCachedFriendList = cachedFollowersList.sublist(0, lastCachedFriendIndex);

        // remove friends from cached list where igUserId is not in friends list (remove unfollowed)
        tmpCachedFriendList.removeWhere((element) => friends.indexWhere((e) => e.igUserId == element.igUserId) == -1);
        // save change to cached followers list
        cachedFollowersList = [...tmpCachedFriendList, ...cachedFollowersList.sublist(tmpCachedFriendList.length)];

        while (lastCachedFollowersDetected == false) {
          Friend lastCachedFriend = cachedFollowersList[currentCase];
          int lastCachedFriendIndex = friends.indexWhere((friend) => friend.igUserId == lastCachedFriend.igUserId);

          // test if last cached friends is still friend or no
          if (lastCachedFriendIndex != -1) {
            lastCachedFollowersDetected = true;
            if (lastCachedFriendIndex != 0) {
              List<dynamic> newFriendsList = friends.sublist(0, lastCachedFriendIndex);
              // friendsList.removeWhere((element) => false);
              friendsList = [
                ...newFriendsList,
                ...cachedFollowersList.map((friend) => FriendModel.fromFriend(friend)).toList()
              ];
            } else {
              friendsList = cachedFollowersList.map((friend) => FriendModel.fromFriend(friend)).toList();
            }
          } else {
            if (friends.length < newFollowersNumber) {
              List<FriendModel> nextUsers =
                  await _loadAllFriends(nextMaxId, body, friendsList, nbrRequests, requestsLimit, igUserId, headers, 0);
              friends = [...nextUsers, ...users];
            } else {
              cachedFollowersList.removeAt(currentCase);
              currentCase++;
            }
          }
        }
      } else {
        friendsList =
            await _loadAllFriends(nextMaxId, body, friendsList, nbrRequests, requestsLimit, igUserId, headers, 0);
      }

      return friendsList;
    } else {
      throw const ServerFailure("Failed to get followers from Instagram");
    }
  }

  Future<List<FriendModel>> _loadAllFriends(String? nextMaxId, body, List<FriendModel> friendsList, int nbrRequests,
      int requestsLimit, String igUserId, Map<String, String> headers, int limit) async {
    nextMaxId = body['next_max_id'];
    List<dynamic> users = body["users"];
    friendsList = users.map((friend) => FriendModel.fromJson(friend)).toList();
    bool pagesLimit = (limit != 0) ? (friendsList.length < limit * 194) : true;

    while (nextMaxId != null && nbrRequests < requestsLimit && pagesLimit) {
      nbrRequests++;
      String maxIdString = "";
      if (nextMaxId != "") {
        await Future.delayed(const Duration(seconds: 3));
        nextMaxId = await _loadNextFollowersPage(maxIdString, nextMaxId, igUserId, headers, friendsList);
      } else {
        break;
      }
    }
    return friendsList;
  }

  Future<String?> _loadNextFollowersPage(String maxIdString, String? nextMaxId, String igUserId,
      Map<String, String> headers, List<FriendModel> friendsList) async {
    maxIdString = "&max_id=$nextMaxId";

    final response = await client.get(Uri.parse(InstagramUrls.getFollowers(igUserId, maxIdString)), headers: headers);

    final rs = jsonDecode(response.body);
    final List<dynamic> users = rs['users'];

    if (users.isNotEmpty) {
      nextMaxId = rs['next_max_id'];
      friendsList.addAll(users.map((f) => FriendModel.fromJson(f as Map<String, dynamic>)).toList());
    }
    return nextMaxId;
  }

  @override
  Future<List<FriendModel>> getFollowings(
      {required String igUserId, required Map<String, String> headers, String? maxIdString}) async {
    List<dynamic>? friendsList = [];
    String? nextMaxId = "";
    int nbrRequests = 1;
    const int requestsLimit = 20;

    final response =
        await client.get(Uri.parse(InstagramUrls.getFollowings(igUserId, maxIdString ?? "")), headers: headers);

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      nextMaxId = body['next_max_id'];
      friendsList = body["users"] as List<dynamic>;

      while (nextMaxId != null && nbrRequests < requestsLimit) {
        nbrRequests++;
        String maxIdString = "";
        if (nextMaxId != "") {
          await Future.delayed(const Duration(seconds: 3));
          maxIdString = "&max_id=$nextMaxId";
          nextMaxId = null;

          final response =
              await client.get(Uri.parse(InstagramUrls.getFollowings(igUserId, maxIdString)), headers: headers);

          final rs = jsonDecode(response.body);

          if (rs['users'] != null) {
            nextMaxId = rs['next_max_id'];
            rs['users'].forEach((user) {
              friendsList?.add(user);
            });
          }
        } else {
          break;
        }
      }

      return friendsList.map((f) => FriendModel.fromJson(f as Map<String, dynamic>)).toList();
    } else {
      throw const ServerFailure("Failed to get followers from Instagram");
    }
  }

  // get active stories from peaple you follow
  @override
  Future<List<UserStoryModel>> getUserStories({required Map<String, String> headers}) async {
    final response = await client.get(Uri.parse(InstagramUrls.getUserStories()), headers: headers);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body)["tray"] as List<dynamic>;
      return result.map((story) => UserStoryModel.fromJson(story as Map<String, dynamic>)).toList();
    } else {
      throw const ServerFailure("Failed to get active stories from Instagram");
    }
  }

  @override
  Future<List<StoryModel>> getStories({required String userId, required Map<String, String> headers}) async {
    final response = await client.get(Uri.parse(InstagramUrls.getStories(userId: userId)), headers: headers);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body)["reels_media"][0]['items'] as List<dynamic>;
      return result.map((story) => StoryModel.fromJson(story as Map<String, dynamic>)).toList();
    } else {
      throw const ServerFailure("Failed to get active stories from Instagram");
    }
  }

  // follow user
  @override
  Future<bool> followUser({required int userId, required Map<String, String> headers}) async {
    final response = await client.post(Uri.parse(InstagramUrls.followUser(userId.toString())), headers: headers);

    if (response.statusCode == 200 && response.body.contains('"status":"ok"')) {
      return true;
    } else if (response.statusCode == 302 && response.body == "") {
      return true;
    } else if (response.body.contains("The link you followed may be broken, or the page may have been removed.")) {
      throw const ServerFailure("User not found");
    } else {
      throw const ServerFailure("Failed to follow user");
    }
  }

  // unfollow user
  @override
  Future<bool> unfollowUser({required int userId, required Map<String, String> headers}) async {
    final response = await client.post(Uri.parse(InstagramUrls.unfollowUser(userId.toString())), headers: headers);
    if (response.statusCode == 200 && response.body.contains('"status":"ok"')) {
      return true;
    } else if (response.statusCode == 302 && response.body == "") {
      return true;
    } else if (response.body.contains("The link you followed may be broken, or the page may have been removed.")) {
      throw const ServerFailure("User not found");
    } else {
      throw const ServerFailure("Failed to follow user");
    }
  }
}

// get viewers of a my stories
//https://i.instagram.com/api/v1/feed/user/{user_id}/reel_media/

// get stories
//https://i.instagram.com/api/v1/feed/reels_tray/

// //https://github.com/postaddictme/instagram-php-scraper
// class InstagramDataSource {
//   const InstagramDataSource({required this.headersDataSource});
//   final HeadersDataSource headersDataSource;

//   //final  BaseUrl = "https://i.instagram.com/api/v1";

//   Future<http.Response> getUserInfo({required String igUserId, required IgHeaders igHeaders}) async {
//     final uri = Uri.parse('https://i.instagram.com/api/v1/users/$igUserId/info');
//     http.Response response = await http.get(uri, headers: igHeaders.toJson());
//     return response;
//   }

//   //https://www.instagram.com/$username/?__a=1
//   Future<http.Response> getUserInfoByUsername({required String username, required IgHeaders igHeaders}) async {
//     final uri = Uri.parse('https://i.instagram.com/api/v1/users/web_profile_info/?username=$username');
//     http.Response response = await http.get(uri, headers: igHeaders.toJson());
//     return response;
//   }

//   //1-https://i.instagram.com/api/v1/media/2445116530512128408/info
//   //2-https://www.instagram.com/p/{code}/?__a=1
//   // we use the seconde url
//   Future<http.Response> getMediaInfoByUrl({required Uri uri, required IgHeaders igHeaders}) async {
//     http.Response response = await http.get(uri, headers: igHeaders.toJson());
//     return response;
//   }

//   Future<http.Response> getUserStories({required String igUserId, required IgHeaders igHeaders}) async {
//     final uri = Uri.parse('https://i.instagram.com/api/v1/feed/reels_media/?reel_ids=$igUserId');
//     http.Response response = await http.get(uri, headers: igHeaders.toJson());
//     return response;
//   }

//   // https://i.instagram.com/api/v1/friendships/show/4280661977
//   Future<http.Response> getFriendshipStatus({required String friendIgUserId, required IgHeaders igHeaders}) async {
//     final uri = Uri.parse('https://i.instagram.com/api/v1/friendships/show/$friendIgUserId');
//     http.Response response = await http.get(uri, headers: igHeaders.toJson());
//     return response;
//   }

// //https://i.instagram.com/api/v1/feed/user/47092259342/story/
//   Future<http.Response> getStories({required String IgUserId, required IgHeaders igHeaders}) async {
//     final uri = Uri.parse('https://i.instagram.com/api/v1/feed/user/$IgUserId/story/');
//     http.Response response = await http.get(uri, headers: igHeaders.toJson());
//     return response;
//   }

//   //https://www.instagram.com/graphql/query/?query_hash=e769aa130647d2354c40ea6a439bfc08&variables={variables}
//   Future<http.Response> getUserMedias({required String username, required IgHeaders igHeaders}) async {
//     final uri = Uri.parse('https://i.instagram.com/api/v1/users/web_profile_info/?username=$username');
//     http.Response response = await http.get(uri, headers: igHeaders.toJson());
//     return response;
//   }

// // https://i.instagram.com/api/v1/tags/search/?q=tiktok
//   Future<http.Response> getHashtagsRelatedTo({required String keyword, required IgHeaders igHeaders}) async {
//     final uri = Uri.parse('https://i.instagram.com/api/v1/tags/search/?q=$keyword');
//     http.Response response = await http.get(uri, headers: igHeaders.toJson());
//     return response;

//     // const mainHost = 'www.instagram.com';
//     // const mainHost = 'i.instagram.com';
//     // var queryParameters = {
//     //   'context': 'hashtag',
//     //   'query': keyword,
//     //   //'verifyFp': verifyFp,
//     //   //'user_agent': headers['user-agent'],
//     // };
//     // // var uri = Uri.https(mainHost, '/web/search/topsearch/', queryParameters);

//     // http.Response response = await http.get(uri, headers: igHeaders.toJson());

//     // return response;
//   }
// }

// //https://i.instagram.com/api/v1/feed/timeline
