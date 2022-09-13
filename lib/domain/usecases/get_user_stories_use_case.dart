import 'package:dartz/dartz.dart';
import 'package:igplus_ios/domain/entities/User_story.dart';
import 'package:igplus_ios/domain/repositories/instagram/instagram_repository.dart';

import '../../data/failure.dart';
import '../entities/ig_headers.dart';

class GetUserStoriesUseCase {
  final InstagramRepository instagramRepository;

  GetUserStoriesUseCase(this.instagramRepository);

  Future<Either<Failure, List<UserStory>>> execute({required IgHeaders igHeaders}) async {
    return await instagramRepository.getUserStories(igHeaders: igHeaders);
  }
}
