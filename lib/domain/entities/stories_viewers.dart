import 'package:igplus_ios/domain/entities/friend.dart';
import 'package:igplus_ios/domain/entities/story_viewer.dart';

class StoriesViewer {
  final String id;
  final int viewsCount;
  final bool hasLiked;
  final bool followedBy;
  final bool following;
  final List<String> mediaIdsList;
  final Friend user;

  StoriesViewer({
    required this.id,
    required this.viewsCount,
    required this.hasLiked,
    required this.followedBy,
    required this.following,
    required this.mediaIdsList,
    required this.user,
  });
}
