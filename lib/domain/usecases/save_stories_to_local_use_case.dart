import 'package:igshark/domain/entities/story.dart';
import 'package:igshark/domain/repositories/local/local_repository.dart';

class CacheStoriesToLocalUseCase {
  final LocalRepository localRepository;
  CacheStoriesToLocalUseCase({required this.localRepository});

  Future<void> execute({required String boxKey, required List<Story> storiesList, required String ownerId}) async {
    return localRepository.cacheStoriesList(boxKey: boxKey, storiesList: storiesList, ownerId: ownerId);
  }
}
