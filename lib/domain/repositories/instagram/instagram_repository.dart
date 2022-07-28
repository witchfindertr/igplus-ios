import 'package:dartz/dartz.dart';
import 'package:igplus_ios/domain/entities/friend.dart';

import '../../../data/failure.dart';
import '../../entities/account_info.dart';

abstract class InstagramRepository {
  Future<Either<Failure, AccountInfo>> getAccountInfo({String? username, String? igUserId});
  Future<Either<Failure, List<Friend>>> getNewFollowers();
  Future<Either<Failure, List<Friend>>> getFollowings({required String igUserId});
  Future<Either<Failure, List<Friend>>> getFollowers({required String igUserId});
}
