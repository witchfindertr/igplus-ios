import 'package:dartz/dartz.dart';
import 'package:igplus_ios/domain/repositories/firebase/firebase_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import '../../data/failure.dart';
import '../entities/user.dart';

class AuthorizeUser {
  final FirebaseRepository firebaseRepository;

  AuthorizeUser({required this.firebaseRepository});

  Future<Either<Failure, User>> execute() async {
    auth.User? currentUser = auth.FirebaseAuth.instance.currentUser;

    // user is not authentucated
    if (currentUser == null) {
      return const Left(ServerFailure("user not authenticated"));
    }

    // user is authenticated and not blocked
    return await firebaseRepository.validateUser(userId: currentUser.uid);
  }
}
