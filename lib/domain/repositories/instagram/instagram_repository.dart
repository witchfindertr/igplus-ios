import 'package:dartz/dartz.dart';
import 'package:igplus_ios/domain/entities/User_story.dart';
import 'package:igplus_ios/domain/entities/friend.dart';
import 'package:igplus_ios/domain/entities/ig_headers.dart';

import '../../../data/failure.dart';
import '../../entities/account_info.dart';

abstract class InstagramRepository {
  Future<Either<Failure, AccountInfo>> getAccountInfo({
    String? username,
    String? igUserId,
    required IgHeaders igHeaders,
  });
  Future<Either<Failure, List<Friend>>> getFollowings({
    required String igUserId,
    required IgHeaders igHeaders,
    String? maxIdString,
  });
  Future<Either<Failure, List<Friend>>> getFollowers({
    required String igUserId,
    required IgHeaders igHeaders,
    String? maxIdString,
    required List<Friend> cachedFollowersList,
    required int newFollowersNumber,
  });

  // get active stories
  Future<Either<Failure, List<UserStory>>> getUserStories({
    required IgHeaders igHeaders,
  });
}
