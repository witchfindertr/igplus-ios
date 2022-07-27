import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igplus_ios/presentation/resources/colors_manager.dart';

class SectionTitle extends StatelessWidget {
  SectionTitle({Key? key, required this.title, required this.icon}) : super(key: key);
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18.0,
          ),
          const SizedBox(width: 10.0),
          Text(title,
              style: const TextStyle(fontSize: 18.0, color: ColorsManager.textColor), textAlign: TextAlign.left),
        ],
      ),
    );
  }
}
