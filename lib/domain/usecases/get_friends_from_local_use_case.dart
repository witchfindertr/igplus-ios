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
    } else if (dataName == "newFollowers") {
      return localRepository.getCachedFriendsList(boxKey: Friend.newFollowersBoxKey);
    } else if (dataName == "lostFollowers") {
      return localRepository.getCachedFriendsList(boxKey: Friend.lostFollowersBoxKey);
    } else if (dataName == "notFollowingBack") {
      return localRepository.getCachedFriendsList(boxKey: Friend.notFollowingBackBoxKey);
    } else if (dataName == "youDontFollowBack") {
      return localRepository.getCachedFriendsList(boxKey: Friend.youDontFollowBackBoxKey);
    } else if (dataName == "youHaveUnfollowed") {
      return localRepository.getCachedFriendsList(boxKey: Friend.youHaveUnfollowedBoxKey);
    } else if (dataName == "mutualFollowings") {
      return localRepository.getCachedFriendsList(boxKey: Friend.mutualFollowingsBoxKey);
    }

    // return followers list
    return localRepository.getCachedFriendsList(boxKey: Friend.followersBoxKey);
  }
}
