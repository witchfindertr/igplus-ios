import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igplus_ios/presentation/resources/colors_manager.dart';
import 'package:igplus_ios/presentation/views/global/info_card.dart';
import 'package:igplus_ios/presentation/views/global/section_title.dart';
import 'package:igplus_ios/presentation/views/home/stats/line-chart.dart';
import 'package:igplus_ios/presentation/views/home/stories/stories_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: ColorsManager.appBack,
        leading: Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            CupertinoIcons.list_dash,
            color: ColorsManager.textColor,
          ),
        ),
        trailing: Icon(CupertinoIcons.refresh, color: ColorsManager.textColor),
      ),
      child: CupertinoScrollbar(
        thickness: 12,
        child: ListView(
          children: <Widget>[
            const ProfileCard(),
            const LineChartSample(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoCard(
                  title: "New Followers",
                  icon: FontAwesomeIcons.userPlus,
                  count: "122",
                  context: context,
                ),
                InfoCard(
                  title: "Followers Lost",
                  icon: FontAwesomeIcons.userMinus,
                  count: "323",
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
                  count: "653",
                  context: context,
                ),
                InfoCard(
                  title: "You don't follow back",
                  icon: FontAwesomeIcons.userInjured,
                  count: "724",
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
                  count: "173",
                  context: context,
                ),
                InfoCard(
                  title: "You have unfollowed",
                  icon: FontAwesomeIcons.usersSlash,
                  count: "199",
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
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key}) : super(key: key);

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
              children: const [
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text("322",
                      style: TextStyle(fontSize: 20, color: ColorsManager.textColor, fontWeight: FontWeight.bold)),
                ),
                Text("Followers", style: TextStyle(fontSize: 16, color: ColorsManager.secondarytextColor)),
              ],
            ),
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 4.0),
                  alignment: Alignment.centerLeft,
                  width: 90.0,
                  height: 90.0,
                  decoration: const BoxDecoration(
                    border: Border.fromBorderSide(BorderSide(color: ColorsManager.secondarytextColor, width: 2)),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/brahim.jpg"),
                    ),
                  ),
                ),
                Row(
                  children: const [
                    Icon(
                      FontAwesomeIcons.penToSquare,
                      color: ColorsManager.secondarytextColor,
                      size: 16.0,
                    ),
                    SizedBox(width: 4.0),
                    Text("Tiktube", style: TextStyle(fontSize: 16, color: ColorsManager.textColor)),
                  ],
                ),
                const SizedBox(height: 10.0),
              ],
            ),
            Column(
              children: const [
                Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text("24",
                      style: TextStyle(fontSize: 20, color: ColorsManager.textColor, fontWeight: FontWeight.bold)),
                ),
                Text("Following", style: TextStyle(fontSize: 16, color: ColorsManager.secondarytextColor)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
