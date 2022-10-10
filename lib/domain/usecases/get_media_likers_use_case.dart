import 'package:dartz/dartz.dart';
import 'package:igplus_ios/data/failure.dart';
import 'package:igplus_ios/domain/entities/ig_headers.dart';
import 'package:igplus_ios/domain/entities/media_liker.dart';
import 'package:igplus_ios/domain/repositories/instagram/instagram_repository.dart';

class GetMediaLikersUseCase {
  final InstagramRepository instagramRepository;

  GetMediaLikersUseCase({required this.instagramRepository});

  Future<Either<Failure, List<MediaLiker>>> execute({required String mediaId, required IgHeaders igHeaders}) async {
    return instagramRepository.getMediaLikers(mediaId: mediaId, igHeaders: igHeaders);
  }
}
