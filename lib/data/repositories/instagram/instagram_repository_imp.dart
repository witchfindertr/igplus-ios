import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:igplus_ios/data/models/media_model.dart';

import 'package:igplus_ios/data/models/stories_user.dart';
import 'package:igplus_ios/data/models/story_viewer_model.dart';
import 'package:igplus_ios/domain/entities/stories_user.dart';
import 'package:igplus_ios/domain/entities/friend.dart';
import 'package:igplus_ios/domain/entities/ig_headers.dart';
import 'package:igplus_ios/domain/entities/media.dart';
import 'package:igplus_ios/domain/entities/story.dart';
import 'package:igplus_ios/domain/entities/story_viewer.dart';

import '../../../domain/entities/account_info.dart';
import '../../../domain/repositories/instagram/instagram_repository.dart';
import '../../failure.dart';
import '../../models/account_info_model.dart';
import '../../models/friend_model.dart';
import '../../models/story_model.dart';
import '../../sources/instagram/instagram_data_source.dart';

class InstagramRepositoryImp extends InstagramRepository {
  final InstagramDataSource instagramDataSource;
  final UserStoryMapper userStoryMapper;
  final StoryMapper storyMapper;

  InstagramRepositoryImp({
    required this.instagramDataSource,
    required this.userStoryMapper,
    required this.storyMapper,
  });
  @override
  Future<Either<Failure, AccountInfo>> getAccountInfo({
    String? username,
    String? igUserId,
    required IgHeaders igHeaders,
  }) async {
    try {
      final Map<String, String> headers = igHeaders.toMap();
      if (username != null) {
        final AccountInfoModel accountInfoModel =
            await instagramDataSource.getAccountInfoByUsername(username: username, headers: headers);
        return Right(accountInfoModel.toEntity());
      } else if (igUserId != null) {
        final AccountInfoModel accountInfoModel =
            await instagramDataSource.getAccountInfoById(igUserId: igUserId, headers: headers);
        return Right(accountInfoModel.toEntity());
      } else {
        return const Left(InvalidParamsFailure("username or igUserId is required"));
      }
    } on InstagramSessionFailure catch (e) {
      return Left(InstagramSessionFailure(e.message));
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(ConnectionFailure("No internet connection"));
    } on Exception {
      return const Left(ServerFailure("Unknown error"));
    }
  }

  @override
  Future<Either<Failure, List<Friend>>> getFollowers({
    required String igUserId,
    required IgHeaders igHeaders,
    String? maxIdString,
    required List<Friend> cachedFollowersList,
    required int newFollowersNumber,
  }) async {
    try {
      final Map<String, String> headers = igHeaders.toMap();
      final List<FriendModel> friendModels = await instagramDataSource.getFollowers(
          igUserId: igUserId,
          headers: headers,
          maxIdString: maxIdString,
          cachedFollowersList: cachedFollowersList,
          newFollowersNumber: newFollowersNumber);

      return Right(friendModels.map((friendModel) => friendModel.toEntity()).toList());
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(ConnectionFailure("No internet connection"));
    } on Exception {
      return const Left(ServerFailure("Unknown error"));
    }
  }

  @override
  Future<Either<Failure, List<Friend>>> getFollowings({
    required String igUserId,
    required IgHeaders igHeaders,
    String? maxIdString,
  }) async {
    try {
      final Map<String, String> headers = igHeaders.toMap();
      final List<FriendModel> friendModels =
          await instagramDataSource.getFollowings(igUserId: igUserId, headers: headers);

      return Right(friendModels.map((friendModel) => friendModel.toEntity()).toList());
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(ConnectionFailure("No internet connection"));
    } on Exception {
      return const Left(ServerFailure("Unknown error"));
    }
  }

  @override
  Future<Either<Failure, List<StoriesUser>>> getUserStories({required IgHeaders igHeaders}) async {
    try {
      final Map<String, String> headers = igHeaders.toMap();
      final List<StoriesUserModel> userStoriesModels = await instagramDataSource.getUserStories(headers: headers);
      return Right(userStoryMapper.mapToEntityList(userStoriesModels));
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(ConnectionFailure("No internet connection"));
    } on Exception {
      return const Left(ServerFailure("Unknown error"));
    }
  }

  @override
  Future<Either<Failure, List<Story>>> getStories({required String userId, required IgHeaders igHeaders}) async {
    try {
      final Map<String, String> headers = igHeaders.toMap();
      final List<StoryModel> storiesModels = await instagramDataSource.getStories(userId: userId, headers: headers);
      return Right(storyMapper.mapToEntityList(storiesModels));
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(ConnectionFailure("No internet connection"));
    } on Exception {
      return const Left(ServerFailure("Unknown error"));
    }
  }

  // follow user
  @override
  Future<Either<Failure, bool>> followUser({required int userId, required IgHeaders igHeaders}) async {
    try {
      final Map<String, String> headers = igHeaders.toMap();
      final bool isFollowed = await instagramDataSource.followUser(userId: userId, headers: headers);
      return Right(isFollowed);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(ConnectionFailure("No internet connection"));
    } on Exception {
      return const Left(ServerFailure("Unknown error"));
    }
  }

  // unfollow user
  @override
  Future<Either<Failure, bool>> unfollowUser({required int userId, required IgHeaders igHeaders}) async {
    try {
      final Map<String, String> headers = igHeaders.toMap();
      final bool isUnfollowed = await instagramDataSource.unfollowUser(userId: userId, headers: headers);
      return Right(isUnfollowed);
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(ConnectionFailure("No internet connection"));
    } on Exception {
      return const Left(ServerFailure("Unknown error"));
    }
  }

  // User feed media
  @override
  Future<Either<Failure, List<Media>>> getUserFeed({required String userId, required IgHeaders igHeaders}) async {
    try {
      final Map<String, String> headers = igHeaders.toMap();
      final List<MediaModel> userFeed = await instagramDataSource.getUserFeed(userId: userId, headers: headers);

      return Right(userFeed.map((media) => media.toEntity()).toList());
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(ConnectionFailure("No internet connection"));
    } on Exception {
      return const Left(ServerFailure("Unknown error"));
    }
  }

  // story viewers list
  @override
  Future<Either<Failure, List<StoryViewer>>> getStoryViewers(
      {required String mediaId, required IgHeaders igHeaders}) async {
    try {
      final Map<String, String> headers = igHeaders.toMap();
      final List<StoryViewerModel> storyViewers =
          await instagramDataSource.getStoryViewers(mediaId: mediaId, headers: headers);

      return Right(storyViewers.map((storyViewer) => storyViewer.toEntity()).toList());
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(ConnectionFailure("No internet connection"));
    } on Exception {
      return const Left(ServerFailure("Unknown error"));
    }
  }
}
