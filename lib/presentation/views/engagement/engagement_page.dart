import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igplus_ios/presentation/resources/colors_manager.dart';
import 'package:igplus_ios/presentation/views/global/info_card.dart';
import 'package:igplus_ios/presentation/views/global/info_card_list.dart';
import 'package:igplus_ios/presentation/views/global/section_title.dart';

class EngagementPage extends StatelessWidget {
  const EngagementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map> bestFollowers = [
      {
        "title": "Most Likes",
        "subTitle": "",
        "context": context,
      },
      {
        "title": "Most Comments",
        "subTitle": "",
        "context": context,
      },
      {
        "title": "Most Likes & Commented",
        "subTitle": "",
        "context": context,
      }
    ];

    List<Map> missedConnections = [
      {
        "title": "Users engaged, but didn't follow",
        "subTitle": "",
        "context": context,
      },
      {
        "title": "Users liked me, but didn't follow",
        "subTitle": "",
        "context": context,
      },
    ];

    List<Map> ghostFollowers = [
      {
        "title": "Least likes given",
        "subTitle": "Find freinds with the least likes given",
        "context": context,
      },
      {
        "title": "Least comments left",
        "subTitle": "Find freinds with the least comments left",
        "context": context,
      },
      {
        "title": "No comments, no likes",
        "subTitle": "Find freinds with no comments or likes",
        "context": context,
      }
    ];

    return CupertinoPageScaffold(
      child: CupertinoScrollbar(
        thickness: 12,
        child: ListView(
          children: <Widget>[
            const SectionTitle(
              title: "Best Followers",
              icon: FontAwesomeIcons.usersGear,
            ),
            InfoCardList(
              cards: bestFollowers,
            ),
            const SectionTitle(
              title: "Missed Connections",
              icon: FontAwesomeIcons.linkSlash,
            ),
            InfoCardList(
              cards: missedConnections,
            ),
            const SectionTitle(
              title: "Ghost Followers",
              icon: FontAwesomeIcons.ghost,
            ),
            InfoCardList(
              cards: ghostFollowers,
            ),
          ],
        ),
      ),
    );
  }
}
