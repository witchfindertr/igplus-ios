import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:igplus_ios/presentation/blocs/home/cubit/report_cubit.dart';
import 'package:igplus_ios/presentation/resources/colors_manager.dart';
import 'package:igplus_ios/presentation/views/global/info_card.dart';
import 'package:igplus_ios/presentation/views/global/section_title.dart';
import 'package:igplus_ios/presentation/views/home/stats/line-chart.dart';
import 'package:igplus_ios/presentation/views/home/stories/stories_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    context.read<ReportCubit>().init();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: BlocBuilder<ReportCubit, ReportState>(
        builder: (context, state) {
          if (state is ReportInProgress) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (state is ReportSuccess) {
            return CupertinoScrollbar(
              thickness: 12,
              child: ListView(
                children: <Widget>[
                  ProfileCard(
                    followers: state.report.followers,
                    followings: state.report.followings,
                    username: state.accountInfo.username,
                    picture: state.accountInfo.picture,
                  ),
                  LineChartSample(chartData: state.report.followersChartData),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InfoCard(
                        title: "New Followers",
                        icon: FontAwesomeIcons.userPlus,
                        count: state.report.newFollowers.toString(),
                        context: context,
                      ),
                      InfoCard(
                        title: "Followers Lost",
                        icon: FontAwesomeIcons.userMinus,
                        count: state.report.lostFollowers.toString(),
                        context: context,
                      ),
                    ],
                  ),
                  InfoCard(
                    title: "Who Admires You",
                    subTitle: "Find out who's intersted in you",
                    icon: FontAwesomeIcons.solidHeart,
                    count: "53",
                    context: context,
                    style: 1,
                  ),
                  const StoriesList(),
                  const SectionTitle(title: "Important stats", icon: FontAwesomeIcons.chartSimple),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InfoCard(
                        title: "Not Following Back",
                        icon: FontAwesomeIcons.userSlash,
                        count: state.report.notFollowingMeBack.toString(),
                        context: context,
                      ),
                      InfoCard(
                        title: "You don't follow back",
                        icon: FontAwesomeIcons.userInjured,
                        count: state.report.iamNotFollowingBack.toString(),
                        context: context,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InfoCard(
                        title: "mutual followings",
                        icon: FontAwesomeIcons.userGroup,
                        count: state.report.mutualFollowing.toString(),
                        context: context,
                      ),
                      InfoCard(
                        title: "You have unfollowed",
                        icon: FontAwesomeIcons.usersSlash,
                        count: state.report.youHaveUnfollowed.toString(),
                        context: context,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InfoCard(
                        title: "mutual followings",
                        icon: CupertinoIcons.person_crop_circle,
                        count: "221",
                        context: context,
                      ),
                      InfoCard(
                        title: "I have unfollowed",
                        icon: CupertinoIcons.person_crop_circle,
                        count: "222",
                        context: context,
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        },
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final int followers;
  final int followings;
  final String username;
  final String picture;
  const ProfileCard({
    Key? key,
    required this.followers,
    required this.followings,
    required this.username,
    required this.picture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 4.0),
      color: ColorsManager.cardBack,
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(followers.toString(),
                      style: TextStyle(fontSize: 20, color: ColorsManager.textColor, fontWeight: FontWeight.bold)),
                ),
                const Text("Followers", style: TextStyle(fontSize: 16, color: ColorsManager.secondarytextColor)),
              ],
            ),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 4.0),
                  alignment: Alignment.centerLeft,
                  width: 90.0,
                  height: 90.0,
                  decoration: BoxDecoration(
                    border: const Border.fromBorderSide(BorderSide(color: ColorsManager.secondarytextColor, width: 2)),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(picture),
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      FontAwesomeIcons.penToSquare,
                      color: ColorsManager.secondarytextColor,
                      size: 16.0,
                    ),
                    const SizedBox(width: 4.0),
                    Text(username, style: TextStyle(fontSize: 16, color: ColorsManager.textColor)),
                  ],
                ),
                const SizedBox(height: 10.0),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(followings.toString(),
                      style: TextStyle(fontSize: 20, color: ColorsManager.textColor, fontWeight: FontWeight.bold)),
                ),
                const Text("Following", style: TextStyle(fontSize: 16, color: ColorsManager.secondarytextColor)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
