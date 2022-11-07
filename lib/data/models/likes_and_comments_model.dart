import 'package:igplus_ios/domain/entities/friend.dart';
import 'package:igplus_ios/domain/entities/likes_and_comments.dart';
import 'package:igplus_ios/domain/entities/media_commenters.dart';
import 'package:igplus_ios/domain/entities/media_likers.dart';

class LikesAndCommentsModel {
  final int total;
  final Friend user;
  LikesAndCommentsModel({required this.total, required this.user});

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
      user: mediaLikers.mediaLikerList.first.user,
    );
  }

  // to entity
  LikesAndComments toEntity() {
    return LikesAndComments(
      total: total,
      user: user,
    );
  }
}
