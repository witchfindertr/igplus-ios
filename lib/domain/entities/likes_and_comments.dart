import 'package:igshark/domain/entities/friend.dart';
import 'package:hive/hive.dart';

part 'likes_and_comments.g.dart';

@HiveType(typeId: 11)
class LikesAndComments {
  static const String boxKey = "likesAndCommentsBoxkey";

  @HiveField(0)
  final int total;
  @HiveField(1)
  final int likesCount;
  @HiveField(2)
  final int commentsCount;
  @HiveField(3)
  final bool followedBy; // followed me
  @HiveField(4)
  final bool following; // i follow
  @HiveField(5)
  final Friend user;

  LikesAndComments({
    required this.total,
    required this.likesCount,
    required this.commentsCount,
    required this.followedBy,
    required this.following,
    required this.user,
  });
}
