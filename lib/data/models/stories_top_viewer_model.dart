import 'package:igplus_ios/domain/entities/friend.dart';
import 'package:igplus_ios/domain/entities/stories_top_viewers.dart';
import 'package:igplus_ios/domain/entities/story_viewer.dart';

class StoriesTopViewerModel {
  final String id;
  final int viewsCount;
  final bool hasLiked;
  final bool followedBy;
  final bool following;
  final List<String> mediaIdsList;
  final Friend user;

  StoriesTopViewerModel({
    required this.id,
    required this.viewsCount,
    required this.hasLiked,
    required this.followedBy,
    required this.following,
    required this.mediaIdsList,
    required this.user,
  });

  factory StoriesTopViewerModel.fromJson(List<StoryViewer> storyViewers) {
    List<String> mediaIdsList = [];
    for (var element in storyViewers) {
      mediaIdsList.add(element.mediaId);
    }
    return StoriesTopViewerModel(
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

  StoriesTopViewer toEntity() {
    return StoriesTopViewer(
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
