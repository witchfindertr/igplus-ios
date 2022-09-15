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
    return SizedBox(
      height: 80.00,
      width: 80.00,
      child: GestureDetector(
        onTap: () {
          GoRouter.of(context).go('/home/storiesView', extra: userStory.owner);
        },
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
                Colors.orange,
              ],
            ),
            borderRadius: BorderRadius.circular(35),
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
    );
  }
}
