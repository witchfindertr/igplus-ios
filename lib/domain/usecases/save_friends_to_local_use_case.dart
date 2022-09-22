import 'package:igplus_ios/domain/entities/friend.dart';
import 'package:igplus_ios/domain/repositories/local/local_repository.dart';

class CacheFriendsToLocalUseCase {
  final LocalRepository localRepository;
  CacheFriendsToLocalUseCase({required this.localRepository});

  Future<void> execute({required String dataName, required List<Friend> friendsList}) async {
    if (dataName == "followers") {
      return localRepository.cacheFriendsList(boxKey: Friend.followersBoxKey, friendsList: friendsList);
    } else if (dataName == "followings") {
      return localRepository.cacheFriendsList(boxKey: Friend.followingsBoxKey, friendsList: friendsList);
    } else if (dataName == "newFollowers") {
      return localRepository.cacheFriendsList(boxKey: Friend.newFollowersBoxKey, friendsList: friendsList);
    } else if (dataName == "lostFollowers") {
      return localRepository.cacheFriendsList(boxKey: Friend.lostFollowersBoxKey, friendsList: friendsList);
    } else if (dataName == "notFollowingBack") {
      return localRepository.cacheFriendsList(boxKey: Friend.notFollowingBackBoxKey, friendsList: friendsList);
    } else if (dataName == "youDontFollowBack") {
      return localRepository.cacheFriendsList(boxKey: Friend.youDontFollowBackBoxKey, friendsList: friendsList);
    } else if (dataName == "youHaveUnfollowed") {
      return localRepository.cacheFriendsList(boxKey: Friend.youHaveUnfollowedBoxKey, friendsList: friendsList);
    } else if (dataName == "mutualFollowings") {
      return localRepository.cacheFriendsList(boxKey: Friend.mutualFollowingsBoxKey, friendsList: friendsList);
    } else {
      return null;
    }
  }
}
