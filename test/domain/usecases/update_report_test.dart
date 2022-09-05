import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:igplus_ios/domain/entities/account_info.dart';
import 'package:igplus_ios/domain/entities/friend.dart';
import 'package:igplus_ios/domain/entities/report.dart';
import 'package:igplus_ios/domain/usecases/update_report_use_case.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockInstagramRepository instagramRepository;

  late UpdateReportUseCase usecase;

  setUp(() {
    instagramRepository = MockInstagramRepository();
    usecase = UpdateReportUseCase(
      instagramRepository: instagramRepository,
    );
  });

  final List<Friend> testFollowingsList = [
    Friend(igUserId: 1, username: "username1", picture: "picture"),
    Friend(igUserId: 2, username: "username2", picture: "picture"),
    Friend(igUserId: 3, username: "username3", picture: "picture"),
    Friend(igUserId: 4, username: "username4", picture: "picture"),
    Friend(igUserId: 5, username: "username5", picture: "picture"),
  ];

  final List<Friend> testFollowersList = [
    Friend(igUserId: 3, username: "username3", picture: "picture"),
    Friend(igUserId: 4, username: "username4", picture: "picture"),
    Friend(igUserId: 6, username: "username3", picture: "picture"),
    Friend(igUserId: 7, username: "username4", picture: "picture"),
  ];

  const AccountInfo testAccountInfo = AccountInfo(
    igUserId: "54306109719",
    username: "ayman_26a",
    isPrivate: false,
    picture:
        "https://instagram.ffez2-2.fna.fbcdn.net/v/t51.2885-19/295774332_463034745234587_5831000511722660987_n.jpg?stp=dst-jpg_s150x150&_nc_ht=instagram.ffez2-2.fna.fbcdn.net&_nc_cat=111&_nc_ohc=72ZBx_YnFs4AX8TjKDJ&edm=AOQ1c0wBAAAA&ccb=7-5&oh=00_AT-POOw4vL9CPhfkp16QGOqc1ry-AaYTVf18BTdx4Z5bpg&oe=62E66064&_nc_sid=8fd12b",
    followers: 4,
    followings: 5,
  );

  const Report testReport = Report(
    followers: 4,
    followings: 5,
    iamNotFollowingBack: 2,
    notFollowingMeBack: 3,
    mutualFollowing: 2,
  );

  setUp(() {
    instagramRepository = MockInstagramRepository();
    usecase = UpdateReportUseCase(
      instagramRepository: instagramRepository,
    );
  });
  test('should return a report ', () async {
    // arrange
    when(instagramRepository.getAccountInfo()).thenAnswer((_) async => const Right(testAccountInfo));
    when(instagramRepository.getFollowings(igUserId: testAccountInfo.igUserId))
        .thenAnswer((_) async => Right(testFollowingsList));
    when(instagramRepository.getFollowers(igUserId: testAccountInfo.igUserId))
        .thenAnswer((_) async => Right(testFollowersList));

    // act
    // final result = await usecase.execute();

    // assert
    //expect(result, equals(const Right(testReport)));
  });
}
