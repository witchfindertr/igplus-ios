import 'package:igshark/data/failure.dart';
import 'package:igshark/domain/entities/media_commenter.dart';
import 'package:igshark/domain/repositories/local/local_repository.dart';
import 'package:dartz/dartz.dart';

class GetMediaCommentersFromLocalUseCase {
  final LocalRepository localRepository;
  GetMediaCommentersFromLocalUseCase({required this.localRepository});

  Either<Failure, List<MediaCommenter>?> execute(
      {int? mediaId, required String boxKey, required int pageKey, required int pageSize, String? searchTerm}) {
    try {
      final mediaCommenters = localRepository.getCachedMediaCommentersList(
          mediaId: mediaId, boxKey: boxKey, pageKey: pageKey, pageSize: pageSize, searchTerm: searchTerm);
      if (mediaCommenters.isLeft()) {
        return const Left(InvalidParamsFailure('No media commenters found'));
      } else {
        return mediaCommenters;
      }
    } catch (e) {
      return const Left(InvalidParamsFailure("GetMediaCommentersFromLocalUseCase catch"));
    }
  }
}
