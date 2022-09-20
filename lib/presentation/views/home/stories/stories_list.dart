import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igplus_ios/presentation/blocs/user_stories/cubit/user_stories_cubit.dart';
import 'package:igplus_ios/presentation/views/global/section_title.dart';
import 'package:igplus_ios/presentation/views/home/stories/story_card.dart';

class StoriesList extends StatefulWidget {
  const StoriesList({Key? key}) : super(key: key);

  @override
  State<StoriesList> createState() => _StoriesListState();
}

class _StoriesListState extends State<StoriesList> {
  @override
  void initState() {
    context.read<UserStoriesCubit>().init();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: "Watch stories anonymously", icon: FontAwesomeIcons.eyeLowVision),
        BlocBuilder<UserStoriesCubit, UserStoriesState>(
          builder: (context, state) {
            if (state is UserStoriesInitial) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserStoriesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserStoriesLoaded) {
              return SizedBox(
                height: 82.00,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.userStories.length,
                  itemBuilder: (context, index) {
                    return StoryCard(userStory: state.userStories[index]);
                  },
                ),
              );
            } else {
              return const Center(child: Text("Error"));
            }
          },
        ),
      ],
    );
  }
}
