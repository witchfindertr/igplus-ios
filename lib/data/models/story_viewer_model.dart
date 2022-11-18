import 'package:igshark/data/models/friend_model.dart';
import 'package:igshark/domain/entities/story_viewer.dart';

class StoryViewerModel {
  final String id;
  final String mediaId;
  final bool hasLiked;
  final bool followedBy; // followed me
  final bool following; // i follow
  final FriendModel user;

  StoryViewerModel({
    required this.id,
    required this.mediaId,
    required this.hasLiked,
    required this.followedBy,
    required this.following,
    required this.user,
  });

  factory StoryViewerModel.fromJson(Map<String, dynamic> json, String mediaId) {
    return StoryViewerModel(
      id: "${mediaId}_${json['user']['pk']}",
      mediaId: mediaId,
      hasLiked: json['has_liked'],
      followedBy: json['user']['friendship_status']['followed_by'],
      following: json['user']['friendship_status']['following'],
      user: FriendModel.fromJson(json['user']),
    );
  }

  // from StoryViewer
  factory StoryViewerModel.fromEntity(StoryViewer entity) {
    return StoryViewerModel(
      id: entity.id,
      mediaId: entity.mediaId,
      hasLiked: entity.hasLiked,
      followedBy: entity.followedBy,
      following: entity.following,
      user: FriendModel.fromEntity(entity.user),
    );
  }

  StoryViewer toEntity() {
    return StoryViewer(
      id: id,
      mediaId: mediaId,
      hasLiked: hasLiked,
      followedBy: followedBy,
      following: following,
      user: user.toEntity(),
    );
  }
}

// // StoryViewe mapper
// class StoryMapper implements EntityMapper<StoryViewerModel, StoryViewer> {
//   @override
//   StoryViewer mapToEntity(StoryViewerModel model) {
//     return StoryViewer(
//       id: model.id,
//       storyId: model.storyId,

//     );
//   }

//   // @override
//   // StoryViewerModel mapToModel(StoryViewer entity) {
//   //   return StoryViewerModel(
//   //   );
//   // }

//   List<StoryViewer> mapToEntityList(List<StoryViewerModel> modelList) {
//     return modelList.map((model) => mapToEntity(model)).toList();
//   }

//   List<StoryViewerModel> mapToModelList(List<StoryViewer> entityList) {
//     return entityList.map((entity) => mapToModel(entity)).toList();
//   }
// }
