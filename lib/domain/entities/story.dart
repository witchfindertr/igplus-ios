import 'package:equatable/equatable.dart';

class Story extends Equatable {
  final String mediaId;
  final int takenAt;
  final String mediaType;
  final String mediaUrl;
  const Story({
    required this.mediaId,
    required this.takenAt,
    required this.mediaType,
    required this.mediaUrl,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [mediaId, takenAt, mediaType, mediaUrl];
}
