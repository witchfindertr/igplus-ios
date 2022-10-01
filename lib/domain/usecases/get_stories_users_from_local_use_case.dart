import 'package:igplus_ios/data/failure.dart';
import 'package:igplus_ios/domain/entities/stories_user.dart';
import 'package:igplus_ios/domain/repositories/local/local_repository.dart';
import 'package:dartz/dartz.dart';

class GetStoriesUsersFromLocalUseCase {
  final LocalRepository localRepository;
  GetStoriesUsersFromLocalUseCase({required this.localRepository});

  Future<Either<Failure, List<StoriesUser>?>> execute() async {
    // get media list from local
    return localRepository.getCachedStoriesUsersList(boxKey: StoriesUser.boxKey);
  }
}
