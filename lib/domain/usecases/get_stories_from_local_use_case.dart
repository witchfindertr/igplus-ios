import 'package:igshark/data/failure.dart';
import 'package:igshark/domain/entities/story.dart';
import 'package:igshark/domain/repositories/local/local_repository.dart';
import 'package:dartz/dartz.dart';

class GetStoriesFromLocalUseCase {
  final LocalRepository localRepository;
  GetStoriesFromLocalUseCase({required this.localRepository});
// boxKey: boxKey, pageKey: pageKey, pageSize: pageSize, searchTerm: searchTerm, type: type)
  Future<Either<Failure, List<Story>?>> execute({
    required String boxKey,
    required int pageKey,
    required int pageSize,
    String? searchTerm,
    String? type,
    required String ownerId,
  }) async {
    // get media list from local
    return localRepository.getCachedStoriesList(
        boxKey: boxKey, pageKey: pageKey, pageSize: pageSize, searchTerm: searchTerm, type: type, ownerId: ownerId);
  }
}
