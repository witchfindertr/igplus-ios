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

  // Friends
  @override
  Future<void> cacheFriendsList({required List<Friend> friendsList, required String boxKey}) async {
    await localDataSource.cacheFriendsList(
      friendsList: friendsList,
      boxKey: boxKey,
    );
  }

  @override
  Either<Failure, List<Friend>?> getCachedFriendsList({required String boxKey}) {
    try {
      final List<Friend>? cachedFriendsList = localDataSource.getCachedFriendsList(boxKey: boxKey);
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
}
