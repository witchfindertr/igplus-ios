import 'package:equatable/equatable.dart';

class StoryOwner extends Equatable {
  final String id;
  final String username;
  final String profilePicUrl;
  StoryOwner({
    required this.id,
    required this.username,
    required this.profilePicUrl,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [id, username, profilePicUrl];
}

class UserStory extends Equatable {
  final StoryOwner owner;
  final String id;
  final int expiringAt;
  final int latestReelMedia;
  final int seen;
  UserStory({
    required this.owner,
    required this.id,
    required this.expiringAt,
    required this.latestReelMedia,
    required this.seen,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [owner, id, expiringAt, latestReelMedia, seen];
}
