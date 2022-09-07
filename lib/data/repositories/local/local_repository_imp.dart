import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:igplus_ios/data/failure.dart';
import 'package:igplus_ios/data/sources/local/local_datasource.dart';
import 'package:igplus_ios/domain/entities/friend.dart';
import 'package:igplus_ios/domain/entities/report.dart';
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

  // followers
  @override
  Future<void> cacheFollowers({required List<Friend> friendsList}) async {
    await localDataSource.cacheFollowers(
      friendsList: friendsList,
    );
  }

  @override
  Either<Failure, List<Friend>?> getCachedFollowersList() {
    try {
      final List<Friend>? cachedFriendsList = localDataSource.getCachedFollowersList();
      return Right(cachedFriendsList);
    } catch (e) {
      return const Left(InvalidParamsFailure("getCachedFriendsList catch"));
    }
  }

  // followings
  @override
  Future<void> cacheFollowings({required List<Friend> friendsList}) async {
    await localDataSource.cacheFollowings(
      friendsList: friendsList,
    );
  }

  @override
  Either<Failure, List<Friend>?> getCachedFollowingsList() {
    try {
      final List<Friend>? cachedFriendsList = localDataSource.getCachedFollowingsList();
      return Right(cachedFriendsList);
    } catch (e) {
      return const Left(InvalidParamsFailure("getCachedFriendsList catch"));
    }
  }
}
