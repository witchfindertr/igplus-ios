import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'story.g.dart';

@HiveType(typeId: 7)
class Story extends Equatable {
  static const boxKey = 'storiesBoxKey';

  @HiveField(0)
  final String mediaId;
  @HiveField(1)
  final int takenAt;
  @HiveField(2)
  final String mediaType;
  @HiveField(3)
  final String mediaUrl;

  const Story({
    required this.mediaId,
    required this.takenAt,
    required this.mediaType,
    required this.mediaUrl,
  });

  @override
  List<Object?> get props => [mediaId, takenAt, mediaType, mediaUrl];
}
