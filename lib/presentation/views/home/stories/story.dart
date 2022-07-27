import 'package:flutter/material.dart';
import 'package:igplus_ios/presentation/resources/colors_manager.dart';
import 'package:igplus_ios/presentation/views/home/stories/stories.dart';

class Story extends StatelessWidget {
  const Story({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.00,
      width: 80.00,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const StoryPage();
              },
            ),
          );
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
              decoration: const BoxDecoration(
                color: ColorsManager.appBack,
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                      "https://scontent.cdninstagram.com/v/t51.2885-19/13166827_1075389272506962_890479771_a.jpg?stp=dst-jpg_s150x150&_nc_ht=scontent.cdninstagram.com&_nc_cat=106&_nc_ohc=O0VZaTUGwFgAX8bGrC9&edm=APs17CUBAAAA&ccb=7-5&oh=00_AT8a-V90V1s7gsnvITled9fo9UjYgRa6V7tJwTe6GsBCEA&oe=62E61800&_nc_sid=978cb9"),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
