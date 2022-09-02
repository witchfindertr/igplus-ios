import 'package:dartz/dartz.dart';

import '../../data/failure.dart';
import '../repositories/auth/auth_repository.dart';

class LoginUseCase {
  final AuthRepository authRepository;
  LoginUseCase({required this.authRepository});
  Future<Either<Failure, Unit>> execute() async {
    return await authRepository.login();
  }
}
