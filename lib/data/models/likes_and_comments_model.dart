import 'package:igplus_ios/domain/entities/friend.dart';
import 'package:igplus_ios/domain/entities/likes_and_comments.dart';
import 'package:igplus_ios/domain/entities/media_commenters.dart';
import 'package:igplus_ios/domain/entities/media_likers.dart';

class LikesAndCommentsModel {
  final int total;
  final int likesCount;
  final int commentsCount;
  final bool followedBy; // followed me
  final bool following; // i follow
  final Friend user;

  LikesAndCommentsModel({
    required this.total,
    required this.user,
    required this.followedBy,
    required this.following,
    required this.likesCount,
    required this.commentsCount,
  });

  factory LikesAndCommentsModel.fromMediaLikersAndCommenters(
      MediaLikers mediaLikers, MediaCommenters? mediaCommenters) {
    int total = 0;
    if (mediaLikers.likesCount > 0) {
      total = mediaLikers.likesCount;
    }
    if (mediaCommenters != null && mediaCommenters.commentsCount > 0) {
      total = total + mediaCommenters.commentsCount;
    }

    return LikesAndCommentsModel(
      total: total,
      likesCount: mediaLikers.likesCount,
      commentsCount: mediaCommenters != null ? mediaCommenters.commentsCount : 0,
      followedBy: mediaLikers.followedBy,
      following: mediaLikers.following,
      user: mediaLikers.mediaLikerList.first.user,
    );
  }

  // to entity
  LikesAndComments toEntity() {
    return LikesAndComments(
      total: total,
      likesCount: likesCount,
      commentsCount: commentsCount,
      followedBy: followedBy,
      following: following,
      user: user,
    );
  }
}
