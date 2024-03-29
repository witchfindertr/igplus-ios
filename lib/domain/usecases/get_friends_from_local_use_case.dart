import 'package:igshark/data/failure.dart';
import 'package:igshark/domain/entities/friend.dart';
import 'package:igshark/domain/repositories/local/local_repository.dart';
import 'package:dartz/dartz.dart';

class GetFriendsFromLocalUseCase {
  final LocalRepository localRepository;
  GetFriendsFromLocalUseCase({required this.localRepository});

  Future<Either<Failure, List<Friend>?>?> execute(
      {required String boxKey, int? pageKey, int? pageSize, String? searchTerm}) async {
    if (boxKey == "followers") {
      return localRepository.getCachedFriendsList(boxKey: Friend.followersBoxKey);
    }
    if (boxKey == "followings") {
      return localRepository.getCachedFriendsList(
          boxKey: Friend.followingsBoxKey, pageKey: pageKey, pageSize: pageSize, searchTerm: searchTerm);
    } else if (boxKey == "newFollowers") {
      return localRepository.getCachedFriendsList(
          boxKey: Friend.newFollowersBoxKey, pageKey: pageKey, pageSize: pageSize, searchTerm: searchTerm);
    } else if (boxKey == "lostFollowers") {
      return localRepository.getCachedFriendsList(
          boxKey: Friend.lostFollowersBoxKey, pageKey: pageKey, pageSize: pageSize, searchTerm: searchTerm);
    } else if (boxKey == "notFollowingBack") {
      return localRepository.getCachedFriendsList(
          boxKey: Friend.notFollowingBackBoxKey, pageKey: pageKey, pageSize: pageSize, searchTerm: searchTerm);
    } else if (boxKey == "youDontFollowBack") {
      return localRepository.getCachedFriendsList(
          boxKey: Friend.youDontFollowBackBoxKey, pageKey: pageKey, pageSize: pageSize, searchTerm: searchTerm);
    } else if (boxKey == "youHaveUnfollowed") {
      return localRepository.getCachedFriendsList(
          boxKey: Friend.youHaveUnfollowedBoxKey, pageKey: pageKey, pageSize: pageSize, searchTerm: searchTerm);
    } else if (boxKey == "mutualFollowings") {
      return localRepository.getCachedFriendsList(
          boxKey: Friend.mutualFollowingsBoxKey, pageKey: pageKey, pageSize: pageSize, searchTerm: searchTerm);
    }

    return throw Exception("Invalid boxKey");
  }
}
