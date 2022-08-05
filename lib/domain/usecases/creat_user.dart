import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:igplus_ios/data/failure.dart';
import 'package:igplus_ios/domain/entities/account_info.dart';
import 'package:igplus_ios/domain/entities/ig_headers.dart';
import 'package:igplus_ios/domain/repositories/firebase/firebase_repository.dart';
import 'package:igplus_ios/domain/repositories/instagram/instagram_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import '../entities/user.dart';

class CreateUser {
  final InstagramRepository instagramRepository;
  final FirebaseRepository firebaseRepository;

  CreateUser({required this.instagramRepository, required this.firebaseRepository});

  Future<Either<Failure, Unit>> execute({required AccountInfo accountInfo, required IgHeaders igHeaders}) async {
    auth.User? currentUser = auth.FirebaseAuth.instance.currentUser;

    // user is not authentucated
    if (currentUser == null) {
      return const Left(ServerFailure("user not authenticated"));
    }

    // new User
    final User user = User(
      uid: currentUser.uid,
      igUserId: accountInfo.igUserId,
      username: accountInfo.username,
      contactPhoneNumber: accountInfo.contactPhoneNumber ?? "",
      phoneCountryCode: accountInfo.phoneCountryCode ?? "",
      publicPhoneNumber: accountInfo.publicPhoneNumber ?? "",
      publicEmail: accountInfo.publicEmail ?? "",
      picture: accountInfo.picture,
      igHeaders: igHeaders,
      igAuth: true,
      isActive: true,
      createdAt: FieldValue.serverTimestamp(),
      privateMessage: "",
    );

    final Either<Failure, Unit> createUserEither = await firebaseRepository.createUser(user: user);

    // failed to create user in Firestore
    if (createUserEither.isLeft()) {
      return Left((createUserEither as Left).value);
    }

    // user successfully created in Firestore
    return Right((createUserEither as Right).value);
  }
}
