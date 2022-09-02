import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:igplus_ios/data/constants.dart';
import 'package:igplus_ios/data/models/ig_headers_model.dart';
import 'package:igplus_ios/data/sources/firebase/firebase_data_source.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/json_reader.dart';
import '../../../helpers/test_helper.mocks.dart';
import 'package:http/http.dart' as http;

void main() {
  late MockHttpClient mockHttpClient;
  late FirebaseDataSource firebaseDataSource;

  final IgHeadersModel testIgHeadersModel = IgHeadersModel(
    XCSRFToken: "RMVRbj5XKGXhY2iQ0ynNNxpwbRFi2b3J",
    cookie: "sessionid=54561977357%3AlXMYN885Ab3PiG%3A12%3AAYeQSNiv0Qn2aDnTTCxlLT6h-MhLArjO9ZiUL4vNVw",
    XIGAppID: "936619743392459",
    userAgent:
        "Mozilla/5.0 (Linux; Android 11; TECNO KF7j Build/RP1A.200720.011; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/98.0.4758.101 Mobile Safari/537.36",
    acceptEncoding: "gzip, deflate, br",
    acceptLanguage: "en-US,en;q=0.5",
    upgradeInsecureRequests: "1",
    accept: "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
  );

  setUp(() async {
    mockHttpClient = MockHttpClient();
    firebaseDataSource = FirebaseDataSourceImp(client: mockHttpClient);
  });

  group('get Latest headers from firebase', () {
    test('should get latest headers from firebase', () async {
      // arrange
      when(mockHttpClient.get(Uri.parse(FirebaseFunctionsUrls.baseUrl))).thenAnswer(
          (_) async => http.Response(readJson('helpers/dummy_data/dummy_latest_headers_response.json'), 200, headers: {
                HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
              }));
      // act
      final result = await firebaseDataSource.getLatestHeaders();
      // assert
      expect(result, equals(testIgHeadersModel));
    });
  });
}
