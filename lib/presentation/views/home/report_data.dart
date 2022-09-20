import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igplus_ios/domain/entities/account_info.dart';
import 'package:igplus_ios/domain/entities/report.dart';
import 'package:igplus_ios/presentation/resources/colors_manager.dart';
import 'package:igplus_ios/presentation/views/global/info_card.dart';
import 'package:igplus_ios/presentation/views/global/section_title.dart';
import 'package:igplus_ios/presentation/views/home/profile_card.dart';
import 'package:igplus_ios/presentation/views/home/stats/line-chart.dart';
import 'package:igplus_ios/presentation/views/home/stories/stories_list.dart';

class ReportData extends StatelessWidget {
  const ReportData({
    Key? key,
    required this.accountInfo,
    this.loadingMessage,
    this.report,
  }) : super(key: key);

  final Report? report;
  final AccountInfo accountInfo;
  final String? loadingMessage;

  @override
  Widget build(BuildContext context) {
    if (report != null) {
      return CupertinoScrollbar(
        thickness: 0,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
              child: ProfileCard(
                followers: accountInfo.followers,
                followings: accountInfo.followings,
                username: accountInfo.username,
                picture: accountInfo.picture,
              ),
            ),
            // LineChartSample(chartData: report!.followersChartData),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InfoCard(
                    title: "New Followers",
                    icon: FontAwesomeIcons.userPlus,
                    count: report!.newFollowersCycle,
                    context: context,
                    type: "newFollowers",
                    newFriends: report!.newFollowers,
                  ),
                  InfoCard(
                    title: "Followers Lost",
                    icon: FontAwesomeIcons.userMinus,
                    count: report!.lostFollowersCycle,
                    context: context,
                    type: "lostFollowers",
                    newFriends: report!.lostFollowers,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
              child: InfoCard(
                title: "Who Admires You",
                subTitle: "Find out who's intersted in you",
                icon: FontAwesomeIcons.solidHeart,
                count: 0,
                context: context,
                style: 1,
                type: "whoAdmiresYou",
                newFriends: 0,
              ),
            ),
            const StoriesList(),
            const SectionTitle(title: "Important stats", icon: FontAwesomeIcons.chartSimple),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InfoCard(
                    title: "Not Following Back",
                    icon: FontAwesomeIcons.userSlash,
                    count: report!.notFollowingBackCycle,
                    context: context,
                    type: "notFollowingBack",
                    newFriends: report!.notFollowingBack,
                  ),
                  InfoCard(
                    title: "You don't follow back",
                    icon: FontAwesomeIcons.userInjured,
                    count: report!.youDontFollowBackCycle,
                    context: context,
                    type: "youDontFollowBack",
                    newFriends: report!.youDontFollowBack,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InfoCard(
                    title: "mutual followings",
                    icon: FontAwesomeIcons.userGroup,
                    count: report!.mutualFollowingsCycle,
                    context: context,
                    type: "mutualFollowings",
                    newFriends: report!.mutualFollowings,
                  ),
                  InfoCard(
                    title: "You have unfollowed",
                    icon: FontAwesomeIcons.usersSlash,
                    count: report!.youHaveUnfollowedCycle,
                    context: context,
                    type: "youHaveUnfollowed",
                    newFriends: report!.youHaveUnfollowed,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return CupertinoScrollbar(
          thickness: 0,
          child: ListView(children: <Widget>[
            ProfileCard(
              followers: accountInfo.followers,
              followings: accountInfo.followings,
              username: accountInfo.username,
              picture: accountInfo.picture,
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 4),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CupertinoActivityIndicator(
                        radius: 12.0,
                      ),
                      const SizedBox(height: 20.0),
                      Text(loadingMessage ?? "", style: const TextStyle(fontSize: 12, color: ColorsManager.textColor)),
                      const SizedBox(height: 4.0),
                      const Text("This can take a few minutes depending on your account size",
                          style: TextStyle(fontSize: 10, color: ColorsManager.secondarytextColor)),
                    ],
                  ),
                ),
              ),
            ),
          ]));
    }
  }
}
