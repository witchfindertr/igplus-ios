import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igplus_ios/presentation/views/global/info_card.dart';
import 'package:igplus_ios/presentation/views/global/info_card_list.dart';
import 'package:igplus_ios/presentation/views/global/section_title.dart';

class InsightPage extends StatelessWidget {
  const InsightPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map> mediaInsigntCards = [
      {
        "title": "Most Popular",
        "subTitle": "Find the most popular posts",
        "context": context,
      },
      {
        "title": "Most Liked",
        "subTitle": "Find the most liked posts",
        "context": context,
      },
      {
        "title": "Most Commented",
        "subTitle": "Find the most commented posts",
        "context": context,
      }
    ];

    List<Map> storiesInsigntCards = [
      {
        "title": "Most Viewed",
        "subTitle": "Find the most viewed stories",
        "context": context,
      },
      {
        "title": "Top viewers",
        "subTitle": "Find the top viewers of your stories",
        "context": context,
      },
      {
        "title": "Viewers not following you",
        "subTitle": "Find the viewers who are not following you",
        "context": context,
      }
    ];
    return CupertinoPageScaffold(
      child: CupertinoScrollbar(
        thickness: 12,
        child: ListView(
          children: <Widget>[
            const SectionTitle(
              title: "Insights",
              icon: FontAwesomeIcons.chartPie,
            ),
            InfoCard(
              title: "Who Admires You",
              subTitle: "Find out who's intersted in you",
              icon: FontAwesomeIcons.solidHeart,
              count: "53",
              context: context,
              style: 1,
              type: "whoAdmiresYou",
            ),
            const SectionTitle(
              title: "Media insights",
              icon: FontAwesomeIcons.images,
            ),
            InfoCardList(
              cards: mediaInsigntCards,
            ),
            const SectionTitle(
              title: "Stories insights",
              icon: FontAwesomeIcons.circleNotch,
            ),
            InfoCardList(
              cards: storiesInsigntCards,
            ),
          ],
        ),
      ),
    );
  }
}
