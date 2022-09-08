import 'package:igplus_ios/data/failure.dart';
import 'package:igplus_ios/domain/entities/friend.dart';
import 'package:igplus_ios/domain/repositories/local/local_repository.dart';
import 'package:dartz/dartz.dart';

class GetFriendsFromLocalUseCase {
  final LocalRepository localRepository;
  GetFriendsFromLocalUseCase({required this.localRepository});

  Future<Either<Failure, List<Friend>?>?> execute({required String dataName}) async {
    if (dataName == "followings") {
      return localRepository.getCachedFriendsList(boxKey: Friend.followingsBoxKey);
    }

    return localRepository.getCachedFriendsList(boxKey: dataName);
  }
}
