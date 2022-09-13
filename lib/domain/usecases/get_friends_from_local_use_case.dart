import 'package:igplus_ios/data/failure.dart';
import 'package:igplus_ios/domain/entities/friend.dart';
import 'package:igplus_ios/domain/repositories/local/local_repository.dart';
import 'package:dartz/dartz.dart';

class GetFriendsFromLocalUseCase {
  final LocalRepository localRepository;
  GetFriendsFromLocalUseCase({required this.localRepository});

  Future<Either<Failure, List<Friend>?>?> execute(
      {required String dataName, int? pageKey, int? pageSize, String? searchTerm}) async {
    if (dataName == "followings") {
      return localRepository.getCachedFriendsList(
          boxKey: Friend.followingsBoxKey, pageKey: pageKey, pageSize: pageSize, searchTerm: searchTerm);
    } else if (dataName == "newFollowers") {
      return localRepository.getCachedFriendsList(
          boxKey: Friend.newFollowersBoxKey, pageKey: pageKey, pageSize: pageSize, searchTerm: searchTerm);
    } else if (dataName == "lostFollowers") {
      return localRepository.getCachedFriendsList(
          boxKey: Friend.lostFollowersBoxKey, pageKey: pageKey, pageSize: pageSize, searchTerm: searchTerm);
    } else if (dataName == "notFollowingBack") {
      return localRepository.getCachedFriendsList(
          boxKey: Friend.notFollowingBackBoxKey, pageKey: pageKey, pageSize: pageSize, searchTerm: searchTerm);
    } else if (dataName == "youDontFollowBack") {
      return localRepository.getCachedFriendsList(
          boxKey: Friend.youDontFollowBackBoxKey, pageKey: pageKey, pageSize: pageSize, searchTerm: searchTerm);
    } else if (dataName == "youHaveUnfollowed") {
      return localRepository.getCachedFriendsList(
          boxKey: Friend.youHaveUnfollowedBoxKey, pageKey: pageKey, pageSize: pageSize, searchTerm: searchTerm);
    } else if (dataName == "mutualFollowings") {
      return localRepository.getCachedFriendsList(
          boxKey: Friend.mutualFollowingsBoxKey, pageKey: pageKey, pageSize: pageSize, searchTerm: searchTerm);
    }

    // return followers list
    return localRepository.getCachedFriendsList(boxKey: Friend.followersBoxKey);
  }
}
