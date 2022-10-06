import 'package:igplus_ios/domain/entities/media_liker.dart';

class MediaLikers {
  final String id;
  final int likesCount;
  final List<MediaLiker> mediaLikerList;

  MediaLikers({
    required this.id,
    required this.likesCount,
    required this.mediaLikerList,
  });
}
