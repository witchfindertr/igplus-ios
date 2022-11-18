import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:igshark/data/models/ig_headers_model.dart';
import 'package:igshark/data/repositories/firebase/headers_repository_imp.dart';
import 'package:igshark/domain/entities/ig_headers.dart';
import 'package:igshark/domain/repositories/firebase/headers_repository.dart';
import 'package:mockito/mockito.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MockFirebaseDataSource firebaseDataSource;
  late HeadersRepository headersRepository;

  setUp(() {
    firebaseDataSource = MockFirebaseDataSource();
    headersRepository = HeadersRepositoryImp(firebaseDataSource: firebaseDataSource);
  });

  final testIgHeadersModel = IgHeadersModel(
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

  final testIgHeaders = IgHeaders(
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

  group('get headers', () {
    test('should return latest headers from firebase data source when igAuth == false', () async {
      // arrange
      when(firebaseDataSource.getLatestHeaders()).thenAnswer((_) async => testIgHeadersModel);
      // act
      final result = await headersRepository.getHeaders();

      // assert
      verify(firebaseDataSource.getLatestHeaders());
      expect(result, equals(Right(testIgHeaders)));
    });
  });
}
