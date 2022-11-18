// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:igshark/domain/repositories/auth/auth_repository.dart';
// import 'package:mockito/mockito.dart';

// import '../../../helpers/test_helper.mocks.dart';

// void main() {
//   late MockFirebaseDataSource mockFirebaseDataSource;
//   late AuthRepository authRepository;

//   setUp(() {
//     mockFirebaseDataSource = MockFirebaseDataSource();
//     authRepository = AuthRepositoryImp(firebaseDataSource: mockFirebaseDataSource);
//   });

//   group('login', () {
//     test('should return unit value when the call to firebase data source is successfull', () async {
//       // arrange
//       when(mockFirebaseDataSource.login()).thenAnswer((_) async => unit);

//       // act
//       final result = await authRepository.login();
//       // assert

//       expect(result, const Right(unit));
//     });
//   });
// }
