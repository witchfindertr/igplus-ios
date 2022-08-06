import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:igplus_ios/domain/entities/account_info.dart';
import 'package:igplus_ios/domain/usecases/get_account_info_use_case.dart';
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

  String testUsername = "ayman_26a";

  test('should get account info from the repository', () async {
    // arrange
    when(instagramRepository.getAccountInfo(
      username: testUsername,
    )).thenAnswer((_) async => Right(testAccountInfo));

    // act
    final result = await usecase.execute(username: testUsername);

    // assert
    expect(result, equals(Right(testAccountInfo)));
  });
}
