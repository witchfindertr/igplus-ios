import 'package:igplus_ios/domain/entities/media_liker.dart';
import 'package:igplus_ios/domain/entities/media_likers.dart';

class MediaLikersModel {
  final String id;
  final int likesCount;
  final bool followedBy; // followed me
  final bool following; // i follow
  final List<MediaLiker> mediaLikerList;

  MediaLikersModel({
    required this.id,
    required this.likesCount,
    required this.followedBy,
    required this.following,
    required this.mediaLikerList,
  });

  factory MediaLikersModel.fromMediaLiker(List<MediaLiker> mediaLikerList, String userId, followedBy, following) {
    return MediaLikersModel(
      id: userId,
      likesCount: mediaLikerList.length,
      followedBy: followedBy,
      following: following,
      mediaLikerList: mediaLikerList,
    );
  }

  // to entity
  MediaLikers toEntity() {
    return MediaLikers(
      id: id,
      likesCount: likesCount,
      followedBy: followedBy,
      following: following,
      mediaLikerList: mediaLikerList,
    );
  }
}
