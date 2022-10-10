import 'package:igplus_ios/data/models/friend_model.dart';
import 'package:igplus_ios/domain/entities/media_commenter.dart';

class MediaCommenterModel {
  final String id;
  final String mediaId;
  final int commentLikeCount;
  final int childCommentCount;
  final int createdAt;
  final String text;
  final bool hasLikedComment;
  final FriendModel user;

  MediaCommenterModel({
    required this.id,
    required this.mediaId,
    required this.commentLikeCount,
    required this.childCommentCount,
    required this.createdAt,
    required this.text,
    required this.hasLikedComment,
    required this.user,
  });

  factory MediaCommenterModel.fromJson(Map<String, dynamic> json, mediaId) {
    return MediaCommenterModel(
      id: "${mediaId}_${json['pk']}",
      mediaId: mediaId,
      commentLikeCount: json['comment_like_count'] ?? 0,
      childCommentCount: json['child_comment_count'] ?? 0,
      createdAt: json['created_at'],
      text: json['text'],
      hasLikedComment: json['has_liked_comment'] ?? false,
      user: FriendModel.fromJson(json['user']),
    );
  }

  // to entity
  MediaCommenter toEntity() {
    return MediaCommenter(
      id: id,
      mediaId: mediaId,
      user: user.toEntity(),
    );
  }
}
