import 'package:dartz/dartz.dart';
import 'package:igshark/domain/entities/stories_user.dart';
import 'package:igshark/domain/repositories/instagram/instagram_repository.dart';

import '../../data/failure.dart';
import '../entities/ig_headers.dart';

class GetStoriesUsersUseCase {
  final InstagramRepository instagramRepository;

  GetStoriesUsersUseCase({required this.instagramRepository});

  Future<Either<Failure, List<StoriesUser>>> execute({required IgHeaders igHeaders}) async {
    return await instagramRepository.getUserStories(igHeaders: igHeaders);
  }
}
