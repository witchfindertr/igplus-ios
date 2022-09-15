import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:igplus_ios/app/constants/media_constants.dart';
import 'package:igplus_ios/domain/entities/User_story.dart';

import 'package:igplus_ios/domain/usecases/get_stories_use_case.dart';
import 'package:igplus_ios/domain/usecases/get_user_use_case.dart';
import 'package:story_view/story_view.dart';

import '../../../../domain/entities/story.dart';

part 'stories_state.dart';

class StoriesCubit extends Cubit<StoriesState> {
  final GetStoriesUseCase getStories;
  final GetUserUseCase getUser;
  StoriesCubit({
    required this.getStories,
    required this.getUser,
  }) : super(StoriesInitial());

  void init({required StoryOwner storyOwner}) async {
    emit(StoriesLoading());

    // get user info
    final failureOrCurrentUser = await getUser.execute();
    if (failureOrCurrentUser.isLeft()) {
      emit(const StoriesLoaded(storyItems: []));
    } else {
      final currentUser = (failureOrCurrentUser as Right).value;
      // get user stories
      final failureOrStories = await getStories.execute(storyOwnerId: storyOwner.id, igHeaders: currentUser.igHeaders);

      if (failureOrStories.isLeft()) {
        emit(const StoriesLoaded(storyItems: []));
      } else {
        final List<Story> stories = (failureOrStories as Right).value;
        final List<StoryItem> storyItems = stories.map((story) {
          if (story.mediaType == MediaConstants.TYPE_IMAGE) {
            return StoryItem.pageImage(
              url: story.mediaUrl,
              controller: StoryController(),
              // caption: story.caption,
              // imageFit: BoxFit.cover,
            );
          } else if (story.mediaType == MediaConstants.TYPE_VIDEO) {
            return StoryItem.pageVideo(
              story.mediaUrl,
              controller: StoryController(),
              // caption: story.caption,
              // imageFit: BoxFit.cover,
            );
          } else {
            return StoryItem.text(
                title: "No Stories for ${storyOwner.username}", backgroundColor: Color.fromARGB(255, 200, 7, 7));
          }
        }).toList();
        emit(StoriesLoaded(storyItems: storyItems));
      }
    }
  }
}
