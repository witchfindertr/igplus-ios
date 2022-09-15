import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:igplus_ios/domain/entities/User_story.dart';
import 'package:story_view/story_view.dart';

import 'package:igplus_ios/app/app.dart';

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
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: ColorsManager.appBack,
        leading: GestureDetector(
            onTap: () => GoRouter.of(context).pop(),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 26.0,
            )),
        middle:
            Text("${widget.storyOwner.username} stories", style: const TextStyle(fontSize: 16, color: Colors.white)),
      ),
      child: Container(
        margin: const EdgeInsets.all(8),
        child: BlocBuilder<StoriesCubit, StoriesState>(
          builder: (context, state) {
            if (state is StoriesLoaded) {
              return StoryView(
                storyItems: state.storyItems,
                controller: controller,
                inline: false,
                repeat: false,
                onComplete: () {
                  GoRouter.of(context).pop();
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
