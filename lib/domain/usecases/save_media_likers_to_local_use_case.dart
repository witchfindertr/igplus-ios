import 'package:igshark/domain/entities/media.dart';
import 'package:igshark/domain/entities/media_liker.dart';
import 'package:igshark/domain/repositories/local/local_repository.dart';

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
