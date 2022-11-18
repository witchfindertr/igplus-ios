import 'package:dartz/dartz.dart';
import 'package:igshark/domain/entities/story_viewer.dart';
import 'package:igshark/domain/repositories/instagram/instagram_repository.dart';

import '../../data/failure.dart';
import '../entities/ig_headers.dart';

class GetStoryViewersUseCase {
  final InstagramRepository instagramRepository;

  GetStoryViewersUseCase({required this.instagramRepository});

  Future<Either<Failure, List<StoryViewer>>> execute({required String mediaId, required IgHeaders igHeaders}) async {
    return await instagramRepository.getStoryViewers(mediaId: mediaId, igHeaders: igHeaders);
  }
}
