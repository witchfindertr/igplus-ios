import 'package:dartz/dartz.dart';
import 'package:igplus_ios/data/failure.dart';
import 'package:igplus_ios/domain/entities/account_info.dart';
import 'package:igplus_ios/domain/entities/friend.dart';
import 'package:igplus_ios/domain/entities/media.dart';
import 'package:igplus_ios/domain/entities/report.dart';

abstract class LocalRepository {
  // report
  Either<Failure, Report?> getCachedReport();
  Future<void> cacheReport({required Report report});

  // friends
  Either<Failure, List<Friend>?> getCachedFriendsList(
      {required String boxKey, int? pageKey, int? pageSize, String? searchTerm});
  Future<void> cacheFriendsList({required List<Friend> friendsList, required String boxKey});
  Either<Failure, int> getNumberOfFriendsInBox({required String boxKey});

  // Media
  Either<Failure, List<Media>?> getCachedMediaList(
      {required String boxKey, int? pageKey, int? pageSize, String? searchTerm, String? type});
  Future<void> cacheMediaList({required List<Media> mediaList, required String boxKey});

  // Account info
  Either<Failure, AccountInfo?> getCachedAccountInfo();
  Future<void> cacheAccountInfo({required AccountInfo accountInfo});

  // clear all boxes
  Future<void> clearAllBoxes();
}
