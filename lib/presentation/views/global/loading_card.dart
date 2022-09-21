import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igplus_ios/presentation/resources/colors_manager.dart';
import 'package:igplus_ios/presentation/views/global/loading_indicator.dart';

class LoadingCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final int? style;
  const LoadingCard({Key? key, this.style, required this.title, required this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (style == 1)
        ? Card(
            color: ColorsManager.cardBack,
            elevation: 1,
            margin: const EdgeInsets.all(8),
            child: ConstrainedBox(
                constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width - 23,
                    minHeight: MediaQuery.of(context).size.height / 7),
                child: const LoadingIndicator()),
          )
        : Card(
            color: ColorsManager.cardBack,
            elevation: 1,
            margin: const EdgeInsets.all(8),
            child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width / 2.3,
                  minHeight: MediaQuery.of(context).size.height / 7,
                ),
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 15, 10),
                              child: Icon(icon, size: 24),
                            ),
                            const LoadingIndicator(),
                          ],
                        ),
                      ),
                      Text(title, style: const TextStyle(fontSize: 14, color: ColorsManager.secondarytextColor))
                    ],
                  ),
                )),
          );
  }
}
