// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:igshark/domain/usecases/login_use_case.dart';
// import 'package:mockito/mockito.dart';

// import '../../helpers/test_helper.mocks.dart';

// void main() {
//   group('LoginUseCase', () {
//     late LoginUseCase useCase;
//     late MockAuthRepository authRepository;

//     setUp(() {
//       authRepository = MockAuthRepository();
//       useCase = LoginUseCase(authRepository: authRepository);
//     });

//     test('should return unit when login ', () async {
//       // arrange
//       when(authRepository.login()).thenAnswer((_) async => const Right(unit));
//       // act
//       final result = await useCase.execute();

//       // assert

//       expect(result, const Right(unit));
//     });
//   });
// }
