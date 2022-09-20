import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:igplus_ios/app/extensions/media_query_values.dart';
import 'package:igplus_ios/presentation/resources/colors_manager.dart';
import 'package:intl/intl.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String? subTitle;
  final int count;
  final IconData icon;
  final BuildContext context;
  final int? style;
  final String type;
  final int newFriends;
  const InfoCard({
    Key? key,
    required this.title,
    this.subTitle,
    required this.count,
    required this.icon,
    required this.context,
    this.style,
    required this.type,
    required this.newFriends,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (style == 1) {
      return GestureDetector(
        onTap: () {
          GoRouter.of(context).go('/home/friendsList/$type');
        },
        child: Card(
          color: ColorsManager.cardBack,
          elevation: 1,
          margin: const EdgeInsets.all(8),
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: context.width - 23, minHeight: context.height / 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  width: context.width / 1.4,
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
                            children: [
                              Text(title, style: const TextStyle(fontSize: 16, color: ColorsManager.textColor)),
                              Text(subTitle ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 14, color: ColorsManager.secondarytextColor)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: context.width / 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        (newFriends != 0)
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(FontAwesomeIcons.arrowUp,
                                        size: 14,
                                        color: ColorsManager.primaryColor,
                                        shadows: [
                                          Shadow(
                                            blurRadius: 20.0,
                                            color: ColorsManager.primaryColor,
                                            offset: Offset(0.0, 0.0),
                                          ),
                                        ]),
                                    Text(newFriends.toString(),
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: ColorsManager.primaryColor,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              )
                            : const SizedBox.shrink(),
                        Text(
                          NumberFormat.compact().format(count),
                          style: const TextStyle(
                              fontSize: 20, color: ColorsManager.textColor, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          // GoRouter.of(context).goNamed('friendsList');
          GoRouter.of(context).go('/home/friendsList/$type');
        },
        child: Card(
          color: ColorsManager.cardBack,
          elevation: 1,
          margin: const EdgeInsets.all(8),
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: context.width / 2.3, minHeight: context.height / 7),
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
                    Row(
                      children: [
                        Text(NumberFormat.compact().format(count),
                            style: const TextStyle(
                                fontSize: 20, color: ColorsManager.textColor, fontWeight: FontWeight.bold)),
                        (newFriends != 0)
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon((newFriends > 0) ? FontAwesomeIcons.arrowUp : FontAwesomeIcons.arrowDown,
                                        size: 14,
                                        color: (newFriends > 0) ? ColorsManager.upColor : ColorsManager.downColor,
                                        shadows: [
                                          Shadow(
                                            blurRadius: 20.0,
                                            color: (newFriends > 0) ? ColorsManager.upColor : ColorsManager.downColor,
                                          ),
                                        ]),
                                    Text(newFriends.toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: (newFriends > 0) ? ColorsManager.upColor : ColorsManager.downColor,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ],
                ),
                Text(title, style: const TextStyle(fontSize: 14, color: ColorsManager.secondarytextColor)),
              ],
            ),
          ),
        ),
      );
    }
  }
}
