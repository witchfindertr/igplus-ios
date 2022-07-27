import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igplus_ios/presentation/views/global/section_title.dart';
import 'package:igplus_ios/presentation/views/home/stories/story.dart';

class StoriesList extends StatelessWidget {
  const StoriesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: "Watch stories anonymously", icon: FontAwesomeIcons.eyeLowVision),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: const [
              Story(),
              Story(),
              Story(),
              Story(),
              Story(),
              Story(),
              Story(),
            ],
          ),
        ),
      ],
    );
  }
}
