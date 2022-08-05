import 'package:dartz/dartz.dart';

import 'package:igplus_ios/domain/entities/account_info.dart';
import 'package:igplus_ios/domain/entities/friend.dart';
import 'package:igplus_ios/domain/entities/ig_headers.dart';
import 'package:igplus_ios/domain/repositories/firebase/headers_repository.dart';

import '../../data/failure.dart';
import '../entities/report.dart';
import '../entities/user.dart';
import '../repositories/instagram/instagram_repository.dart';

class UpdateReport {
  final InstagramRepository instagramRepository;

  UpdateReport({
    required this.instagramRepository,
  });

  Future<Either<Failure, Report>> execute({required User currentUser}) async {
    final Either<Failure, AccountInfo> accountInfoEither =
        await instagramRepository.getAccountInfo(igHeaders: currentUser.igHeaders);

    if (accountInfoEither.isLeft()) {
      return Left((accountInfoEither as Left).value);
    }

    final AccountInfo accountInfo = (accountInfoEither as Right).value;

    final Either<Failure, List<Friend>> followingsEither =
        await instagramRepository.getFollowings(igUserId: accountInfo.igUserId);
    if (accountInfoEither.isLeft()) {
      return Left((followingsEither as Left).value);
    }

    final List<Friend> followings = (followingsEither as Right).value;

    final Either<Failure, List<Friend>> followersEither =
        await instagramRepository.getFollowers(igUserId: accountInfo.igUserId);
    if (accountInfoEither.isLeft()) {
      return Left((followersEither as Left).value);
    }
    if (accountInfoEither.isLeft()) {
      return Left((followersEither as Left).value);
    }

    final List<Friend> followers = (followersEither as Right).value;

    // list of friends that are not in the followers list
    final List<Friend> notFollowingMeBack = followings.where((friend) => !followers.contains(friend)).toList();

    // list of friends that are not in the followings list
    final List<Friend> iamNotFollowingBack = followers.where((friend) => !followings.contains(friend)).toList();

    // list of friends that are in both lists
    final List<Friend> mutualFollowing = followers.where((friend) => followings.contains(friend)).toList();

    return Right(
      Report(
        followers: accountInfo.followers,
        followings: accountInfo.followings,
        // photo: accountInfo.photo,
        // video: accountInfo.video,
        // totalLikes: accountInfo.totalLikes,
        // totalComments: accountInfo.totalComments,
        notFollowingMeBack: notFollowingMeBack.length,
        iamNotFollowingBack: iamNotFollowingBack.length,
        mutualFollowing: mutualFollowing.length,
      ),
    );
  }
}
