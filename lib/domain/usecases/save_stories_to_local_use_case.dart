import 'package:igplus_ios/domain/entities/media.dart';
import 'package:igplus_ios/domain/entities/story.dart';
import 'package:igplus_ios/domain/repositories/local/local_repository.dart';

class CacheStoriesToLocalUseCase {
  final LocalRepository localRepository;
  CacheStoriesToLocalUseCase({required this.localRepository});

  Future<void> execute({required String dataName, required List<Story> storiesList}) async {
    return localRepository.cacheStoriesList(boxKey: Story.boxKey, storiesList: storiesList);
  }
}
