import 'package:igshark/domain/entities/stories_user.dart';
import 'package:igshark/domain/repositories/local/local_repository.dart';

class CacheStoriesUserToLocalUseCase {
  final LocalRepository localRepository;
  CacheStoriesUserToLocalUseCase({required this.localRepository});

  Future<void> execute({required String boxKey, required List<StoriesUser> storiesUserList}) async {
    return localRepository.cacheStoriesUsersList(boxKey: StoriesUser.boxKey, storiesUserList: storiesUserList);
  }
}
