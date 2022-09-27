import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:igplus_ios/data/failure.dart';
import 'package:igplus_ios/domain/entities/story.dart';
import 'package:igplus_ios/domain/entities/user.dart';
import 'package:igplus_ios/domain/usecases/get_stories_from_local_use_case.dart';
import 'package:igplus_ios/domain/usecases/get_user_feed_use_case.dart';
import 'package:igplus_ios/domain/usecases/get_user_use_case.dart';
import 'package:igplus_ios/domain/usecases/save_stories_to_local_use_case.dart';
import 'package:igplus_ios/presentation/blocs/home/report/cubit/report_cubit.dart';

part 'stories_insight_state.dart';

class StoriesListCubit extends Cubit<StoriesListState> {
  final GetStoriesFromLocalUseCase getStoriesFromLocal;
  final GetUserFeedUseCase getUserFeed;
  final GetUserUseCase getUser;
  final CacheStoriesToLocalUseCase cacheStoriesToLocal;
  StoriesListCubit({
    required this.getStoriesFromLocal,
    required this.getUserFeed,
    required this.getUser,
    required this.cacheStoriesToLocal,
  }) : super(StoriesListInitial()) {
    init();
  }

  final int pageSize = 10;

  void init() {
    emit(StoriesListLoading());
    // get stories list from local
    getStoriesListFromLocal(
      boxKey: Story.boxKey,
      pageKey: 0,
      pageSize: pageSize,
    ).then((value) {
      if (value != null) {
        emit(StoriesListSuccess(storiesList: value, pageKey: 0));
      } else {
        // get stories from instagram
        getStoriesListFromInstagram(
          dataName: Story.boxKey,
          pageKey: 0,
          pageSize: pageSize,
        ).then((value) {
          if (value != null) {
            emit(StoriesListSuccess(storiesList: value, pageKey: 0));
            // cache new medai list to local
            cacheStoriesToLocal.execute(boxKey: Story.boxKey, storiesList: value);
          } else {
            emit(const StoriesListFailure(message: 'Failed to get stories list from instagram'));
          }
        });
      }
    });
  }

  // get user feed from instagram
  Future<List<Story>?> getStoriesListFromInstagram(
      {required String dataName, required int pageKey, required int pageSize, String? searchTerm, String? type}) async {
    late User currentUser;
    // get user info
    final failureOrCurrentUser = await getUser.execute();
    if (failureOrCurrentUser.isLeft()) {
      final failure = (failureOrCurrentUser as Left).value;
    } else {
      currentUser = (failureOrCurrentUser as Right).value;
    }

    // get stories list from instagram and save it to local
    final Either<Failure, List<Story>?> userFeedEither = await getStoriesFromLocal.execute(
        boxKey: Story.boxKey, pageKey: pageKey, pageSize: pageSize, searchTerm: searchTerm, type: type);
    if (userFeedEither.isRight()) {
      final List<Story> storiesList = (userFeedEither as Right).value;
      // cach stories on local
      await cacheStoriesToLocal.execute(boxKey: Story.boxKey, storiesList: storiesList);
    }
    if (userFeedEither.isLeft()) {
      emit(const StoriesListFailure(message: 'Failed to get stories'));
      return null;
    } else {
      final stories = (userFeedEither as Right).value;
      if (stories != null) {
        return stories;
      } else {
        return null;
      }
    }
  }

  // get cached stories from local
  Future<List<Story>?> getStoriesListFromLocal(
      {required String boxKey, required int pageKey, required int pageSize, String? searchTerm, String? type}) async {
    final failureOrStories = await getStoriesFromLocal.execute(
        boxKey: boxKey, pageKey: pageKey, pageSize: pageSize, searchTerm: searchTerm, type: type);
    if (failureOrStories == null || failureOrStories.isLeft()) {
      emit(const StoriesListFailure(message: 'Failed to get stories'));
      return null;
    } else {
      final stories = (failureOrStories as Right).value;
      if (stories != null) {
        return stories;
      } else {
        return null;
      }
    }
  }
}
