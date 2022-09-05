import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:igplus_ios/data/constants.dart';
import 'package:igplus_ios/data/failure.dart';
import 'package:igplus_ios/data/models/account_info_model.dart';
import 'package:igplus_ios/data/sources/instagram/instagram_data_source.dart';
import 'package:igplus_ios/domain/entities/ig_headers.dart';
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

  final testHeaders = IgHeaders(
    userAgent:
        'Mozilla/5.0 (Linux; Android 9; Redmi Note 8 Pro Build/PPR1.180610.011; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/101.0.4951.61 Mobile Safari/537.36',
    cookie: 'sessionid=2728720115%3Afux9lhzGjD8ESf%3A11',
    accept: 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
    acceptEncoding: 'gzip, deflate, br',
    acceptLanguage: 'en-US,en;q=0.5',
    upgradeInsecureRequests: '1',
    XIGAppID: '936619743392459',
    XCSRFToken: '0fRjvDxa1IMmqLxokwSCERUV2savdxmc',
  );

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

        final result = await dataSource.getAccountInfoByUsername(username: testUsername, headers: testHeaders.toMap());

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
      final call = dataSource.getAccountInfoByUsername(username: testUsername, headers: testHeaders.toMap());
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

        final result = await dataSource.getAccountInfoById(igUserId: testIgUserId, headers: testHeaders.toMap());

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
      final call = dataSource.getAccountInfoById(igUserId: testIgUserId, headers: testHeaders.toMap());
      // assert
      expect(call, throwsA(isA<ServerFailure>()));
    });
  });
}
