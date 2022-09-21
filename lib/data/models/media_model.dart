import 'package:igplus_ios/data/models/friend_model.dart';
import 'package:igplus_ios/domain/entities/friend.dart';
import 'package:igplus_ios/domain/entities/media.dart';

class MediaModel {
  final int id;
  final String text;
  final int mediaType;
  final String url;
  final int commentsCount;
  final int likeCount;
  final int viewCount;
  final String createdAt;
  final List<Friend> topLikers;
  final DateTime updatedOn;

  MediaModel({
    required this.id,
    required this.text,
    required this.mediaType,
    required this.url,
    required this.commentsCount,
    required this.likeCount,
    required this.viewCount,
    required this.createdAt,
    required this.topLikers,
    required this.updatedOn,
  });

  factory MediaModel.fromJson(Map<String, dynamic> json) {
    int id = int.parse(json['pk']);
    int mediaType = json['media_type'];
    // media image url
    String mediaUrl = "";
    if (mediaType == 8) {
      mediaUrl = json['carousel_media'][0]['image_versions2']['candidates'][3]['url'];
    } else {
      mediaUrl = json['image_versions2']['candidates'][3]['url'];
    }
    String text = (json['caption'] != null) ? json['caption']['text'] : "";
    // media engagement count
    int commentsCount = json['comment_count'] ?? 0;
    int likeCount = json['like_count'] ?? 0;
    int viewCount = json['view_count'] ?? 0;
    String createdAt = json['taken_at'].toString();
    // likers list
    List<Friend> likers = [];
    for (var liker in json['facepile_top_likers']) {
      likers.add(FriendModel.fromJson(liker).toEntity());
    }
    DateTime updatedOn = DateTime.now();

    return MediaModel(
      id: id,
      text: text,
      mediaType: mediaType,
      url: mediaUrl,
      commentsCount: commentsCount,
      likeCount: likeCount,
      viewCount: viewCount,
      createdAt: createdAt,
      topLikers: likers,
      updatedOn: updatedOn,
    );
  }

  Media toEntity() {
    return Media(
      id: id,
      text: text,
      mediaType: mediaType,
      url: url,
      commentsCount: commentsCount,
      likeCount: likeCount,
      viewCount: viewCount,
      createdAt: createdAt,
      topLikers: topLikers,
      updatedOn: updatedOn,
    );
  }
}
