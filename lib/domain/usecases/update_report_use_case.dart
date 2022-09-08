import 'package:dartz/dartz.dart';

import 'package:igplus_ios/domain/entities/account_info.dart';
import 'package:igplus_ios/domain/entities/friend.dart';
import 'package:igplus_ios/domain/repositories/local/local_repository.dart';
import 'package:intl/intl.dart';
import '../../data/failure.dart';
import '../entities/report.dart';
import '../entities/user.dart';
import '../repositories/instagram/instagram_repository.dart';

class UpdateReportUseCase {
  final InstagramRepository instagramRepository;
  final LocalRepository localRepository;

  UpdateReportUseCase({
    required this.instagramRepository,
    required this.localRepository,
  });

  Future<Either<Failure, Report>> execute({required User currentUser, required AccountInfo accountInfo}) async {
    // get old data from local ------------->
    final List<Friend>? cachedFollowers;
    final List<Friend>? cachedFollowings;
    final Report? cachedReport;
    // get Cached followers list from local
    final failureOrFollowersListFromLocal = localRepository.getCachedFriendsList(boxKey: Friend.followersBoxKey);
    if (failureOrFollowersListFromLocal.isRight()) {
      cachedFollowers = (failureOrFollowersListFromLocal as Right).value;
    } else {
      cachedFollowers = null;
    }
    // get Cached followings list from local
    final failureOrFollowingsListFromLocal = localRepository.getCachedFriendsList(boxKey: Friend.followingsBoxKey);
    if (failureOrFollowingsListFromLocal.isRight()) {
      cachedFollowings = (failureOrFollowingsListFromLocal as Right).value;
    } else {
      cachedFollowings = null;
    }
    // get cached report from local
    final failureOrReportFromLocal = localRepository.getCachedReport();
    if (failureOrReportFromLocal.isRight()) {
      cachedReport = (failureOrReportFromLocal as Right).value;
    } else {
      cachedReport = null;
    }

    // get followings list from instagram ----->
    final Either<Failure, List<Friend>> followingsEither =
        await instagramRepository.getFollowings(igUserId: accountInfo.igUserId, igHeaders: currentUser.igHeaders);
    if (followingsEither.isLeft()) {
      return Left((followingsEither as Left).value);
    }
    final List<Friend> followings = (followingsEither as Right).value;

    // save followings to local
    await localRepository.cacheFriendsList(friendsList: followings, boxKey: Friend.followingsBoxKey);

    // get followers list from instagram ----->
    final Either<Failure, List<Friend>> followersEither =
        await instagramRepository.getFollowers(igUserId: accountInfo.igUserId, igHeaders: currentUser.igHeaders);
    if (followersEither.isLeft()) {
      return Left((followersEither as Left).value);
    }
    final List<Friend> followers = (followersEither as Right).value;

    // save followers to local
    await localRepository.cacheFriendsList(friendsList: followers, boxKey: Friend.followersBoxKey);

    // list of friends that are not in the followers list
    final List<Friend> notFollowingMeBack = followings.where((friend) => !followers.contains(friend)).toList();

    // list of friends that are not in the followings list
    final List<Friend> iamNotFollowingBack = followers.where((friend) => !followings.contains(friend)).toList();

    // list of friends that are in both lists
    final List<Friend> mutualFollowing = followers.where((friend) => followings.contains(friend)).toList();

    // initialize chart data
    String today =
        DateFormat('M/d/yy').format(DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch));
    late final List<ChartData> followersChartData;
    late final List<ChartData> followingsChartData;
    late final List<ChartData> newFollowersChartData;
    late final List<ChartData> lostFollowersChartData;

    // if there is no cached report, initialize chart data else puch new data ------->
    // followers chart data
    if (cachedReport == null || cachedReport.followersChartData.isEmpty) {
      followersChartData = [ChartData(date: today, value: accountInfo.followers)];
    } else {
      followersChartData = cachedReport.followersChartData;
      if (followersChartData.last.date != today) {
        followersChartData.add(ChartData(date: today, value: accountInfo.followers));
      } else {
        followersChartData.last.value = accountInfo.followers;
      }
    }
    // followings chart data
    if (cachedReport == null || cachedReport.followingsChartData.isEmpty) {
      followingsChartData = [ChartData(date: today, value: accountInfo.followings)];
    } else {
      followingsChartData = cachedReport.followingsChartData;
      if (followingsChartData.last.date != today) {
        followingsChartData.add(ChartData(date: today, value: accountInfo.followings));
      } else {
        followingsChartData.last.value = accountInfo.followings;
      }
    }
    // new followers chart data
    if (cachedReport == null || cachedReport.newFollowersChartData.isEmpty) {
      newFollowersChartData = [ChartData(date: today, value: 0)];
    } else {
      newFollowersChartData = cachedReport.newFollowersChartData;
      if (newFollowersChartData.last.date != today) {
        newFollowersChartData.add(ChartData(date: today, value: 0));
      } else {
        newFollowersChartData.last.value = 0;
      }
    }
    // lost followers chart data
    if (cachedReport == null || cachedReport.lostFollowersChartData.isEmpty) {
      lostFollowersChartData = [ChartData(date: today, value: 0)];
    } else {
      lostFollowersChartData = cachedReport.lostFollowersChartData;
      if (lostFollowersChartData.last.date != today) {
        lostFollowersChartData.add(ChartData(date: today, value: 0));
      } else {
        lostFollowersChartData.last.value = 0;
      }
    }

    // new followers and lost followers
    //TODO : To be verified and tested
    List<Friend> newFollowersList = [];
    List<Friend> lostFollowersList = [];
    if (cachedFollowers != null) {
      newFollowersList = followers.where((friend) => !cachedFollowers!.contains(friend)).toList();
      lostFollowersList = cachedFollowers.where((friend) => !followers.contains(friend)).toList();
    }

    final Report report = Report(
      followers: accountInfo.followers,
      followings: accountInfo.followings,
      // photo: accountInfo.photo,
      // video: accountInfo.video,
      // totalLikes: accountInfo.totalLikes,
      // totalComments: accountInfo.totalComments,
      notFollowingMeBack: notFollowingMeBack.length,
      iamNotFollowingBack: iamNotFollowingBack.length,
      mutualFollowing: mutualFollowing.length,
      followersChartData: followersChartData,
      followingsChartData: followingsChartData,
      newFollowersChartData: newFollowersChartData,
      lostFollowersChartData: lostFollowersChartData,
    );

    // save report to local
    await localRepository.cacheReport(report: report);

    return Right(report);
  }
}
