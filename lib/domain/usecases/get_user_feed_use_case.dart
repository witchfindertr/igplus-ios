import 'package:dartz/dartz.dart';
import 'package:igplus_ios/data/failure.dart';
import 'package:igplus_ios/domain/entities/ig_headers.dart';
import 'package:igplus_ios/domain/entities/media.dart';
import 'package:igplus_ios/domain/repositories/instagram/instagram_repository.dart';

class GetUserFeedUseCase {
  final InstagramRepository instagramRepository;
  GetUserFeedUseCase({required this.instagramRepository});

  Future<Either<Failure, List<Media>>> execute({required String userId, required IgHeaders igHeaders}) async {
    return instagramRepository.getUserFeed(userId: userId, igHeaders: igHeaders);
  }
}
