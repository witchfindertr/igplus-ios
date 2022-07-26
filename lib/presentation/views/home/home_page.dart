import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igplus_ios/app/extensions/media_query_values.dart';
import 'package:igplus_ios/presentation/resources/colors_manager.dart';

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
            CupertinoIcons.back,
            color: ColorsManager.textColor,
          ),
        ),
        middle: Text("10 Coins"),
        trailing: Icon(CupertinoIcons.refresh, color: ColorsManager.textColor),
      ),
      child: CupertinoScrollbar(
        thickness: 12,
        child: ListView(
          children: <Widget>[
            const ProfileCard(),
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
      color: ColorsManager.cardBack,
      elevation: 4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("322",
                    style: TextStyle(fontSize: 28, color: ColorsManager.textColor, fontWeight: FontWeight.bold)),
              ),
              Text("Followers", style: TextStyle(fontSize: 18, color: ColorsManager.secondarytextColor)),
            ],
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
            alignment: Alignment.centerLeft,
            width: 120.0,
            height: 120.0,
            decoration: const BoxDecoration(
              border: Border.fromBorderSide(BorderSide(color: ColorsManager.primaryColor, width: 2)),
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage("https://bukovskevrchy.pl/img/64c9c78b19101eadf6e459ddbb0fd69a.jpg"),
              ),
            ),
          ),
          Column(
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text("24",
                    style: TextStyle(fontSize: 28, color: ColorsManager.textColor, fontWeight: FontWeight.bold)),
              ),
              Text("Following", style: TextStyle(fontSize: 18, color: ColorsManager.secondarytextColor)),
            ],
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String count;
  final IconData icon;
  final BuildContext context;
  const InfoCard({Key? key, required this.title, required this.count, required this.icon, required this.context})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorsManager.cardBack,
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: context.width / 2 - 16, minHeight: context.height / 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 15, 10),
                  child: Icon(icon, size: 24),
                ),
                Text(count,
                    style: const TextStyle(fontSize: 20, color: ColorsManager.textColor, fontWeight: FontWeight.bold)),
              ],
            ),
            Text(title, style: const TextStyle(fontSize: 14, color: ColorsManager.secondarytextColor)),
          ],
        ),
      ),
    );
  }
}
