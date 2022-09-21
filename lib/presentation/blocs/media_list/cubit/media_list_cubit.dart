import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:igplus_ios/domain/entities/media.dart';
import 'package:igplus_ios/domain/usecases/get_media_from_local_use_case.dart';

part 'media_list_state.dart';

class MediaListCubit extends Cubit<MediaListState> {
  final GetMediaFromLocalUseCase getMediaFromLocal;
  MediaListCubit({
    required this.getMediaFromLocal,
  }) : super(MediaListInitial());

  // get cached media from local
  Future<List<Media>?> getMediaList(
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
