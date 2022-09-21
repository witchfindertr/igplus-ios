import 'package:flutter/material.dart';
import 'package:igplus_ios/presentation/resources/colors_manager.dart';
import 'package:intl/intl.dart';

class MediaStatsCard extends StatelessWidget {
  const MediaStatsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorsManager.cardBack,
      elevation: 1,
      margin: const EdgeInsets.all(8),
      child: ConstrainedBox(
        constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width - 23, minHeight: MediaQuery.of(context).size.height / 7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width / 1.4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(4.0, 14.0, 4.0, 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 8, 10),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        width: 60.0,
                        height: 60.0,
                        decoration: const BoxDecoration(
                          border: Border.fromBorderSide(BorderSide(color: ColorsManager.textColor, width: 2)),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage("assets/images/brahimaito.jpg"),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Title", style: TextStyle(fontSize: 16, color: ColorsManager.textColor)),
                          Text("Subtitle",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontSize: 14, color: ColorsManager.secondarytextColor)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width / 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Text(
                      NumberFormat.compact().format(20),
                      style: const TextStyle(fontSize: 20, color: ColorsManager.textColor, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
