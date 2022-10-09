import 'package:igplus_ios/domain/entities/media_commenter.dart';
import 'package:igplus_ios/domain/repositories/local/local_repository.dart';

class CacheMediaCommentersToLocalUseCase {
  final LocalRepository localRepository;
  CacheMediaCommentersToLocalUseCase({required this.localRepository});

  Future<void> execute({
    required String boxKey,
    required List<MediaCommenter> mediaCommentersList,
  }) async {
    return localRepository.cacheMediaCommentersList(boxKey: boxKey, mediaCommentersList: mediaCommentersList);
  }
}
