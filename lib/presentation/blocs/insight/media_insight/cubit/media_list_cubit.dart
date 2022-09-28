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
import 'package:igplus_ios/presentation/blocs/home/report/cubit/report_cubit.dart';

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

  void init() {
    emit(MediaListLoading());
    // get media list from local
    getMediaListFromLocal(
      dataName: Media.boxKey,
      pageKey: 0,
      pageSize: pageSize,
    ).then((value) {
      if (value != null) {
        emit(MediaListSuccess(mediaList: value, pageKey: 0));
      } else {
        // get media from instagram
        getMediaListFromInstagram(
          dataName: Media.boxKey,
          pageKey: 0,
          pageSize: pageSize,
        ).then((value) {
          if (value != null) {
            emit(MediaListSuccess(mediaList: value, pageKey: 0));
            // cache new medai list to local
            cacheMediaToLocal.execute(dataName: Media.boxKey, mediaList: value);
          } else {
            emit(const MediaListFailure(message: 'Failed to get media list from instagram'));
          }
        });
      }
    });
  }

  // get user feed from instagram
  Future<List<Media>?> getMediaListFromInstagram(
      {required String dataName, required int pageKey, required int pageSize, String? searchTerm, String? type}) async {
    late User currentUser;
    // get user info
    final failureOrCurrentUser = await getUser.execute();
    if (failureOrCurrentUser.isLeft()) {
      final failure = (failureOrCurrentUser as Left).value;
    } else {
      currentUser = (failureOrCurrentUser as Right).value;
    }

    // get media list from instagram and save it to local
    final Either<Failure, List<Media>> userFeedEither =
        await getUserFeed.execute(userId: currentUser.igUserId, igHeaders: currentUser.igHeaders);
    if (userFeedEither.isRight()) {
      final List<Media> mediaList = (userFeedEither as Right).value;
      // cach media on local
      await cacheMediaToLocal.execute(dataName: Media.boxKey, mediaList: mediaList);

      // get top likers
      // List<Map<int, int>> likersLikeCount = [];
      // for (Media media in mediaList) {
      //   for (Friend liker in media.topLikers) {
      //     if (likersLikeCount.isEmpty) {
      //       likersLikeCount.add({liker.igUserId: 1});
      //     } else {
      //       for (var likeCount in likersLikeCount) {
      //         if (likeCount.containsKey(liker.igUserId)) {
      //           likeCount[liker.igUserId] = likeCount[liker.igUserId]! + 1;
      //         } else {
      //           likeCount[liker.igUserId] = 1;
      //         }
      //       }
      //     }
      //   }
      // }
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
      {required String dataName, required int pageKey, required int pageSize, String? searchTerm, String? type}) async {
    final failureOrMedia = await getMediaFromLocal.execute(
        dataName: dataName, pageKey: pageKey, pageSize: pageSize, searchTerm: searchTerm, type: type);
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
