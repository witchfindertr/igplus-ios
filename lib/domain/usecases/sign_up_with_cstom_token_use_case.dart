import 'package:dartz/dartz.dart';

import '../../data/failure.dart';
import '../repositories/auth/auth_repository.dart';

class SignUpWithCustomTokenUseCase {
  final AuthRepository authRepository;

  SignUpWithCustomTokenUseCase(this.authRepository);

  Future<Either<Failure, Unit>> execute({required String uid}) async {
    return await authRepository.loginWithCustomToken(uid: uid);
  }
}
