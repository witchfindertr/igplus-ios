import 'package:hive/hive.dart';
import 'package:igplus_ios/domain/entities/friend.dart';

part 'media_liker.g.dart';

@HiveType(typeId: 9)
class MediaLiker {
  static const boxKey = 'mediaLikersBoxKey';

  @HiveField(0)
  final String id;
  @HiveField(1)
  final int mediaId;
  @HiveField(2)
  final Friend user;

  MediaLiker({
    required this.id,
    required this.mediaId,
    required this.user,
  });
}
