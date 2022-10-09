import 'package:dartz/dartz.dart';
import 'package:igplus_ios/data/failure.dart';
import 'package:igplus_ios/domain/entities/ig_headers.dart';
import 'package:igplus_ios/domain/entities/media_commenter.dart';
import 'package:igplus_ios/domain/repositories/instagram/instagram_repository.dart';

class GetMediaCommentersUseCase {
  final InstagramRepository instagramRepository;

  GetMediaCommentersUseCase({required this.instagramRepository});

  Future<Either<Failure, List<MediaCommenter>>> execute({required int mediaId, required IgHeaders igHeaders}) async {
    return instagramRepository.getMediaCommenters(mediaId: mediaId, igHeaders: igHeaders);
  }
}
