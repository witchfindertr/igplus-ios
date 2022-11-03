import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:igplus_ios/data/failure.dart';
import 'package:igplus_ios/domain/entities/media.dart';
import 'package:igplus_ios/domain/entities/user.dart';
import 'package:igplus_ios/domain/usecases/get_media_from_local_use_case.dart';
import 'package:igplus_ios/domain/usecases/get_user_feed_use_case.dart';
import 'package:igplus_ios/domain/usecases/get_user_use_case.dart';
import 'package:igplus_ios/domain/usecases/save_media_to_local_use_case.dart';

part 'media_list_state.dart';

class MediaListCubit extends Cubit<MediaListState> {
  final GetMediaFromLocalUseCase getMediaFromLocal;
  final GetUserFeedUseCase getUserFeed;
  final GetUserUseCase getUser;
  final CacheMediaToLocalUseCase cacheMediaToLocal;
  MediaListCubit({
    required this.getMediaFromLocal,
    required this.getUserFeed,
    required this.getUser,
    required this.cacheMediaToLocal,
  }) : super(MediaListInitial()) {
    init();
  }

  final int pageSize = 10;

  Future<void> init() async {
    emit(MediaListLoading());
    // get media list from local
    final mediaList = await getMediaListFromLocal(
      boxKey: Media.boxKey,
      pageKey: 0,
      pageSize: pageSize,
    );

    if (mediaList != null) {
      emit(MediaListSuccess(mediaList: mediaList, pageKey: 0));
    } else {
      // get media from instagram
      final mediaList = await getMediaListFromInstagram(
        boxKey: Media.boxKey,
        pageKey: 0,
        pageSize: pageSize,
      );

      if (mediaList != null) {
        emit(MediaListSuccess(mediaList: mediaList, pageKey: 0));
        // cache new medai list to local
        cacheMediaToLocal.execute(boxKey: Media.boxKey, mediaList: mediaList);
      } else {
        emit(const MediaListFailure(message: 'Failed to get media list from instagram'));
      }
    }
  }

  // get user feed from instagram
  Future<List<Media>?> getMediaListFromInstagram(
      {required String boxKey, required int pageKey, required int pageSize, String? searchTerm, String? type}) async {
    late User currentUser;
    // get user info
    final failureOrCurrentUser = await getUser.execute();
    if (failureOrCurrentUser.isLeft()) {
      return null;
    } else {
      currentUser = (failureOrCurrentUser as Right).value;
    }

    // get media list from instagram and save it to local
    final Either<Failure, List<Media>> userFeedEither =
        await getUserFeed.execute(userId: currentUser.igUserId, igHeaders: currentUser.igHeaders);
    if (userFeedEither.isRight()) {
      final List<Media> mediaList = (userFeedEither as Right).value;
      // cach media on local
      await cacheMediaToLocal.execute(boxKey: Media.boxKey, mediaList: mediaList);
    }
    if (userFeedEither.isLeft()) {
      emit(const MediaListFailure(message: 'Failed to get media'));
      return null;
    } else {
      final media = (userFeedEither as Right).value;
      if (media != null) {
        return media;
      } else {
        return null;
      }
    }
  }

  // get cached media from local
  Future<List<Media>?> getMediaListFromLocal(
      {required String boxKey, required int pageKey, required int pageSize, String? searchTerm, String? type}) async {
    final failureOrMedia = await getMediaFromLocal.execute(
        boxKey: boxKey, pageKey: pageKey, pageSize: pageSize, searchTerm: searchTerm, type: type);
    if (failureOrMedia == null || failureOrMedia.isLeft()) {
      emit(const MediaListFailure(message: 'Failed to get media'));
      return null;
    } else {
      final media = (failureOrMedia as Right).value;
      if (media != null) {
        return media;
      } else {
        return null;
      }
    }
  }
}
