import 'package:igplus_ios/domain/entities/story_viewer.dart';
import 'package:igplus_ios/domain/repositories/local/local_repository.dart';

class CacheStoryViewersToLocalUseCase {
  final LocalRepository localRepository;
  CacheStoryViewersToLocalUseCase({required this.localRepository});

  Future<void> execute({required List<StoryViewer> storiesViewersList, required String boxKey}) async {
    return localRepository.cacheStoryViewersList(storiesViewersList: storiesViewersList, boxKey: boxKey);
  }
}
