import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:igplus_ios/domain/entities/story.dart';

part 'stories_user.g.dart';

@HiveType(typeId: 6)
class StoriesUser extends Equatable {
  static const boxKey = 'storiesUserBoxKey';

  @HiveField(0)
  final StoryOwner owner;
  @HiveField(1)
  final String id;
  @HiveField(2)
  final int expiringAt;
  @HiveField(3)
  final int latestReelMedia;
  @HiveField(4)
  final int seen;
  @HiveField(5)
  List<Story> stories;

  StoriesUser({
    required this.owner,
    required this.id,
    required this.expiringAt,
    required this.latestReelMedia,
    required this.seen,
    required this.stories,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [owner, id, expiringAt, latestReelMedia, seen];
}

@HiveType(typeId: 5)
class StoryOwner extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String username;
  @HiveField(2)
  final String profilePicUrl;

  const StoryOwner({
    required this.id,
    required this.username,
    required this.profilePicUrl,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, username, profilePicUrl];
}
