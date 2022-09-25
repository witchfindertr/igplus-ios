import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:igplus_ios/data/failure.dart';
import 'package:igplus_ios/domain/entities/stories_user.dart';
import 'package:igplus_ios/domain/usecases/get_stories_from_local_use_case.dart';
import 'package:igplus_ios/domain/usecases/get_stories_user_from_local_use_case.dart';
import 'package:igplus_ios/domain/usecases/get_stories_users_use_case.dart';
import 'package:igplus_ios/domain/usecases/get_user_use_case.dart';
import 'package:igplus_ios/domain/usecases/save_stories_to_local_use_case.dart';
import 'package:igplus_ios/domain/usecases/save_stories_user_to_local_use_case.dart';

part 'user_stories_state.dart';

class UserStoriesCubit extends Cubit<UserStoriesState> {
  final GetStoriesUsersUseCase getUserStories;
  final GetUserUseCase getUser;
  final GetStoriesUsersFromLocalUseCase getStoriesUsersFromLocal;
  final CacheStoriesUserToLocalUseCase cacheStoriesUsersToLocal;
  UserStoriesCubit({
    required this.getUserStories,
    required this.getUser,
    required this.getStoriesUsersFromLocal,
    required this.cacheStoriesUsersToLocal,
  }) : super(UserStoriesInitial());

  void init() async {
    emit(UserStoriesLoading());

    // get user info
    final failureOrCurrentUser = await getUser.execute();
    if (failureOrCurrentUser.isLeft()) {
      emit(const UserStoriesLoaded(userStories: []));
    } else {
      final currentUser = (failureOrCurrentUser as Right).value;

      // // try to get stories from local
      Either<Failure, List<StoriesUser>?> cachedStoriesUsersList = await getStoriesUsersFromLocal.execute();
      if (cachedStoriesUsersList.isLeft() || (cachedStoriesUsersList as Right).value == null) {
        // get user stories from instagram
        final failureOrUserStories = await getUserStories.execute(igHeaders: currentUser.igHeaders);
        if (failureOrUserStories.isLeft()) {
          emit(const UserStoriesLoaded(userStories: []));
        } else {
          final storiesUsersList = (failureOrUserStories as Right).value;
          emit(UserStoriesLoaded(userStories: storiesUsersList));

          // cache stories to local
          cacheStoriesUsersToLocal.execute(storiesUserList: storiesUsersList, dataName: StoriesUser.boxKey);
        }
      } else {
        final storiesList = (cachedStoriesUsersList as Right).value;
        emit(UserStoriesLoaded(userStories: storiesList));
      }
    }
  }
}
