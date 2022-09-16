import 'package:flutter/material.dart';
import 'package:igplus_ios/presentation/resources/colors_manager.dart';
import 'package:intl/intl.dart';

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
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(NumberFormat.compact().format(followers),
                      style:
                          const TextStyle(fontSize: 20, color: ColorsManager.textColor, fontWeight: FontWeight.bold)),
                ),
                const Text("Followers", style: TextStyle(fontSize: 16, color: ColorsManager.secondarytextColor)),
              ],
            ),
            Container(
              margin: const EdgeInsets.all(10),
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
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(NumberFormat.compact().format(followings),
                      style:
                          const TextStyle(fontSize: 20, color: ColorsManager.textColor, fontWeight: FontWeight.bold)),
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
