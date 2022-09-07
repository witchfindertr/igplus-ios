import 'package:dartz/dartz.dart';
import 'package:igplus_ios/data/failure.dart';
import 'package:igplus_ios/domain/entities/friend.dart';
import 'package:igplus_ios/domain/entities/report.dart';

abstract class LocalRepository {
  // report
  Either<Failure, Report?> getCachedReport();
  Future<void> cacheReport({required Report report});

  // followers
  Either<Failure, List<Friend>?> getCachedFollowersList();
  Future<void> cacheFollowers({required List<Friend> friendsList});

  // followings
  Either<Failure, List<Friend>?> getCachedFollowingsList();
  Future<void> cacheFollowings({required List<Friend> friendsList});
}
