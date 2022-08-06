import 'package:dartz/dartz.dart';

import 'package:igplus_ios/domain/entities/account_info.dart';
import 'package:igplus_ios/domain/entities/friend.dart';
import 'package:igplus_ios/domain/entities/ig_headers.dart';
import 'package:igplus_ios/domain/repositories/firebase/headers_repository.dart';

import '../../data/failure.dart';
import '../entities/report.dart';
import '../entities/user.dart';
import '../repositories/instagram/instagram_repository.dart';

class UpdateReportUseCase {
  final InstagramRepository instagramRepository;

  UpdateReportUseCase({
    required this.instagramRepository,
  });

  Future<Either<Failure, Report>> execute({required User currentUser, required AccountInfo accountInfo}) async {
    final Either<Failure, List<Friend>> followingsEither =
        await instagramRepository.getFollowings(igUserId: accountInfo.igUserId, igHeaders: currentUser.igHeaders);
    if (followingsEither.isLeft()) {
      return Left((followingsEither as Left).value);
    }

    // get followings Friends
    final List<Friend> followings = (followingsEither as Right).value;

    final Either<Failure, List<Friend>> followersEither =
        await instagramRepository.getFollowers(igUserId: accountInfo.igUserId, igHeaders: currentUser.igHeaders);
    if (followersEither.isLeft()) {
      return Left((followersEither as Left).value);
    }

    // get followers Friends
    final List<Friend> followers = (followersEither as Right).value;

    // list of friends that are not in the followers list
    final List<Friend> notFollowingMeBack = followings.where((friend) => !followers.contains(friend)).toList();

    // list of friends that are not in the followings list
    final List<Friend> iamNotFollowingBack = followers.where((friend) => !followings.contains(friend)).toList();

    // list of friends that are in both lists
    final List<Friend> mutualFollowing = followers.where((friend) => followings.contains(friend)).toList();
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
    );
    return Right(report);
  }
}
