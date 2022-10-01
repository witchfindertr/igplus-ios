import 'package:igplus_ios/data/failure.dart';
import 'package:igplus_ios/domain/entities/story_viewer.dart';
import 'package:igplus_ios/domain/repositories/local/local_repository.dart';
import 'package:dartz/dartz.dart';

class GetStoryViewersFromLocalUseCase {
  final LocalRepository localRepository;
  GetStoryViewersFromLocalUseCase({required this.localRepository});

  Future<Either<Failure, List<StoryViewer>?>> execute({
    required String boxKey,
    required String mediaId,
    int? pageKey,
    int? pageSize,
    String? searchTerm,
  }) async {
    // get stories viewers from local
    final storiesViewers = localRepository.getCachedStoryViewersList(
      boxKey: boxKey,
      mediaId: mediaId,
      pageKey: pageKey,
      pageSize: pageSize,
      searchTerm: searchTerm,
    );

    // return followers list
    return storiesViewers;
  }
}
