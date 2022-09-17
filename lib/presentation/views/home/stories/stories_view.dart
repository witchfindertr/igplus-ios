import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:igplus_ios/app/constants/media_constants.dart';
import 'package:igplus_ios/domain/entities/User_story.dart';
import 'package:story_view/story_view.dart';

import 'package:igplus_ios/app/app.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../domain/entities/story.dart';
import '../../../blocs/stories/cubit/stories_cubit.dart';
import '../../../resources/colors_manager.dart';

class StoriesView extends StatefulWidget {
  const StoriesView({Key? key, required this.storyOwner}) : super(key: key);

  final StoryOwner storyOwner;

  @override
  State<StoriesView> createState() => _StoriesViewState();
}

class _StoriesViewState extends State<StoriesView> {
  final StoryController controller = StoryController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<StoriesCubit>().init(storyOwner: widget.storyOwner);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: BlocBuilder<StoriesCubit, StoriesState>(
        builder: (context, state) {
          if (state is StoriesLoaded) {
            List<Story?> stories = state.stories;

            final List<StoryItem> storyItems = stories.map((story) {
              if (story != null && story.mediaType == MediaConstants.TYPE_IMAGE) {
                return StoryItem.pageImage(
                  url: story.mediaUrl,
                  controller: controller,
                  // caption: storyOwner.username,
                  // imageFit: BoxFit.cover,
                );
              } else if (story != null && story.mediaType == MediaConstants.TYPE_VIDEO) {
                return StoryItem.pageVideo(
                  story.mediaUrl,
                  controller: controller,
                  // caption: storyOwner.username,
                  // imageFit: BoxFit.cover,
                );
              } else {
                return StoryItem.text(
                    title: "No Stories for ${state.storyOwner.username}",
                    backgroundColor: const Color.fromARGB(255, 200, 7, 7));
              }
            }).toList();

            return GestureDetector(
                onHorizontalDragEnd: (dragUpdateDetails) {
                  controller.next();
                },
                onLongPressDown: (onLongPressDown) {
                  controller.pause();
                },
                onVerticalDragEnd: (dragUpdateDetails) {
                  GoRouter.of(context).pop();
                },
                onLongPress: () {},
                child: Stack(
                  children: <Widget>[
                    StoryView(
                      inline: false,
                      storyItems: storyItems,
                      controller: controller,
                      onComplete: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Container(
                      height: 80.0,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [
                            0,
                            1,
                          ],
                          colors: [
                            Colors.black.withOpacity(0.5),
                            Colors.transparent,
                          ],
                        ),
                      ),
                      padding: const EdgeInsets.only(
                        top: 38,
                        left: 16,
                        right: 16,
                      ),
                      child: _buildProfileView(state.storyOwner,
                          (stories[0] != null) ? stories[0]!.takenAt : DateTime.now().millisecondsSinceEpoch),
                    )
                  ],
                ));
          } else {
            return const Center(
                child: SizedBox(
              width: 20.0,
              height: 20.0,
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                color: ColorsManager.primaryColor,
              ),
            ));
          }
        },
      ),
    );
  }
}

Widget _buildProfileView(StoryOwner storyOwner, takenAt) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Row(
        children: [
          const Icon(FontAwesomeIcons.angleLeft, color: Colors.white, size: 14),
          const SizedBox(width: 4.0),
          CircleAvatar(
            radius: 12,
            backgroundImage: NetworkImage(storyOwner.profilePicUrl),
          ),
        ],
      ),
      const SizedBox(width: 8.0),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              storyOwner.username,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 1.0),
            Text(
              timeago.format(DateTime.fromMillisecondsSinceEpoch(takenAt * 1000)),
              style: const TextStyle(
                color: Colors.white38,
                fontSize: 8.0,
              ),
            )
          ],
        ),
      )
    ],
  );
}
