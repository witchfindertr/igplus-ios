import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:igplus_ios/data/failure.dart';
import 'package:igplus_ios/domain/entities/stories_user.dart';
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

  void init() async {
    emit(StoriesListLoading());

    late User currentUser;
    // get user info
    final failureOrCurrentUser = await getUser.execute();
    if (failureOrCurrentUser.isLeft()) {
      final failure = (failureOrCurrentUser as Left).value;
    } else {
      currentUser = (failureOrCurrentUser as Right).value;
    }
    // get stories list from local
    getStoriesListFromLocal(
      boxKey: StoriesUser.boxKey,
      pageKey: 0,
      pageSize: pageSize,
      type: "mostViewedStories",
    ).then((value) {
      if (value != null) {
        emit(StoriesListSuccess(storiesList: value, pageKey: 0));
      } else {
        // get stories from instagram
        getStoriesListFromInstagram(
          dataName: StoriesUser.boxKey,
          pageKey: 0,
          pageSize: pageSize,
        ).then((value) {
          if (value != null) {
            emit(StoriesListSuccess(storiesList: value, pageKey: 0));
            // cache new medai list to local
            cacheStoriesToLocal.execute(boxKey: StoriesUser.boxKey, storiesList: value, ownerId: currentUser.igUserId);
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
        boxKey: StoriesUser.boxKey,
        pageKey: pageKey,
        pageSize: pageSize,
        searchTerm: searchTerm,
        type: type,
        ownerId: currentUser.igUserId);
    if (userFeedEither.isRight()) {
      final List<Story> storiesList = (userFeedEither as Right).value;
      // cach stories on local
      await cacheStoriesToLocal.execute(
          boxKey: StoriesUser.boxKey, storiesList: storiesList, ownerId: currentUser.igUserId);
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
    late User currentUser;
    // get user info
    final failureOrCurrentUser = await getUser.execute();
    if (failureOrCurrentUser.isLeft()) {
      final failure = (failureOrCurrentUser as Left).value;
    } else {
      currentUser = (failureOrCurrentUser as Right).value;
    }
    final failureOrStories = await getStoriesFromLocal.execute(
        boxKey: boxKey,
        pageKey: pageKey,
        pageSize: pageSize,
        searchTerm: searchTerm,
        type: type,
        ownerId: currentUser.igUserId);
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
