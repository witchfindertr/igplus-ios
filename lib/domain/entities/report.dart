import 'package:equatable/equatable.dart';

class Report extends Equatable {
  final int followers;
  final int followings;
  // int photo;
  // int video;
  // int totalLikes;
  // int totalComments;
  final int notFollowingMeBack;
  final int iamNotFollowingBack;
  final int mutualFollowing;

  const Report({
    required this.followers,
    required this.followings,
    // required this.photo,
    // required this.video,
    // required this.totalLikes,
    // required this.totalComments,
    required this.notFollowingMeBack,
    required this.iamNotFollowingBack,
    required this.mutualFollowing,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        followers,
        followings,
        // photo,
        // video,
        // totalLikes,
        // totalComments,
        notFollowingMeBack,
        iamNotFollowingBack,
      ];
}
