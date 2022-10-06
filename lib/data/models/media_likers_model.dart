import 'package:igplus_ios/domain/entities/media_liker.dart';
import 'package:igplus_ios/domain/entities/media_likers.dart';

class MediaLikersModel {
  final String id;
  final int likesCount;
  final List<MediaLiker> mediaLikerList;

  MediaLikersModel({
    required this.id,
    required this.likesCount,
    required this.mediaLikerList,
  });

  factory MediaLikersModel.fromMediaLiker(List<MediaLiker> mediaLikerList, String userId) {
    return MediaLikersModel(
      id: userId,
      likesCount: mediaLikerList.length,
      mediaLikerList: mediaLikerList,
    );
  }

  // to entity
  MediaLikers toEntity() {
    return MediaLikers(
      id: id,
      likesCount: likesCount,
      mediaLikerList: mediaLikerList,
    );
  }
}
