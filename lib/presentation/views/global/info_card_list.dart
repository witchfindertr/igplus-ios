import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igplus_ios/app/extensions/media_query_values.dart';
import 'package:igplus_ios/presentation/resources/colors_manager.dart';

class InfoCardList extends StatelessWidget {
  final List<Map> cards;
  const InfoCardList({Key? key, required this.cards}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> myCardsList = [];
    for (var card in cards) {
      myCardsList.add(myCard(
        title: card["title"],
        subTitle: card["subTitle"],
        context: context,
      ));
    }
    return Column(
      children: myCardsList,
    );
  }

  Widget myCard({required String title, String? subTitle, required BuildContext context, int? style}) {
    return Card(
      color: ColorsManager.cardBack,
      elevation: 1,
      margin: const EdgeInsets.fromLTRB(8.0, 0.5, 8.0, 0.5),
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: context.width - 16, minHeight: context.height / 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.57,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(title, style: const TextStyle(fontSize: 16, color: ColorsManager.textColor)),
                        (subTitle != null)
                            ? Text(subTitle,
                                style: const TextStyle(fontSize: 14, color: ColorsManager.secondarytextColor))
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Icon(FontAwesomeIcons.angleRight, color: ColorsManager.secondarytextColor),
            ),
          ],
        ),
      ),
    );
  }
}
