import 'package:igplus_ios/data/failure.dart';
import 'package:igplus_ios/domain/entities/media.dart';
import 'package:igplus_ios/domain/entities/media_liker.dart';
import 'package:igplus_ios/domain/repositories/local/local_repository.dart';
import 'package:dartz/dartz.dart';

class GetMediaLikersFromLocalUseCase {
  final LocalRepository localRepository;
  GetMediaLikersFromLocalUseCase({required this.localRepository});

  Either<Failure, List<MediaLiker>?> execute(
      {String? mediaId, required String boxKey, required int pageKey, required int pageSize, String? searchTerm}) {
    try {
      final mediaLikers = localRepository.getCachedMediaLikersList(
          mediaId: mediaId, boxKey: boxKey, pageKey: pageKey, pageSize: pageSize, searchTerm: searchTerm);
      if (mediaLikers.isLeft()) {
        return const Left(InvalidParamsFailure('No media likers found'));
      } else {
        return mediaLikers;
      }
    } catch (e) {
      return const Left(InvalidParamsFailure("GetMediaLikersFromLocalUseCase catch"));
    }
  }
}
