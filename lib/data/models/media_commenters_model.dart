import 'package:igplus_ios/domain/entities/media_commenters.dart';
import 'package:igplus_ios/domain/entities/media_commenter.dart';

class MediaCommentersModel {
  final String id;
  final int commentsCount;
  final bool followedBy; // followed me
  final bool following; // i follow
  final List<MediaCommenter> mediaCommenterList;

  MediaCommentersModel({
    required this.id,
    required this.commentsCount,
    required this.followedBy,
    required this.following,
    required this.mediaCommenterList,
  });

  factory MediaCommentersModel.fromMediaCommenter(
      List<MediaCommenter> mediaCommenterList, String userId, followedBy, following) {
    return MediaCommentersModel(
      id: userId,
      commentsCount: mediaCommenterList.length,
      followedBy: followedBy,
      following: following,
      mediaCommenterList: mediaCommenterList,
    );
  }

  // to entity
  MediaCommenters toEntity() {
    return MediaCommenters(
      id: id,
      commentsCount: commentsCount,
      followedBy: followedBy,
      following: following,
      mediaCommenterList: mediaCommenterList,
    );
  }
}
