import 'package:igplus_ios/domain/entities/media.dart';
import 'package:igplus_ios/domain/repositories/local/local_repository.dart';

class CacheMediaToLocalUseCase {
  final LocalRepository localRepository;
  CacheMediaToLocalUseCase({required this.localRepository});

  Future<void> execute({required String dataName, required List<Media> mediaList}) async {
    return localRepository.cacheMediaList(boxKey: Media.boxKey, mediaList: mediaList);
  }
}