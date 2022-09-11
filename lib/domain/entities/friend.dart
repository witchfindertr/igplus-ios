import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'friend.g.dart';

@HiveType(typeId: 0)
class Friend extends Equatable {
  static const String followersBoxKey = "followersBoxKey";
  static const String followingsBoxKey = "followingsBoxKey";
  static const String newFollowersBoxKey = "newFollowersBoxKey";
  static const String lostFollowersBoxKey = "lostFollowersBoxKey";
  static const String whoAdmiresYouBoxKey = "whoAdmiresYouBoxKey";
  static const String notFollowingBackBoxKey = "notFollowingBackBoxKey";
  static const String youDontFollowBackBoxKey = "youDontFollowBackBoxKey";
  static const String mutualFollowingsBoxKey = "mutualFollowingsBoxKey";
  static const String youHaveUnfollowedBoxKey = "youHaveUnfollowedBoxKey";
  static const String newStoryViewersBoxKey = "newStoryViewersBoxKey";

  @HiveField(0)
  final int igUserId;
  @HiveField(1)
  final String username;
  @HiveField(2)
  final String picture;
  @HiveField(3)
  final DateTime createdOn;

  const Friend({
    required this.igUserId,
    required this.username,
    required this.picture,
    required this.createdOn,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        igUserId,
        username,
        picture,
      ];
}
