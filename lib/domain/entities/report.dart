import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';

part 'report.g.dart';

@HiveType(typeId: 2)
class Report extends Equatable {
  static const String boxKey = "reportBoxKey";

  @HiveField(0)
  final int followers;
  @HiveField(1)
  final int followings;
  // int photo;
  // int video;
  // int totalLikes;
  // int totalComments;
  @HiveField(2)
  final int notFollowingMeBack;
  @HiveField(3)
  final int iamNotFollowingBack;
  @HiveField(4)
  final int mutualFollowing;
  @HiveField(5)
  final List<ChartData> followersChartData;
  @HiveField(6)
  final List<ChartData> followingsChartData;
  @HiveField(7)
  final List<ChartData> newFollowersChartData;
  @HiveField(8)
  final List<ChartData> lostFollowersChartData;

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
    required this.followersChartData,
    required this.followingsChartData,
    required this.newFollowersChartData,
    required this.lostFollowersChartData,
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

@HiveType(typeId: 3)
class ChartData {
  @HiveField(0)
  final String date;
  @HiveField(1)
  int value;

  ChartData({
    required this.date,
    required this.value,
  });
}
