import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:igplus_ios/data/failure.dart';
import 'package:igplus_ios/data/models/account_info_model.dart';
import 'package:igplus_ios/data/repositories/instagram/instagram_repository_imp.dart';
import 'package:igplus_ios/domain/entities/account_info.dart';
import 'package:igplus_ios/domain/repositories/instagram/instagram_repository.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockInstagramDataSource mockInstagramDataSource;
  late InstagramRepository instagramRepository;

  setUp(() {
    mockInstagramDataSource = MockInstagramDataSource();
    instagramRepository = InstagramRepositoryImp(instagramDataSource: mockInstagramDataSource);
  });

  final AccountInfoModel testAccountInfoModel = AccountInfoModel(
    igUserId: "54306109719",
    username: "ayman_26a",
    isPrivate: false,
    picture:
        "https://instagram.ffez2-2.fna.fbcdn.net/v/t51.2885-19/295774332_463034745234587_5831000511722660987_n.jpg?stp=dst-jpg_s150x150&_nc_ht=instagram.ffez2-2.fna.fbcdn.net&_nc_cat=111&_nc_ohc=72ZBx_YnFs4AX8TjKDJ&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AT-POOw4vL9CPhfkp16QGOqc1ry-AaYTVf18BTdx4Z5bpg&oe=62E66064&_nc_sid=8fd12b",
    followers: 203,
    following: 558,
    contactPhoneNumber: "",
    publicPhoneNumber: "",
    phoneCountryCode: "",
    publicEmail: "",
  );

  final testAccountInfo = AccountInfo(
    igUserId: "54306109719",
    username: "ayman_26a",
    isPrivate: false,
    picture:
        "https://instagram.ffez2-2.fna.fbcdn.net/v/t51.2885-19/295774332_463034745234587_5831000511722660987_n.jpg?stp=dst-jpg_s150x150&_nc_ht=instagram.ffez2-2.fna.fbcdn.net&_nc_cat=111&_nc_ohc=72ZBx_YnFs4AX8TjKDJ&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AT-POOw4vL9CPhfkp16QGOqc1ry-AaYTVf18BTdx4Z5bpg&oe=62E66064&_nc_sid=8fd12b",
    followers: 203,
    following: 558,
  );

  group('get account info by username', () {
    const testUsername = 'ayman_26a';

    test('should return AccountInfo entity when a call to instagram data source is successful', () async {
      // arrange
      when(mockInstagramDataSource.getAccountInfoByUsername(testUsername))
          .thenAnswer((_) async => testAccountInfoModel);

      // act

      final result = await instagramRepository.getAccountInfo(username: testUsername);

      // assert
      verify(mockInstagramDataSource.getAccountInfoByUsername(testUsername));
      expect(result, equals(Right(testAccountInfo)));
    });

    test('should return server failure when a call to instagram data source is unsuccssful', () async {
      // arrange
      when(mockInstagramDataSource.getAccountInfoByUsername(testUsername)).thenThrow(const ServerFailure(''));

      // act
      final result = await instagramRepository.getAccountInfo(username: testUsername);

      // assert
      verify(mockInstagramDataSource.getAccountInfoByUsername(testUsername));
      expect(result, equals(const Left(ServerFailure(''))));
    });
  });

  group('get account info by id', () {
    const testIgUserId = '54306109719';

    test('should return AccountInfo entity when a call to instagram data source is successful', () async {
      // arrange
      when(mockInstagramDataSource.getAccountInfoById(testIgUserId)).thenAnswer((_) async => testAccountInfoModel);

      // act

      final result = await instagramRepository.getAccountInfo(igUserId: testIgUserId);

      // assert
      verify(mockInstagramDataSource.getAccountInfoById(testIgUserId));
      expect(result, equals(Right(testAccountInfo)));
    });

    test('should return server failure when a call to instagram data source is unsuccssful', () async {
      // arrange
      when(mockInstagramDataSource.getAccountInfoById(testIgUserId)).thenThrow(const ServerFailure(''));

      // act
      final result = await instagramRepository.getAccountInfo(igUserId: testIgUserId);

      // assert
      verify(mockInstagramDataSource.getAccountInfoById(testIgUserId));
      expect(result, equals(const Left(ServerFailure(''))));
    });
  });

  // group('get new followers', () {
  //   test('should return list of Friend entity  when call to instagram data source is successful', () {
  //     // arrange
  //     when(mockInstagramDataSource.getNewFollowers()).thenAnswer((_) => Future.value(List<FriendModel>()));
  //   });
  // });
}
