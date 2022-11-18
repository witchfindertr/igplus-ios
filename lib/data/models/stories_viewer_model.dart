import 'package:igshark/domain/entities/friend.dart';
import 'package:igshark/domain/entities/stories_viewers.dart';
import 'package:igshark/domain/entities/story_viewer.dart';

class StoriesViewerModel {
  final String id;
  final int viewsCount;
  final bool hasLiked;
  final bool followedBy;
  final bool following;
  final List<String> mediaIdsList;
  final Friend user;

  StoriesViewerModel({
    required this.id,
    required this.viewsCount,
    required this.hasLiked,
    required this.followedBy,
    required this.following,
    required this.mediaIdsList,
    required this.user,
  });

  factory StoriesViewerModel.fromJson(List<StoryViewer> storyViewers) {
    List<String> mediaIdsList = [];
    for (var element in storyViewers) {
      mediaIdsList.add(element.mediaId);
    }
    return StoriesViewerModel(
      id: storyViewers.first.id.split('_')[2].toString(),
      viewsCount: storyViewers.length,
      hasLiked: storyViewers.first.hasLiked,
      followedBy: storyViewers.first.followedBy,
      following: storyViewers.first.following,
      mediaIdsList: mediaIdsList,
      user: storyViewers.first.user,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'viewsCount': viewsCount,
      'hasLiked': hasLiked,
      'followedBy': followedBy,
      'following': following,
      'mediaIdsList': mediaIdsList,
      'user': user,
    };
  }

  StoriesViewer toEntity() {
    return StoriesViewer(
      id: id,
      viewsCount: viewsCount,
      hasLiked: hasLiked,
      followedBy: followedBy,
      following: following,
      mediaIdsList: mediaIdsList,
      user: user,
    );
  }
}
