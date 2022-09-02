import 'package:dartz/dartz.dart';
import 'package:igplus_ios/domain/entities/user.dart';

import '../../../data/failure.dart';
import '../../entities/account_info.dart';
import '../../entities/ig_headers.dart';

abstract class FirebaseRepository {
  Future<Either<Failure, Unit>> createUser({required User user});
  Future<Either<Failure, Unit>> updateUser({required User user});

  Future<Either<Failure, User>> getUser({required String userId});

  // get current user
  Future<Either<Failure, User>> getCurrentUser();

  // user authenticated and not blocked
  Future<Either<Failure, User>> validateUser({required String userId});
}
