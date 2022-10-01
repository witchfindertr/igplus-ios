import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:igplus_ios/domain/entities/story_viewer.dart';
import 'package:igplus_ios/domain/usecases/follow_user_use_case.dart';
import 'package:igplus_ios/domain/usecases/get_story_viewers_from_local_use_case.dart';
import 'package:igplus_ios/domain/usecases/get_story_viewers_use_case.dart';
import 'package:igplus_ios/domain/usecases/get_user_use_case.dart';
import 'package:igplus_ios/domain/usecases/save_story_viewers_to_local_use_case.dart';
import 'package:igplus_ios/domain/usecases/unfollow_user_use_case%20copy.dart';

part 'story_viewers_state.dart';

class StoryViewersCubit extends Cubit<StoryViewersState> {
  final GetStoryViewersFromLocalUseCase getStoryViewersFromLocal;
  final GetStoryViewersUseCase getStoryViewers;
  final FollowUserUseCase followUserUseCase;
  final UnfollowUserUseCase unfollowUserUseCase;
  final CacheStoryViewersToLocalUseCase cacheStoryViewersToLocalUseCase;
  final GetUserUseCase getUser;
  StoryViewersCubit({
    required this.getStoryViewersFromLocal,
    required this.getStoryViewers,
    required this.followUserUseCase,
    required this.getUser,
    required this.unfollowUserUseCase,
    required this.cacheStoryViewersToLocalUseCase,
  }) : super(StoryViewersInitial());

  Future<List<StoryViewer>?> getStoryViewersList({
    required String mediaId,
    required String type,
    required int pageKey,
    int? pageSize,
    String? searchTerm,
  }) async {
    List<StoryViewer>? storyViewersList;
    storyViewersList = await _getStoryViewersListFromLocal(
      mediaId: mediaId,
      type: type,
      pageKey: pageKey,
      pageSize: pageSize,
      searchTerm: searchTerm,
    );

    if (storyViewersList != null) {
      emit(StoryViewersSuccess(storyViewersList: storyViewersList, pageKey: pageKey));
      return storyViewersList;
    } else {
      storyViewersList = await _getStoryViewersListFromInstagram(mediaId: mediaId);
      // save story viewers list to local
      if (storyViewersList != null) {
        await cacheStoryViewersToLocalUseCase.execute(storiesViewersList: storyViewersList, boxKey: StoryViewer.boxKey);
      }
      return storyViewersList;
    }
  }

  // get story viewers list from local
  Future<List<StoryViewer>?> _getStoryViewersListFromLocal({
    required String mediaId,
    required String type,
    int? pageKey,
    int? pageSize,
    String? searchTerm,
  }) async {
    emit(StoryViewersLoading());
    final failureOrStoryViewersList = await getStoryViewersFromLocal.execute(
      boxKey: type,
      mediaId: mediaId,
      pageKey: pageKey,
      pageSize: pageSize,
      searchTerm: searchTerm,
    );
    failureOrStoryViewersList.fold(
      (failure) => null,
      (storyViewersList) => storyViewersList,
    );

    if (failureOrStoryViewersList.isLeft()) {
      return null;
    } else {
      return (failureOrStoryViewersList as Right).value;
    }
  }

  // get story viewers list from instagram
  Future<List<StoryViewer>?> _getStoryViewersListFromInstagram({required String mediaId}) async {
    emit(StoryViewersLoading());
    // get header
    final failureOrCurrentUser = await getUser.execute();
    if (failureOrCurrentUser.isLeft()) {
      return null;
    }
    final currentUser = (failureOrCurrentUser as Right).value;
    // get story viewers list
    final failureOrStoryViewersList = await getStoryViewers.execute(mediaId: mediaId, igHeaders: currentUser.igHeaders);
    if (failureOrStoryViewersList.isLeft()) {
      return null;
    } else {
      // return viewers list
      return (failureOrStoryViewersList as Right).value;
    }
  }

  // follow user
  Future<bool> followUser({required int userId}) async {
    final failureOrCurrentUser = await getUser.execute();
    if (failureOrCurrentUser.isLeft()) {
      return false;
    } else {
      final currentUser = (failureOrCurrentUser as Right).value;
      final failureOrSuccess = await followUserUseCase.execute(userId: userId, igHeaders: currentUser.igHeaders);

      if (failureOrSuccess.isLeft()) {
        return false;
      } else {
        return true;
      }
    }
  }

  // unfollow user
  Future<bool> unfollowUser({required int userId}) async {
    final failureOrCurrentUser = await getUser.execute();
    if (failureOrCurrentUser.isLeft()) {
      return false;
    } else {
      final currentUser = (failureOrCurrentUser as Right).value;
      final failureOrSuccess = await unfollowUserUseCase.execute(userId: userId, igHeaders: currentUser.igHeaders);

      if (failureOrSuccess.isLeft()) {
        return false;
      } else {
        return true;
      }
    }
  }
}
