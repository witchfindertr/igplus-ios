import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:igplus_ios/data/constants.dart';
import 'package:igplus_ios/data/failure.dart';
import 'package:igplus_ios/data/models/account_info_model.dart';
import 'package:igplus_ios/data/sources/instagram/instagram_data_source.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/json_reader.dart';
import '../../../helpers/test_helper.mocks.dart';
import 'package:http/http.dart' as http;

void main() {
  late MockHttpClient mockHttpClient;
  late InstagramDataSource dataSource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = InstagramDataSourceImp(client: mockHttpClient);
  });

  group('get account info by username', () {
    const testUsername = 'ayman_26a';
    final testAccountInfoModel = AccountInfoModel.fromJsonByUsername(jsonDecode(
      readJson('helpers/dummy_data/dummy_account_info_by_username_response.json'),
    ));
    test(
      'should return AccountInfoModel when the response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(InstagramUrls.getAccountInfoByUsername(testUsername)))).thenAnswer(
            (_) async => http.Response(readJson('helpers/dummy_data/dummy_account_info_by_username_response.json'), 200,
                    headers: {
                      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
                    }));

        // act

        final result = await dataSource.getAccountInfoByUsername(testUsername);

        // assert

        expect(result, equals(testAccountInfoModel));
      },
    );

    test('should throw a server exception when the response code is not 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(InstagramUrls.getAccountInfoByUsername(testUsername))))
          .thenAnswer((_) async => http.Response(
                'not found',
                404,
              ));
      // act
      final call = dataSource.getAccountInfoByUsername(testUsername);
      // assert
      expect(call, throwsA(isA<ServerFailure>()));
    });
  });

  group('get account info by id', () {
    const testIgUserId = '54306109719';
    final testAccountInfoModel = AccountInfoModel.fromJsonById(jsonDecode(
      readJson('helpers/dummy_data/dummy_account_info_by_id_response.json'),
    ));
    test(
      'should return AccountInfoModel when the response code is 200',
      () async {
        // arrange
        when(mockHttpClient.get(Uri.parse(InstagramUrls.getAccountInfoById(testIgUserId)))).thenAnswer((_) async =>
            http.Response(readJson('helpers/dummy_data/dummy_account_info_by_id_response.json'), 200, headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            }));

        // act

        final result = await dataSource.getAccountInfoById(testIgUserId);

        // assert

        expect(result, equals(testAccountInfoModel));
      },
    );

    test('should throw a server exception when the response code is not 200', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(InstagramUrls.getAccountInfoById(testIgUserId))))
          .thenAnswer((_) async => http.Response(
                'not found',
                404,
              ));
      // act
      final call = dataSource.getAccountInfoById(testIgUserId);
      // assert
      expect(call, throwsA(isA<ServerFailure>()));
    });
  });
}
