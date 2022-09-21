import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:igplus_ios/data/models/user_model.dart';

import 'package:igplus_ios/data/sources/firebase/firebase_data_source.dart';

import '../../../domain/entities/user.dart';
import '../../../domain/repositories/firebase/firebase_repository.dart';
import '../../failure.dart';

class FirebaseRepositporyImp implements FirebaseRepository {
  final FirebaseDataSource firebaseDataSource;
  FirebaseRepositporyImp({
    required this.firebaseDataSource,
  });
  @override
  Future<Either<Failure, Unit>> createUser({required User user}) async {
    try {
      await firebaseDataSource.setUser(uid: user.uid, userData: user.toFirestore());
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateUser({required User user}) async {
    try {
      await firebaseDataSource.setUser(uid: user.uid, userData: user.toFirestore());
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final String currentUserId = firebaseDataSource.getCurrentUserId();
      final UserModel userModel = await firebaseDataSource.getUser(userId: currentUserId);
      return Right(userModel.toEntity());
    } on UserAuthenticationFailure catch (e) {
      return Left(UserAuthenticationFailure(e.message));
    } on ServerFailure catch (e) {
      return Left(ServerFailure(e.message));
    } on SocketException {
      return const Left(ConnectionFailure("No internet connection"));
    } on Exception {
      return const Left(ServerFailure("Unknown error"));
    }
  }

  @override
  Future<Either<Failure, User>> getUser({required String userId}) {
    // TODO: implement getUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> validateUser({required String userId}) async {
    try {
      final UserModel userModel = await firebaseDataSource.getUser(userId: userId);
      // get list of bannedUserIds from Firestore
      final List<String> bannedUserIds = await firebaseDataSource.getBannedUserIds();

      // check if userId is in bannedUserIds
      if (bannedUserIds.contains(userModel.igUserId)) {
        return const Left(ServerFailure("User is banned"));
      }

      return Right(userModel.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
