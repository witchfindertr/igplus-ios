import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:igplus_ios/data/failure.dart';
import 'package:igplus_ios/domain/entities/stories_user.dart';
import 'package:igplus_ios/domain/entities/story.dart';
import 'package:igplus_ios/domain/entities/user.dart';
import 'package:igplus_ios/domain/usecases/get_stories_from_local_use_case.dart';
import 'package:igplus_ios/domain/usecases/get_stories_use_case.dart';
import 'package:igplus_ios/domain/usecases/get_user_feed_use_case.dart';
import 'package:igplus_ios/domain/usecases/get_user_use_case.dart';
import 'package:igplus_ios/domain/usecases/save_stories_to_local_use_case.dart';
import 'package:igplus_ios/presentation/blocs/home/report/cubit/report_cubit.dart';

part 'stories_insight_state.dart';

class StoriesInsightCubit extends Cubit<StoriesInsightState> {
  final GetStoriesFromLocalUseCase getStoriesFromLocal;
  final GetUserFeedUseCase getUserFeed;
  final GetUserUseCase getUser;
  final CacheStoriesToLocalUseCase cacheStoriesToLocal;
  final GetStoriesUseCase getStoriesUseCase;
  StoriesInsightCubit({
    required this.getStoriesFromLocal,
    required this.getUserFeed,
    required this.getUser,
    required this.cacheStoriesToLocal,
    required this.getStoriesUseCase,
  }) : super(StoriesListInitial());

  final int pageSize = 10;

  Future<List<Story>?> init(
      {required String boxKey, required int pageKey, required int pageSize, String? searchTerm, String? type}) async {
    emit(StoriesListLoading());

    late User currentUser;

    // get stories list from local
    // List<Story>? storiesList = await getStoriesListFromLocal(
    //   boxKey: StoriesUser.boxKey,
    //   pageKey: 0,
    //   pageSize: pageSize,
    //   type: "mostViewedStories",
    //   currentUser: currentUser,
    // );
    // if (storiesList != null) {
    //   emit(StoriesListSuccess(storiesList: storiesList, pageKey: 0));
    // } else {
    // get user info
    final failureOrCurrentUser = await getUser.execute();
    if (failureOrCurrentUser.isLeft()) {
      emit(const StoriesListFailure(message: 'Failed to get user info'));
    } else {
      currentUser = (failureOrCurrentUser as Right).value;
    }
    // get stories from instagram
    try {
      List<Story>? storiesList = await getStoriesListFromInstagram(
        dataName: StoriesUser.boxKey,
        pageKey: 0,
        pageSize: pageSize,
        currentUser: currentUser,
      );
      if (storiesList != null) {
        emit(StoriesInsightSuccess(storiesList: storiesList, pageKey: 0));
        // cache new media list to local
        cacheStoriesToLocal.execute(
            boxKey: StoriesUser.boxKey, storiesList: storiesList, ownerId: currentUser.igUserId);
        return storiesList;
      } else {
        emit(const StoriesListFailure(message: 'Failed to get stories list from instagram'));
        return null;
      }
    } catch (e) {
      emit(const StoriesListFailure(message: 'Failed to get stories list from instagram'));
      return null;
    }
  }

  // get stories list from instagram
  Future<List<Story>?> getStoriesListFromInstagram(
      {required String dataName,
      required int pageKey,
      required int pageSize,
      String? searchTerm,
      String? type,
      required User currentUser}) async {
    // get stories list from instagram and save result to local
    final Either<Failure, List<Story?>> userFeedEither =
        await getStoriesUseCase.execute(storyOwnerId: currentUser.igUserId, igHeaders: currentUser.igHeaders);
    if (userFeedEither.isRight()) {
      final List<Story> storiesList = (userFeedEither as Right).value;
      // cach stories on local
      await cacheStoriesToLocal.execute(
          boxKey: StoriesUser.boxKey, storiesList: storiesList, ownerId: currentUser.igUserId);

      final stories = (userFeedEither as Right).value;
      if (stories != null) {
        emit(StoriesInsightSuccess(storiesList: stories, pageKey: 0));
        return stories;
      } else {
        return null;
      }
    }
    if (userFeedEither.isLeft()) {
      emit(const StoriesListFailure(message: 'Failed to get stories'));
      return null;
    }
  }

  // get cached stories from local
  Future<List<Story>?> getStoriesListFromLocal(
      {required String boxKey,
      required int pageKey,
      required int pageSize,
      String? searchTerm,
      String? type,
      required User currentUser}) async {
    final failureOrStories = await getStoriesFromLocal.execute(
        boxKey: boxKey,
        pageKey: pageKey,
        pageSize: pageSize,
        searchTerm: searchTerm,
        type: type,
        ownerId: currentUser.igUserId);
    if (failureOrStories.isLeft()) {
      emit(const StoriesListFailure(message: 'Failed to get stories'));
      return null;
    } else {
      final stories = (failureOrStories as Right).value;
      if (stories != null) {
        emit(StoriesInsightSuccess(storiesList: stories, pageKey: 0));
        return stories;
      } else {
        return null;
      }
    }
  }
}
