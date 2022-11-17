import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:igshark/data/failure.dart';
import 'package:igshark/domain/repositories/firebase/firebase_repository.dart';
import 'package:igshark/domain/repositories/instagram/instagram_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import '../entities/account_info.dart';
import '../entities/ig_headers.dart';
import '../entities/user.dart';

class UpdateUserUseCase {
  final FirebaseRepository firebaseRepository;
  final InstagramRepository instagramRepository;

  UpdateUserUseCase({required this.firebaseRepository, required this.instagramRepository});

  Future<Either<Failure, Unit>> execute(
      {required User currentUser, required AccountInfo accountInfo, required IgHeaders igHeaders}) async {
    // TODO: check if user is authenticated

    // update currentUser
    currentUser.igUserId = accountInfo.igUserId;
    currentUser.username = accountInfo.username;
    currentUser.contactPhoneNumber = accountInfo.contactPhoneNumber ?? "";
    currentUser.phoneCountryCode = accountInfo.phoneCountryCode ?? "";
    currentUser.publicPhoneNumber = accountInfo.publicPhoneNumber ?? "";
    currentUser.publicEmail = accountInfo.publicEmail ?? "";
    currentUser.picture = accountInfo.picture;
    currentUser.igHeaders = igHeaders;
    currentUser.igAuth = true;
    currentUser.isActive = true;
    currentUser.createdAt = FieldValue.serverTimestamp();
    currentUser.privateMessage = "";

    final Either<Failure, Unit> updateUserEither = await firebaseRepository.updateUser(user: currentUser);

    // failed to update user in Firestore
    if (updateUserEither.isLeft()) {
      return Left((updateUserEither as Left).value);
    }

    // user successfully updated in Firestore
    return Right((updateUserEither as Right).value);
  }
}
