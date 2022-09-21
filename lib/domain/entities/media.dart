import 'package:equatable/equatable.dart';
import 'package:igplus_ios/domain/entities/friend.dart';
import 'package:hive/hive.dart';

part 'media.g.dart';

@HiveType(typeId: 2)
class Media extends Equatable {
  static const String boxKey = "mediaBoxKey";

  @HiveField(0)
  final int id;
  @HiveField(1)
  final String text;
  @HiveField(2)
  final int mediaType;
  @HiveField(3)
  final String url;
  @HiveField(4)
  final int commentsCount;
  @HiveField(5)
  final int likeCount;
  @HiveField(6)
  final int viewCount;
  @HiveField(7)
  final String createdAt;
  @HiveField(8)
  final List<Friend> topLikers;
  @HiveField(9)
  final DateTime updatedOn;

  const Media({
    required this.id,
    required this.text,
    required this.mediaType,
    required this.url,
    required this.commentsCount,
    required this.likeCount,
    required this.viewCount,
    required this.createdAt,
    required this.topLikers,
    required this.updatedOn,
  });

  @override
  List<Object?> get props => [
        id,
        text,
        mediaType,
        url,
        commentsCount,
        likeCount,
        viewCount,
        createdAt,
        topLikers,
        updatedOn,
      ];
}
