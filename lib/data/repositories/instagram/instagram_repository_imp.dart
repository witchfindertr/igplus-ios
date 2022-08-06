import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:igplus_ios/domain/entities/friend.dart';
import 'package:igplus_ios/domain/entities/ig_headers.dart';

import '../../failure.dart';
import '../../models/account_info_model.dart';

import '../../../domain/entities/account_info.dart';
import '../../../domain/repositories/instagram/instagram_repository.dart';

import '../../models/friend_model.dart';
import '../../sources/instagram/instagram_data_source.dart';

class InstagramRepositoryImp extends InstagramRepository {
  final InstagramDataSource instagramDataSource;

  InstagramRepositoryImp({required this.instagramDataSource});
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
  Future<Either<Failure, List<Friend>>> getFollowers({
    required String igUserId,
    required IgHeaders igHeaders,
  }) async {
    try {
      final Map<String, String> headers = igHeaders.toMap();
      final List<FriendModel> friendModels =
          await instagramDataSource.getFollowers(igUserId: igUserId, headers: headers);

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
}
