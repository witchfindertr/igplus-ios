import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:igshark/domain/entities/ig_headers.dart';
import 'package:igshark/domain/usecases/get_headers_use_case.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockHeadersRepository headersRepository;
  late GetHeadersUseCase usecase;

  setUp(() {
    headersRepository = MockHeadersRepository();
    usecase = GetHeadersUseCase(
      headersRepository: headersRepository,
    );
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

  test('should get headers from the repository', () async {
    // arrange

    when(headersRepository.getHeaders()).thenAnswer((_) async => Right(testHeaders));

    // act

    final result = await usecase.execute();

    // assert

    expect(result, Right(testHeaders));
  });
}
