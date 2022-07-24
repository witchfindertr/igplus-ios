import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:igplus_ios/app/extensions/media_query_values.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        leading: Text("VIP"),
        middle: Text("tiktube"),
        trailing: Icon(CupertinoIcons.refresh),
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
                  icon: CupertinoIcons.person_crop_circle,
                  count: "222",
                  context: context,
                ),
                InfoCard(
                  title: "Followers Lost",
                  icon: CupertinoIcons.person_crop_circle,
                  count: "222",
                  context: context,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoCard(
                  title: "Not Following Back",
                  icon: CupertinoIcons.person_crop_circle,
                  count: "222",
                  context: context,
                ),
                InfoCard(
                  title: "I am not following back",
                  icon: CupertinoIcons.person_crop_circle,
                  count: "222",
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
                  count: "222",
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InfoCard(
                  title: "mutual followings",
                  icon: CupertinoIcons.person_crop_circle,
                  count: "222",
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
      elevation: 4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: const [
              Text("322"),
              Text("Followers"),
            ],
          ),
          const Icon(CupertinoIcons.profile_circled, size: 80),
          Column(
            children: const [
              Text("24"),
              Text("Following"),
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
                Icon(icon, size: 30),
                Text(count),
              ],
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}
