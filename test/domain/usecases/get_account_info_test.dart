import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:igshark/domain/entities/account_info.dart';
import 'package:igshark/domain/entities/ig_headers.dart';
import 'package:igshark/domain/usecases/get_account_info_use_case.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockInstagramRepository instagramRepository;
  late GetAccountInfoUseCase usecase;

  setUp(() {
    instagramRepository = MockInstagramRepository();
    usecase = GetAccountInfoUseCase(
      instagramRepository: instagramRepository,
    );
  });

  const AccountInfo testAccountInfo = AccountInfo(
    igUserId: "54306109719",
    username: "ayman_26a",
    isPrivate: false,
    picture:
        "https://instagram.ffez2-2.fna.fbcdn.net/v/t51.2885-19/295774332_463034745234587_5831000511722660987_n.jpg?stp=dst-jpg_s150x150&_nc_ht=instagram.ffez2-2.fna.fbcdn.net&_nc_cat=111&_nc_ohc=72ZBx_YnFs4AX8TjKDJ&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AT-POOw4vL9CPhfkp16QGOqc1ry-AaYTVf18BTdx4Z5bpg&oe=62E66064&_nc_sid=8fd12b",
    followers: 203,
    followings: 558,
  );

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

  String testUsername = "ayman_26a";

  test('should get account info from the repository', () async {
    // arrange
    when(instagramRepository.getAccountInfo(
      username: testUsername,
    )).thenAnswer((_) async => Right(testAccountInfo));

    // act
    final result = await usecase.execute(username: testUsername, igHeaders: testHeaders);

    // assert
    expect(result, equals(const Right(testAccountInfo)));
  });
}
