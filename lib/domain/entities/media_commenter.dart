import 'package:hive/hive.dart';
import 'package:igshark/domain/entities/friend.dart';

part 'media_commenter.g.dart';

@HiveType(typeId: 10)
class MediaCommenter {
  static const boxKey = 'mediaCommentersBoxKey';

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String mediaId;
  @HiveField(2)
  final Friend user;

  MediaCommenter({
    required this.id,
    required this.mediaId,
    required this.user,
  });
}
