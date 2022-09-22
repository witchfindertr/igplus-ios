import 'package:dartz/dartz.dart';
import 'package:igplus_ios/domain/repositories/firebase/firebase_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import '../../data/failure.dart';
import '../entities/user.dart';

class AuthorizeUser {
  final FirebaseRepository firebaseRepository;

  AuthorizeUser({required this.firebaseRepository});

  Future<Either<Failure, User>> execute() async {
    final fbAuth = auth.FirebaseAuth.instance;
    auth.User? currentUser = fbAuth.currentUser;

    // user is not authenticated
    if (currentUser == null) {
      return const Left(ServerFailure("user not authenticated"));
    }

    // user is authenticated and not blocked
    Either<Failure, User> user = await firebaseRepository.validateUser(userId: currentUser.uid);

    return user;
  }
}
