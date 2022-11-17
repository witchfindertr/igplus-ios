import 'package:igshark/domain/entities/friend.dart';
import 'package:hive/hive.dart';

part 'story_viewer.g.dart';

@HiveType(typeId: 8)
class StoryViewer {
  static const boxKey = 'storyViewersBoxKey';

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String mediaId;
  @HiveField(2)
  final bool hasLiked;
  @HiveField(3)
  final bool followedBy; // followed me
  @HiveField(4)
  final bool following; // i follow
  @HiveField(5)
  final Friend user;

  StoryViewer({
    required this.id,
    required this.mediaId,
    required this.hasLiked,
    required this.followedBy,
    required this.following,
    required this.user,
  });
}
