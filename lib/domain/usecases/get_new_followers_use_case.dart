import 'package:dartz/dartz.dart';

import '../../data/failure.dart';
import '../entities/friend.dart';
import '../repositories/instagram/instagram_repository.dart';

class GetNewFollowersUseCase {
  final InstagramRepository instagramRepository;

  GetNewFollowersUseCase({required this.instagramRepository});

  Future<Either<Failure, List<Friend>>> execute() async {
    return await instagramRepository.getNewFollowers();
  }
}
