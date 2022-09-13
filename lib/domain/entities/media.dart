import 'package:equatable/equatable.dart';

class Media extends Equatable {
  final String id;
  final int type;
  final String shortCode;
  final String thumbnailSrc;
  final String displaySrc;
  final int views;

  final String ownerId;
  final String ownerUsername;
  final String ownerPicUrl;
  Media({
    required this.id,
    required this.type,
    required this.shortCode,
    required this.thumbnailSrc,
    required this.displaySrc,
    required this.views,
    required this.ownerId,
    required this.ownerUsername,
    required this.ownerPicUrl,
  });

  @override
  List<Object?> get props => [
        id,
        type,
        shortCode,
        thumbnailSrc,
        displaySrc,
        views,
        ownerId,
        ownerUsername,
        ownerPicUrl,
      ];
}
