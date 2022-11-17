import 'package:dartz/dartz.dart';
import 'package:igshark/data/failure.dart';
import 'package:igshark/domain/entities/ig_headers.dart';
import 'package:igshark/domain/entities/media_commenter.dart';
import 'package:igshark/domain/repositories/instagram/instagram_repository.dart';

class GetMediaCommentersUseCase {
  final InstagramRepository instagramRepository;

  GetMediaCommentersUseCase({required this.instagramRepository});

  Future<Either<Failure, List<MediaCommenter>>> execute({required String mediaId, required IgHeaders igHeaders}) async {
    return instagramRepository.getMediaCommenters(mediaId: mediaId, igHeaders: igHeaders);
  }
}
