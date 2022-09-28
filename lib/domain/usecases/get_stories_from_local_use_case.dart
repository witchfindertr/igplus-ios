import 'package:igplus_ios/data/failure.dart';
import 'package:igplus_ios/domain/entities/story.dart';
import 'package:igplus_ios/domain/repositories/local/local_repository.dart';
import 'package:dartz/dartz.dart';

class GetStoriesFromLocalUseCase {
  final LocalRepository localRepository;
  GetStoriesFromLocalUseCase({required this.localRepository});
// dataName: dataName, pageKey: pageKey, pageSize: pageSize, searchTerm: searchTerm, type: type)
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
