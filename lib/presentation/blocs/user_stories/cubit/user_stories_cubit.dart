import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import 'package:igplus_ios/domain/entities/User_story.dart';
import 'package:igplus_ios/domain/usecases/get_user_stories_use_case.dart';
import 'package:igplus_ios/domain/usecases/get_user_use_case.dart';

import '../../home/cubit/report_cubit.dart';

part 'user_stories_state.dart';

class UserStoriesCubit extends Cubit<UserStoriesState> {
  final GetUserStoriesUseCase getUserStories;
  final GetUserUseCase getUser;
  UserStoriesCubit({
    required this.getUserStories,
    required this.getUser,
  }) : super(UserStoriesInitial());

  void init() async {
    emit(UserStoriesLoading());

    // get user info
    final failureOrCurrentUser = await getUser.execute();
    if (failureOrCurrentUser.isLeft()) {
      emit(const UserStoriesLoaded(userStories: []));
    } else {
      final currentUser = (failureOrCurrentUser as Right).value;
      // get user stories
      final failureOrUserStories = await getUserStories.execute(igHeaders: currentUser.igHeaders);

      if (failureOrUserStories.isLeft()) {
        emit(const UserStoriesLoaded(userStories: []));
      } else {
        final userStories = (failureOrUserStories as Right).value;
        emit(UserStoriesLoaded(userStories: userStories));
      }
    }
  }
}
