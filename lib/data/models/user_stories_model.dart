import 'package:equatable/equatable.dart';
import 'package:igplus_ios/domain/entities/entity_mapper.dart';

import '../../domain/entities/User_story.dart';

class UserStoryModel extends Equatable {
  final String ownerId;
  final String ownerUsername;
  final String ownerPicUrl;
  final String id;
  final int expiringAt;
  final int latestReelMedia;
  final int seen;
  const UserStoryModel({
    required this.ownerId,
    required this.ownerUsername,
    required this.ownerPicUrl,
    required this.id,
    required this.expiringAt,
    required this.latestReelMedia,
    required this.seen,
  });

  // fromJson
  factory UserStoryModel.fromJson(Map<String, dynamic> json) {
    return UserStoryModel(
      ownerId: json['user']['pk'].toString(),
      ownerUsername: json['user']['username'],
      ownerPicUrl: json['user']['profile_pic_url'],
      id: json['id'].toString(),
      expiringAt: json['expiring_at'],
      latestReelMedia: json['latest_reel_media'],
      seen: json['seen'],
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [ownerId, ownerUsername, ownerPicUrl, id, expiringAt, latestReelMedia, seen];
}

// UserStoryMapper
class UserStoryMapper implements EntityMapper<UserStory, UserStoryModel> {
  @override
  UserStory mapToEntity(UserStoryModel model) {
    final storyOwner = StoryOwner(
      id: model.ownerId,
      username: model.ownerUsername,
      profilePicUrl: model.ownerPicUrl,
    );

    return UserStory(
      owner: storyOwner,
      id: model.id,
      expiringAt: model.expiringAt,
      latestReelMedia: model.latestReelMedia,
      seen: model.seen,
    );
  }

  @override
  UserStoryModel mapToModel(UserStory entity) {
    return UserStoryModel(
      ownerId: entity.owner.id,
      ownerUsername: entity.owner.username,
      ownerPicUrl: entity.owner.profilePicUrl,
      id: entity.id,
      expiringAt: entity.expiringAt,
      latestReelMedia: entity.latestReelMedia,
      seen: entity.seen,
    );
  }

  List<UserStory> mapToEntityList(List<UserStoryModel> models) {
    return models.map((model) => mapToEntity(model)).toList();
  }

  List<UserStoryModel> mapToModelList(List<UserStory> entities) {
    return entities.map((entity) => mapToModel(entity)).toList();
  }
}
