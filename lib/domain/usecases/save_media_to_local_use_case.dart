import 'package:igshark/domain/entities/media.dart';
import 'package:igshark/domain/repositories/local/local_repository.dart';

class CacheMediaToLocalUseCase {
  final LocalRepository localRepository;
  CacheMediaToLocalUseCase({required this.localRepository});

  Future<void> execute({required String boxKey, required List<Media> mediaList}) async {
    return localRepository.cacheMediaList(boxKey: Media.boxKey, mediaList: mediaList);
  }
}
