import 'package:dartz/dartz.dart';

import '../../data/failure.dart';
import '../entities/friend.dart';
import '../repositories/instagram/instagram_repository.dart';

class GetNewFollowers {
  final InstagramRepository instagramRepository;

  GetNewFollowers({required this.instagramRepository});

  Future<Either<Failure, List<Friend>>> execute() async {
    return await instagramRepository.getNewFollowers();
  }
}
