import 'package:dartz/dartz.dart';
import 'package:igplus_ios/data/failure.dart';
import 'package:igplus_ios/data/sources/local/local_datasource.dart';
import 'package:igplus_ios/domain/entities/account_info.dart';
import 'package:igplus_ios/domain/entities/friend.dart';
import 'package:igplus_ios/domain/entities/media.dart';
import 'package:igplus_ios/domain/entities/report.dart';
import 'package:igplus_ios/domain/entities/stories_user.dart';
import 'package:igplus_ios/domain/entities/story.dart';
import 'package:igplus_ios/domain/entities/story_viewer.dart';
import 'package:igplus_ios/domain/repositories/local/local_repository.dart';

class LocalRepositoryImpl implements LocalRepository {
  final LocalDataSource localDataSource;
  LocalRepositoryImpl({
    required this.localDataSource,
  });

  // report
  @override
  Future<void> cacheReport({required Report report}) async {
    await localDataSource.cacheReport(report: report);
  }

  @override
  Either<Failure, Report?> getCachedReport() {
    try {
      final report = localDataSource.getCachedReport();
      if (report == null) {
        return const Left(InvalidParamsFailure('No report found'));
      } else {
        return Right(report);
      }
    } catch (e) {
      return const Left(InvalidParamsFailure("getCachedReport catch"));
    }
  }

  // Friends
  @override
  Future<void> cacheFriendsList({required List<Friend> friendsList, required String boxKey}) async {
    await localDataSource.cacheFriendsList(
      friendsList: friendsList,
      boxKey: boxKey,
    );
  }

  @override
  Either<Failure, List<Friend>?> getCachedFriendsList(
      {required String boxKey, int? pageKey, int? pageSize, String? searchTerm}) {
    try {
      final List<Friend>? cachedFriendsList = localDataSource.getCachedFriendsList(
          boxKey: boxKey, pageKey: pageKey, pageSize: pageSize, searchTerm: searchTerm);
      return Right(cachedFriendsList);
    } catch (e) {
      return const Left(InvalidParamsFailure("getCachedFriendsList catch"));
    }
  }

  // get number of friends in box
  @override
  Either<Failure, int> getNumberOfFriendsInBox({required String boxKey}) {
    try {
      final int numberOfFriends = localDataSource.getNumberOfFriendsInBox(boxKey: boxKey);
      return Right(numberOfFriends);
    } catch (e) {
      return const Left(InvalidParamsFailure("getNumberOfFriendsInBox catch"));
    }
  }

  // Media
  @override
  Future<void> cacheMediaList({required List<Media> mediaList, required String boxKey}) async {
    await localDataSource.cacheMediaList(
      mediaList: mediaList,
      boxKey: boxKey,
    );
  }

  @override
  Either<Failure, List<Media>?> getCachedMediaList(
      {required String boxKey, int? pageKey, int? pageSize, String? searchTerm, String? type}) {
    try {
      final List<Media>? cachedMediaList = localDataSource.getCachedMediaList(
          boxKey: boxKey, pageKey: pageKey, pageSize: pageSize, searchTerm: searchTerm, type: type);
      return Right(cachedMediaList);
    } catch (e) {
      return const Left(InvalidParamsFailure("getCachedMediaList catch"));
    }
  }

  // account info
  @override
  Future<void> cacheAccountInfo({required AccountInfo accountInfo}) async {
    await localDataSource.cacheAccountInfo(accountInfo: accountInfo);
  }

  @override
  Either<Failure, AccountInfo?> getCachedAccountInfo() {
    try {
      final accountInfo = localDataSource.getCachedAccountInfo();
      if (accountInfo == null) {
        return const Left(InvalidParamsFailure('No accountInfo found'));
      } else {
        return Right(accountInfo);
      }
    } catch (e) {
      return const Left(InvalidParamsFailure("getCachedAccountInfo catch"));
    }
  }

  // stories
  @override
  Future<void> cacheStoriesList(
      {required List<Story> storiesList, required String boxKey, required String ownerId}) async {
    await localDataSource.cacheStoriesList(
      storiesList: storiesList,
      boxKey: boxKey,
      ownerId: ownerId,
    );
  }

  @override
  Either<Failure, List<Story>?> getCachedStoriesList({
    required String boxKey,
    required int pageKey,
    required int pageSize,
    String? searchTerm,
    String? type,
    required String ownerId,
  }) {
    try {
      final List<Story>? cachedStoriesList = localDataSource.getCachedStoriesList(
          boxKey: boxKey, pageKey: pageKey, pageSize: pageSize, searchTerm: searchTerm, type: type, ownerId: ownerId);
      return Right(cachedStoriesList);
    } catch (e) {
      return const Left(InvalidParamsFailure("getCachedStoriesList catch"));
    }
  }

  // stories users
  @override
  Future<void> cacheStoriesUsersList({required List<StoriesUser> storiesUserList, required String boxKey}) async {
    await localDataSource.cacheStoriesUsersList(
      storiesUserList: storiesUserList,
      boxKey: boxKey,
    );
  }

  @override
  Either<Failure, List<StoriesUser>?> getCachedStoriesUsersList({required String boxKey}) {
    try {
      final List<StoriesUser>? cachedStoriesList = localDataSource.getCachedStoriesUsersList(boxKey: boxKey);
      return Right(cachedStoriesList);
    } catch (e) {
      return const Left(InvalidParamsFailure("getCachedStoriesUserList catch"));
    }
  }

  // stories viewers
  Future<void> cacheStoryViewersList({required List<StoryViewer> storiesViewersList, required String boxKey}) async {
    await localDataSource.cacheStoryViewersList(
      storiesViewersList: storiesViewersList,
      boxKey: boxKey,
    );
  }

  @override
  Either<Failure, List<StoryViewer>?> getCachedStoryViewersList(
      {required String boxKey, required String mediaId, int? pageKey, int? pageSize, String? searchTerm}) {
    try {
      final List<StoryViewer>? cachedStoriesViewersList = localDataSource.getCachedStoryViewersList(
        boxKey: boxKey,
        mediaId: mediaId,
        pageKey: pageKey,
        pageSize: pageSize,
        searchTerm: searchTerm,
      );
      return Right(cachedStoriesViewersList);
    } catch (e) {
      return const Left(InvalidParamsFailure("getCachedStoriesUserList catch"));
    }
  }

  // clear all boxes
  @override
  Future<void> clearAllBoxes() async {
    await localDataSource.clearAllBoxes();
  }
}
