import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:igplus_ios/domain/entities/friend.dart';

import '../../failure.dart';
import '../../models/account_info_model.dart';

import '../../../domain/entities/account_info.dart';
import '../../../domain/repositories/instagram/instagram_repository.dart';

import '../../sources/instagram/instagram_data_source.dart';

class InstagramRepositoryImp extends InstagramRepository {
  final InstagramDataSource instagramDataSource;

  InstagramRepositoryImp({required this.instagramDataSource});
  @override
  Future<Either<Failure, AccountInfo>> getAccountInfo({String? username, String? igUserId}) async {
    try {
      if (username != null) {
        final AccountInfoModel accountInfoModel = await instagramDataSource.getAccountInfoByUsername(username);
        return Right(accountInfoModel.toEntity());
      } else if (igUserId != null) {
        final AccountInfoModel accountInfoModel = await instagramDataSource.getAccountInfoById(igUserId);
        return Right(accountInfoModel.toEntity());
      } else {
        return const Left(InvalidParamsFailure("username or igUserId is required"));
      }
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(ConnectionFailure("No internet connection"));
    } on Exception {
      return const Left(ServerFailure("Unknown error"));
    }
  }

  @override
  Future<Either<Failure, List<Friend>>> getNewFollowers() async {
    // TODO: implement getNewFollowers
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Friend>>> getFollowers({required String igUserId}) {
    // TODO: implement getFollowers
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Friend>>> getFollowings({required String igUserId}) {
    // TODO: implement getFollowings
    throw UnimplementedError();
  }
}
