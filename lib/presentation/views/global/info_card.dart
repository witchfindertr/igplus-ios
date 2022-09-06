import 'package:flutter/material.dart';
import 'package:igplus_ios/app/extensions/media_query_values.dart';
import 'package:igplus_ios/presentation/resources/colors_manager.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String? subTitle;
  final String count;
  final IconData icon;
  final BuildContext context;
  final int? style;
  const InfoCard(
      {Key? key,
      required this.title,
      this.subTitle,
      required this.count,
      required this.icon,
      required this.context,
      this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (style == 1) {
      return Card(
        color: ColorsManager.cardBack,
        elevation: 1,
        margin: const EdgeInsets.all(8),
        child: ConstrainedBox(
          constraints: BoxConstraints(minWidth: context.width - 16, minHeight: context.height / 7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 20.0, 10.0, 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 15, 10),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: const TextStyle(fontSize: 16, color: ColorsManager.textColor)),
                        Text(subTitle ?? "",
                            style: const TextStyle(fontSize: 14, color: ColorsManager.secondarytextColor)),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(count,
                    style: const TextStyle(fontSize: 20, color: ColorsManager.textColor, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      );
    } else {
      return Card(
        color: ColorsManager.cardBack,
        elevation: 1,
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
                      style:
                          const TextStyle(fontSize: 20, color: ColorsManager.textColor, fontWeight: FontWeight.bold)),
                ],
              ),
              Text(title, style: const TextStyle(fontSize: 14, color: ColorsManager.secondarytextColor)),
            ],
          ),
        ),
      );
    }
  }
}
