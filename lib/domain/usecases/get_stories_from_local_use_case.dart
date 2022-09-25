import 'package:igplus_ios/data/failure.dart';
import 'package:igplus_ios/domain/entities/story.dart';
import 'package:igplus_ios/domain/repositories/local/local_repository.dart';
import 'package:dartz/dartz.dart';

class GetStoriesFromLocalUseCase {
  final LocalRepository localRepository;
  GetStoriesFromLocalUseCase({required this.localRepository});

  Future<Either<Failure, List<Story>?>> execute() async {
    // get media list from local
    return localRepository.getCachedStoriesList(boxKey: Story.boxKey);
  }
}
