import 'package:dartz/dartz.dart';
import 'package:igplus_ios/data/failure.dart';
import 'package:igplus_ios/domain/entities/friend.dart';
import 'package:igplus_ios/domain/entities/report.dart';

abstract class LocalRepository {
  // report
  Either<Failure, Report?> getCachedReport();
  Future<void> cacheReport({required Report report});

  // friends
  Either<Failure, List<Friend>?> getCachedFriendsList({required String boxKey});
  Future<void> cacheFriendsList({required List<Friend> friendsList, required String boxKey});
  Either<Failure, int> getNumberOfFriendsInBox({required String boxKey});
}
