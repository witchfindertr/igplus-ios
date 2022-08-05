import 'package:dartz/dartz.dart';

import '../../../data/failure.dart';
import '../../../data/sources/firebase/firebase_data_source.dart';

abstract class AuthRepository {
  Future<Either<Failure, Unit>> login();
}

// AuthRepositoryImp is a concrete implementation of AuthRepository
class AuthRepositoryImp implements AuthRepository {
  final FirebaseDataSource firebaseDataSource;

  AuthRepositoryImp({required this.firebaseDataSource});
  @override
  Future<Either<Failure, Unit>> login() async {
    final result = await firebaseDataSource.login();

    return Right(result);
  }
}
