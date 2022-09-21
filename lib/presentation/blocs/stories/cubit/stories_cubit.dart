import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:igplus_ios/domain/entities/User_story.dart';

import 'package:igplus_ios/domain/usecases/get_stories_use_case.dart';
import 'package:igplus_ios/domain/usecases/get_user_use_case.dart';
import 'package:story_view/story_view.dart';

import '../../../../data/failure.dart';
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

    final StoryController controller = StoryController();

    // get user info
    final failureOrCurrentUser = await getUser.execute();
    if (failureOrCurrentUser.isLeft()) {
      final failure = (failureOrCurrentUser as Left).value;
      if (failure is UserAuthenticationFailure) {
        emit(StoriesFailure(failure: failure));
      } else {
        emit(StoriesLoaded(stories: const [], controller: controller, storyOwner: storyOwner));
      }
    } else {
      final currentUser = (failureOrCurrentUser as Right).value;
      // get user stories
      final failureOrStories = await getStories.execute(storyOwnerId: storyOwner.id, igHeaders: currentUser.igHeaders);

      if (failureOrStories.isLeft()) {
        final failure = (failureOrStories as Left).value;
        if (failure is InstagramSessionFailure) {
          emit(StoriesFailure(failure: failure));
        } else {
          emit(StoriesLoaded(stories: const [], controller: controller, storyOwner: storyOwner));
        }
      } else {
        final List<Story> stories = (failureOrStories as Right).value;

        emit(StoriesLoaded(stories: stories, controller: controller, storyOwner: storyOwner));
      }
    }
  }
}
