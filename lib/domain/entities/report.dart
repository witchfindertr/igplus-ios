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
  final int youDontFollowBackBoxKey;
  @HiveField(4)
  final int mutualFollowings;
  @HiveField(5)
  final List<ChartData> followersChartData;
  @HiveField(6)
  final List<ChartData> followingsChartData;
  @HiveField(7)
  final List<ChartData> newFollowersChartData;
  @HiveField(8)
  final List<ChartData> lostFollowersChartData;
  @HiveField(9)
  final int newFollowers;
  @HiveField(10)
  final int lostFollowers;
  @HiveField(11)
  final int youHaveUnfollowed;

  const Report({
    required this.followers,
    required this.followings,
    // required this.photo,
    // required this.video,
    // required this.totalLikes,
    // required this.totalComments,
    required this.notFollowingMeBack,
    required this.youDontFollowBackBoxKey,
    required this.mutualFollowings,
    required this.followersChartData,
    required this.followingsChartData,
    required this.newFollowersChartData,
    required this.lostFollowersChartData,
    required this.newFollowers,
    required this.lostFollowers,
    required this.youHaveUnfollowed,
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
        youDontFollowBackBoxKey,
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
