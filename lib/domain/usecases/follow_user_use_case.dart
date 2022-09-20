import 'package:dartz/dartz.dart';
import 'package:igplus_ios/data/failure.dart';
import 'package:igplus_ios/domain/entities/ig_headers.dart';
import 'package:igplus_ios/domain/repositories/instagram/instagram_repository.dart';

class FollowUserUseCase {
  final InstagramRepository instagramRepository;
  FollowUserUseCase({required this.instagramRepository});

  // follow user
  Future<Either<Failure, bool>> execute({required int userId, required IgHeaders igHeaders}) async {
    return instagramRepository.followUser(userId: userId, igHeaders: igHeaders);
  }
}
