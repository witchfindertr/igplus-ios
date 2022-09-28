import 'package:igplus_ios/domain/entities/stories_user.dart';
import 'package:igplus_ios/domain/repositories/local/local_repository.dart';

class CacheStoriesUserToLocalUseCase {
  final LocalRepository localRepository;
  CacheStoriesUserToLocalUseCase({required this.localRepository});

  Future<void> execute({required String dataName, required List<StoriesUser> storiesUserList}) async {
    return localRepository.cacheStoriesUsersList(boxKey: StoriesUser.boxKey, storiesUserList: storiesUserList);
  }
}
