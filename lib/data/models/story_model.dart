import 'package:equatable/equatable.dart';

import '../../app/constants/media_constants.dart';
import '../../domain/entities/entity_mapper.dart';
import '../../domain/entities/story.dart';

class StoryModel extends Equatable {
  final String mediaId;
  final int takenAt;
  final int mediaType;
  final String mediaUrl;
  const StoryModel({
    required this.mediaId,
    required this.takenAt,
    required this.mediaType,
    required this.mediaUrl,
  });

  // fromJson
  factory StoryModel.fromJson(Map<String, dynamic> json) {
    if (json['media_type'] == MediaConstants.MEDIA_TYPE_IMAGE) {
      return StoryModel(
        mediaId: json['id'].toString(),
        takenAt: json['taken_at'],
        mediaType: json['media_type'],
        mediaUrl: json['image_versions2']['candidates'][0]['url'],
      );
    } else if (json['media_type'] == MediaConstants.MEDIA_TYPE_VIDEO) {
      return StoryModel(
        mediaId: json['id'].toString(),
        takenAt: json['taken_at'],
        mediaType: json['media_type'],
        mediaUrl: json['video_versions'][0]['url'],
      );
    } else {
      throw Exception('Unknown media type');
    }
  }

  @override
  // TODO: implement props
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
    );
  }

  List<Story> mapToEntityList(List<StoryModel> modelList) {
    return modelList.map((model) => mapToEntity(model)).toList();
  }

  List<StoryModel> mapToModelList(List<Story> entityList) {
    return entityList.map((entity) => mapToModel(entity)).toList();
  }
}
