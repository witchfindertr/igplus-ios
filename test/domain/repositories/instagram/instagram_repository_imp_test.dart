// import 'package:dartz/dartz.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:igplus_ios/data/failure.dart';
// import 'package:igplus_ios/data/models/account_info_model.dart';
// import 'package:igplus_ios/data/repositories/instagram/instagram_repository_imp.dart';
// import 'package:igplus_ios/domain/entities/account_info.dart';
// import 'package:igplus_ios/domain/entities/ig_headers.dart';
// import 'package:igplus_ios/domain/repositories/instagram/instagram_repository.dart';
// import 'package:mockito/mockito.dart';

// import '../../../helpers/test_helper.mocks.dart';

// void main() {
//   late MockInstagramDataSource mockInstagramDataSource;
//   late InstagramRepository instagramRepository;

//   setUp(() {
//     mockInstagramDataSource = MockInstagramDataSource();
//     instagramRepository = InstagramRepositoryImp(instagramDataSource: mockInstagramDataSource);
//   });

//   final AccountInfoModel testAccountInfoModel = AccountInfoModel(
//     igUserId: "54306109719",
//     username: "ayman_26a",
//     isPrivate: false,
//     picture:
//         "https://instagram.ffez2-2.fna.fbcdn.net/v/t51.2885-19/295774332_463034745234587_5831000511722660987_n.jpg?stp=dst-jpg_s150x150&_nc_ht=instagram.ffez2-2.fna.fbcdn.net&_nc_cat=111&_nc_ohc=72ZBx_YnFs4AX8TjKDJ&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AT-POOw4vL9CPhfkp16QGOqc1ry-AaYTVf18BTdx4Z5bpg&oe=62E66064&_nc_sid=8fd12b",
//     followers: 203,
//     followings: 558,
//     contactPhoneNumber: "",
//     publicPhoneNumber: "",
//     phoneCountryCode: "",
//     publicEmail: "",
//   );

//   const testAccountInfo = AccountInfo(
//     igUserId: "54306109719",
//     username: "ayman_26a",
//     isPrivate: false,
//     picture:
//         "https://instagram.ffez2-2.fna.fbcdn.net/v/t51.2885-19/295774332_463034745234587_5831000511722660987_n.jpg?stp=dst-jpg_s150x150&_nc_ht=instagram.ffez2-2.fna.fbcdn.net&_nc_cat=111&_nc_ohc=72ZBx_YnFs4AX8TjKDJ&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AT-POOw4vL9CPhfkp16QGOqc1ry-AaYTVf18BTdx4Z5bpg&oe=62E66064&_nc_sid=8fd12b",
//     followers: 203,
//     followings: 558,
//   );

//   final testHeaders = IgHeaders(
//     userAgent:
//         'Mozilla/5.0 (Linux; Android 9; Redmi Note 8 Pro Build/PPR1.180610.011; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/101.0.4951.61 Mobile Safari/537.36',
//     cookie: 'sessionid=2728720115%3Afux9lhzGjD8ESf%3A11',
//     accept: 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
//     acceptEncoding: 'gzip, deflate, br',
//     acceptLanguage: 'en-US,en;q=0.5',
//     upgradeInsecureRequests: '1',
//     XIGAppID: '936619743392459',
//     XCSRFToken: '0fRjvDxa1IMmqLxokwSCERUV2savdxmc',
//   );

//   group('get account info by username', () {
//     const testUsername = 'ayman_26a';

//     test('should return AccountInfo entity when a call to instagram data source is successful', () async {
//       // arrange
//       when(mockInstagramDataSource.getAccountInfoByUsername(username: testUsername))
//           .thenAnswer((_) async => testAccountInfoModel);

//       // act

//       final result = await instagramRepository.getAccountInfo(username: testUsername, igHeaders: testHeaders);

//       // assert
//       verify(mockInstagramDataSource.getAccountInfoByUsername(username: testUsername));
//       expect(result, equals(const Right(testAccountInfo)));
//     });

//     test('should return server failure when a call to instagram data source is unsuccssful', () async {
//       // arrange
//       when(mockInstagramDataSource.getAccountInfoByUsername(username: testUsername)).thenThrow(const ServerFailure(''));

//       // act
//       final result = await instagramRepository.getAccountInfo(username: testUsername, igHeaders: testHeaders);

//       // assert
//       verify(mockInstagramDataSource.getAccountInfoByUsername(username: testUsername));
//       expect(result, equals(const Left(ServerFailure(''))));
//     });
//   });

//   group('get account info by id', () {
//     const testIgUserId = '54306109719';

//     test('should return AccountInfo entity when a call to instagram data source is successful', () async {
//       // arrange
//       when(mockInstagramDataSource.getAccountInfoById(igUserId: testIgUserId))
//           .thenAnswer((_) async => testAccountInfoModel);

//       // act

//       final result = await instagramRepository.getAccountInfo(igUserId: testIgUserId, igHeaders: testHeaders);

//       // assert
//       verify(mockInstagramDataSource.getAccountInfoById(igUserId: testIgUserId));
//       expect(result, equals(Right(testAccountInfo)));
//     });

//     test('should return server failure when a call to instagram data source is unsuccssful', () async {
//       // arrange
//       when(mockInstagramDataSource.getAccountInfoById(igUserId: testIgUserId)).thenThrow(const ServerFailure(''));

//       // act
//       final result = await instagramRepository.getAccountInfo(igUserId: testIgUserId, igHeaders: testHeaders);

//       // assert
//       verify(mockInstagramDataSource.getAccountInfoById(igUserId: testIgUserId));
//       expect(result, equals(const Left(ServerFailure(''))));
//     });
//   });

//   // group('get new followers', () {
//   //   test('should return list of Friend entity  when call to instagram data source is successful', () {
//   //     // arrange
//   //     when(mockInstagramDataSource.getNewFollowers()).thenAnswer((_) => Future.value(List<FriendModel>()));
//   //   });
//   // });
// }
