import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:igplus_ios/data/failure.dart';
import 'package:igplus_ios/data/models/media_likers_model.dart';
import 'package:igplus_ios/domain/entities/media.dart';
import 'package:igplus_ios/domain/entities/media_liker.dart';
import 'package:igplus_ios/domain/entities/media_likers.dart';
import 'package:igplus_ios/domain/entities/user.dart';
import 'package:igplus_ios/domain/usecases/get_media_from_local_use_case.dart';
import 'package:igplus_ios/domain/usecases/get_media_likers_from_local_use_case.dart';
import 'package:igplus_ios/domain/usecases/get_media_likers_use_case.dart';
import 'package:igplus_ios/domain/usecases/get_user_use_case.dart';
import 'package:igplus_ios/domain/usecases/save_media_likers_to_local_use_case.dart';
import 'package:igplus_ios/presentation/views/insight/media/media_list/media_list.dart';

part 'media_likers_state.dart';

class MediaLikersCubit extends Cubit<MediaLikersState> {
  final GetMediaLikersUseCase getMediaLikersUseCase;
  final GetMediaFromLocalUseCase getMediaFromLocalUseCase;
  final CacheMediaLikersToLocalUseCase cacheMediaLikersToLocalUseCase;
  final GetMediaLikersFromLocalUseCase getMediaLikersFromLocalUseCase;
  final GetUserUseCase getUser;
  MediaLikersCubit({
    required this.getMediaLikersUseCase,
    required this.getUser,
    required this.getMediaFromLocalUseCase,
    required this.cacheMediaLikersToLocalUseCase,
    required this.getMediaLikersFromLocalUseCase,
  }) : super(MediaLikersInitial());

  Future<List<MediaLiker>?> init({
    required String boxKey,
    int pageKey = 0,
    required int pageSize,
    String? searchTerm,
  }) async {
    emit(MediaLikersLoading());
    List<MediaLiker> mediaLikersList = [];
    List<Media> mediaList;

    // get media likers from local
    final mediaLikersFromLocal = getMediaLikersFromLocalUseCase.execute(
        boxKey: MediaLiker.boxKey, pageKey: pageKey, pageSize: pageSize, searchTerm: searchTerm);

    if (mediaLikersFromLocal.isRight() && mediaLikersFromLocal.getOrElse(() => null) != null) {
      mediaLikersList = mediaLikersFromLocal.getOrElse(() => null)!;
      emit(MediaLikersSuccess(mediaLikers: mediaLikersList, pageKey: 0));
      return mediaLikersList;
    }
    if (mediaLikersList.isEmpty) {
      // get media list from local
      Either<Failure, List<Media>?>? mediaListOrFailure =
          await getMediaFromLocalUseCase.execute(boxKey: MediaLiker.boxKey, pageKey: 0, pageSize: 100);

      if (mediaListOrFailure != null && mediaListOrFailure.isRight()) {
        mediaList = mediaListOrFailure.getOrElse(() => null) ?? [];

        for (var media in mediaList) {
          // get media likers from instagram
          List<MediaLiker>? mediaLikers = await getMediaLikers(mediaId: media.id, boxKey: MediaLiker.boxKey);
          if (mediaLikers != null) {
            mediaLikersList.addAll(mediaLikers);
            // save media likers to local
            await cacheMediaLikersToLocalUseCase.execute(boxKey: MediaLiker.boxKey, mediaLikersList: mediaLikers);
          }

          await Future.delayed(const Duration(seconds: 2));
        }
        emit(MediaLikersSuccess(mediaLikers: mediaLikersList, pageKey: 0));
        return mediaLikersList;
      }
    }
    return null;
  }

  Future<List<MediaLiker>?> getMediaLikers({required int mediaId, required String boxKey}) async {
    emit(MediaLikersLoading());
    // get header current user header
    User currentUser = await getCurrentUser();

    Either<Failure, List<MediaLiker>> mediaLikersOrFailure =
        await getMediaLikersUseCase.execute(mediaId: mediaId, igHeaders: currentUser.igHeaders);
    if (mediaLikersOrFailure.isLeft()) {
      emit(const MediaLikersFailure(message: 'Error getting media likers list'));
      return null;
    } else {
      List<MediaLiker> mediaLikers;
      mediaLikers = mediaLikersOrFailure.getOrElse(() => []);
      emit(MediaLikersSuccess(mediaLikers: mediaLikers, pageKey: 0));
      return mediaLikers;
    }
  }

  // get users with most likes
  Future<List<MediaLikers>?> getMostLikesUsers(
      {required String boxKey, int pageKey = 0, required int pageSize, String? searchTerm}) async {
    emit(MediaLikersLoading());
    List<MediaLiker> mediaLikersList = [];

    // get media likers from local
    final mediaLikersFromLocal = getMediaLikersFromLocalUseCase.execute(
        boxKey: MediaLiker.boxKey, pageKey: pageKey, pageSize: pageSize, searchTerm: searchTerm);

    if (mediaLikersFromLocal.isRight() && mediaLikersFromLocal.getOrElse(() => null) != null) {
      mediaLikersList = mediaLikersFromLocal.getOrElse(() => null)!;
      emit(MediaLikersSuccess(mediaLikers: mediaLikersList, pageKey: 0));

      // group by user id
      Map<String, List<MediaLiker>> mediaLikersMap = {};
      for (var mediaLiker in mediaLikersList) {
        if (mediaLikersMap.containsKey(mediaLiker.user.igUserId.toString())) {
          mediaLikersMap[mediaLiker.user.igUserId.toString()]!.add(mediaLiker);
        } else {
          mediaLikersMap[mediaLiker.user.igUserId.toString()] = [mediaLiker];
        }
      }

      // format MedialLiker List to MediaLikers
      List<MediaLikers> mediaLikers = [];
      mediaLikersMap.forEach((key, value) {
        mediaLikers.add(MediaLikersModel.fromMediaLiker(value, key).toEntity());
      });

      // sort by likesCout
      mediaLikers.sort((a, b) => b.likesCount.compareTo(a.likesCount));

      return mediaLikers;
    }

    return null;
  }

  Future<User> getCurrentUser() async {
    late User currentUser;
    // get user info
    final failureOrCurrentUser = await getUser.execute();
    if (failureOrCurrentUser.isLeft()) {
      emit(const MediaLikersFailure(message: 'Failed to get user info'));
    } else {
      currentUser = (failureOrCurrentUser as Right).value;
    }
    return currentUser;
  }
}
