import 'package:equatable/equatable.dart';
import 'package:igplus_ios/data/models/friend_model.dart';
import 'package:igplus_ios/domain/entities/friend.dart';

import '../../app/constants/media_constants.dart';
import '../../domain/entities/entity_mapper.dart';
import '../../domain/entities/story.dart';

class StoryModel extends Equatable {
  final String mediaId;
  final int takenAt;
  final int mediaType;
  final String mediaUrl;
  final String mediaThumbnailUrl;
  final int? viewersCount;
  final List<Friend> viewers;
  const StoryModel({
    required this.mediaId,
    required this.takenAt,
    required this.mediaType,
    required this.mediaUrl,
    required this.mediaThumbnailUrl,
    this.viewersCount,
    this.viewers = const [],
  });

  // fromJson
  factory StoryModel.fromJson(Map<String, dynamic> json) {
    // get story viewers
    final List<Friend> viewers = [];
    if (json['viewers'] != null) {
      for (var viewer in json['viewers']) {
        viewers.add(FriendModel.fromJson(viewer).toEntity());
      }
    }
    if (json['media_type'] == MediaConstants.MEDIA_TYPE_IMAGE) {
      StoryModel storyModel = StoryModel(
        mediaId: json['id'].toString(),
        takenAt: json['taken_at'],
        mediaType: json['media_type'],
        mediaUrl: json['image_versions2']['candidates'][0]['url'],
        mediaThumbnailUrl: json['image_versions2']['candidates'][0]['url'] ?? "",
        viewersCount: json['viewer_count'],
        viewers: viewers,
      );

      return storyModel;
    } else if (json['media_type'] == MediaConstants.MEDIA_TYPE_VIDEO) {
      return StoryModel(
        mediaId: json['id'].toString(),
        takenAt: json['taken_at'],
        mediaType: json['media_type'],
        mediaUrl: json['video_versions'][0]['url'],
        mediaThumbnailUrl: json['image_versions2']['candidates'][0]['url'] ?? "",
        viewersCount: json['viewer_count'],
        viewers: viewers,
      );
    } else {
      throw Exception('Unknown media type');
    }
  }

  @override
  List<Object?> get props => [mediaId, takenAt, mediaType, mediaUrl];
}

// story mapper
class StoryMapper implements EntityMapper<Story, StoryModel> {
  @override
  Story mapToEntity(StoryModel model) {
    return Story(
      mediaId: model.mediaId,
      takenAt: model.takenAt,
      mediaType:
          model.mediaType == MediaConstants.MEDIA_TYPE_IMAGE ? MediaConstants.TYPE_IMAGE : MediaConstants.TYPE_VIDEO,
      mediaUrl: model.mediaUrl,
      mediaThumbnailUrl: model.mediaThumbnailUrl,
      viewersCount: model.viewersCount,
      viewers: model.viewers,
    );
  }

  @override
  StoryModel mapToModel(Story entity) {
    return StoryModel(
      mediaId: entity.mediaId,
      takenAt: entity.takenAt,
      mediaType: entity.mediaType == MediaConstants.TYPE_IMAGE
          ? MediaConstants.MEDIA_TYPE_IMAGE
          : MediaConstants.MEDIA_TYPE_VIDEO,
      mediaUrl: entity.mediaUrl,
      mediaThumbnailUrl: entity.mediaThumbnailUrl,
      viewersCount: entity.viewersCount,
      viewers: entity.viewers,
    );
  }

  List<Story?> mapToEntityList(List<StoryModel?> modelList) {
    if (modelList.isEmpty) return [];
    return modelList.map((model) => mapToEntity(model!)).toList();
  }

  List<StoryModel> mapToModelList(List<Story> entityList) {
    return entityList.map((entity) => mapToModel(entity)).toList();
  }
}
