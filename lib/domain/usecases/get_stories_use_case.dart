import 'package:dartz/dartz.dart';
import 'package:igshark/domain/repositories/instagram/instagram_repository.dart';

import '../../data/failure.dart';
import '../entities/ig_headers.dart';
import '../entities/story.dart';

class GetStoriesUseCase {
  final InstagramRepository instagramRepository;

  GetStoriesUseCase({required this.instagramRepository});

  Future<Either<Failure, List<Story?>>> execute({required String storyOwnerId, required IgHeaders igHeaders}) async {
    return await instagramRepository.getStories(userId: storyOwnerId, igHeaders: igHeaders);
  }
}
