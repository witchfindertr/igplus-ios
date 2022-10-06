import 'package:igplus_ios/data/models/friend_model.dart';
import 'package:igplus_ios/domain/entities/media_liker.dart';

class MediaLikerModel {
  final String id;
  final int mediaId;
  final FriendModel user;

  MediaLikerModel({
    required this.id,
    required this.mediaId,
    required this.user,
  });

  factory MediaLikerModel.fromJson(Map<String, dynamic> userJson, mediaId) {
    return MediaLikerModel(
      id: "${mediaId}_${userJson['pk']}",
      mediaId: mediaId,
      user: FriendModel.fromJson(userJson),
    );
  }

  // to entity
  MediaLiker toEntity() {
    return MediaLiker(
      id: id,
      mediaId: mediaId,
      user: user.toEntity(),
    );
  }
}
