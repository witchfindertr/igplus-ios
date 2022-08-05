import 'package:dartz/dartz.dart';
import 'package:igplus_ios/domain/repositories/firebase/firebase_repository.dart';

import '../../data/failure.dart';
import '../entities/user.dart';

class GetUser {
  final FirebaseRepository firebaseRepository;
  GetUser({required this.firebaseRepository});

  Future<Either<Failure, User>> execute({String? userId}) async {
    if (userId == null) {
      return await firebaseRepository.getCurrentUser();
    } else {
      return await firebaseRepository.getUser(userId: userId);
    }
  }
}
