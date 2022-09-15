// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:igplus_ios/domain/entities/friend.dart';
// import 'package:igplus_ios/domain/entities/ig_headers.dart';
// import 'package:igplus_ios/domain/usecases/get_new_followers_use_case.dart';
// import 'package:mockito/mockito.dart';

// import '../../helpers/test_helper.mocks.dart';

// void main() {
//   late MockInstagramRepository instagramRepository;
//   late GetNewFollowersUseCase usecase;
//   setUp(() {
//     instagramRepository = MockInstagramRepository();
//     usecase = GetNewFollowersUseCase(
//       instagramRepository: instagramRepository,
//     );
//   });

//   final List<Friend> testFriendList = [
//     Friend(igUserId: 3222, username: "username", picture: "picture"),
//   ];

//   test('should return a List of new friends', () async {
//     // arrange
//     when(instagramRepository.getNewFollowers()).thenAnswer((_) async => Right(testFriendList));

//     // act
//     final result = await usecase.execute();

//     // assert
//     expect(result, equals(Right(testFriendList)));
//   });
// }
