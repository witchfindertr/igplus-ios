import 'package:igplus_ios/data/failure.dart';
import 'package:igplus_ios/domain/entities/media.dart';
import 'package:igplus_ios/domain/repositories/local/local_repository.dart';
import 'package:dartz/dartz.dart';

class GetMediaFromLocalUseCase {
  final LocalRepository localRepository;
  GetMediaFromLocalUseCase({required this.localRepository});

  Future<Either<Failure, List<Media>?>?> execute(
      {required String dataName, int? pageKey, int? pageSize, String? searchTerm, String? type}) async {
    // get media list from local
    return localRepository.getCachedMediaList(
        boxKey: Media.boxKey, pageKey: pageKey, pageSize: pageSize, searchTerm: searchTerm, type: type);
  }
}
