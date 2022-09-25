class EngagmentModel {
  List<MediaData> mostLikes;
  List<MediaData> mostComments;
  List<MediaData> engagedDidntFollow;
  List<MediaData> likedDidntFollow;

  EngagmentModel(
      {required this.mostLikes,
      required this.mostComments,
      required this.engagedDidntFollow,
      required this.likedDidntFollow});

  Map<String, dynamic> toEntity() {
    return {
      'mostLikes': mostLikes,
      'mostComments': mostComments,
      'engagedDidntFollow': engagedDidntFollow,
      'likedDidntFollow': likedDidntFollow,
    };
  }

  EngagmentModel copyWith({
    List<MediaData>? mostLikes,
    List<MediaData>? mostComments,
    List<MediaData>? engagedDidntFollow,
    List<MediaData>? likedDidntFollow,
  }) {
    return EngagmentModel(
      mostLikes: mostLikes ?? this.mostLikes,
      mostComments: mostComments ?? this.mostComments,
      engagedDidntFollow: engagedDidntFollow ?? this.engagedDidntFollow,
      likedDidntFollow: likedDidntFollow ?? this.likedDidntFollow,
    );
  }

  @override
  String toString() {
    return 'EngagmentModel(mostLikes: $mostLikes, mostComments: $mostComments, engagedDidntFollow: $engagedDidntFollow, likedDidntFollow: $likedDidntFollow)';
  }
}

class MediaData {
  final String igUserId;
  final List<String> mediaList;

  MediaData({required this.igUserId, required this.mediaList});
}
