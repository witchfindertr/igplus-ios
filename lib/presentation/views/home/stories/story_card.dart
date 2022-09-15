import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:igplus_ios/presentation/resources/colors_manager.dart';

import '../../../../domain/entities/User_story.dart';

class StoryCard extends StatelessWidget {
  final UserStory userStory;
  const StoryCard({
    Key? key,
    required this.userStory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).go('/home/storiesView', extra: userStory.owner);
      },
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 80.00,
            height: 80.00,
            child: Container(
              margin: const EdgeInsets.all(4.0),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.purple,
                    Colors.pink,
                    Color.fromARGB(255, 164, 100, 5),
                  ],
                ),
                borderRadius: BorderRadius.circular(35.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: ColorsManager.appBack,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(userStory.owner.profilePicUrl),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Text(userStory.owner.username,
              style: const TextStyle(color: ColorsManager.secondarytextColor, fontSize: 10.0)),
        ],
      ),
    );
  }
}
