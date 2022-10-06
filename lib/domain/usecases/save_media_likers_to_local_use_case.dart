import 'package:igplus_ios/domain/entities/media.dart';
import 'package:igplus_ios/domain/entities/media_liker.dart';
import 'package:igplus_ios/domain/repositories/local/local_repository.dart';

class CacheMediaLikersToLocalUseCase {
  final LocalRepository localRepository;
  CacheMediaLikersToLocalUseCase({required this.localRepository});

  Future<void> execute({
    required String boxKey,
    required List<MediaLiker> mediaLikersList,
  }) async {
    return localRepository.cacheMediaLikersList(boxKey: boxKey, mediaLikersList: mediaLikersList);
  }
}
