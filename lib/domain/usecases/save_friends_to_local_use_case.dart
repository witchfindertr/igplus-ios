import 'package:igshark/domain/entities/friend.dart';
import 'package:igshark/domain/repositories/local/local_repository.dart';

class CacheFriendsToLocalUseCase {
  final LocalRepository localRepository;
  CacheFriendsToLocalUseCase({required this.localRepository});

  Future<void> execute({required String boxKey, required List<Friend> friendsList}) async {
    if (boxKey == "followers") {
      return localRepository.cacheFriendsList(boxKey: Friend.followersBoxKey, friendsList: friendsList);
    } else if (boxKey == "followings") {
      return localRepository.cacheFriendsList(boxKey: Friend.followingsBoxKey, friendsList: friendsList);
    } else if (boxKey == "newFollowers") {
      return localRepository.cacheFriendsList(boxKey: Friend.newFollowersBoxKey, friendsList: friendsList);
    } else if (boxKey == "lostFollowers") {
      return localRepository.cacheFriendsList(boxKey: Friend.lostFollowersBoxKey, friendsList: friendsList);
    } else if (boxKey == "notFollowingBack") {
      return localRepository.cacheFriendsList(boxKey: Friend.notFollowingBackBoxKey, friendsList: friendsList);
    } else if (boxKey == "youDontFollowBack") {
      return localRepository.cacheFriendsList(boxKey: Friend.youDontFollowBackBoxKey, friendsList: friendsList);
    } else if (boxKey == "youHaveUnfollowed") {
      return localRepository.cacheFriendsList(boxKey: Friend.youHaveUnfollowedBoxKey, friendsList: friendsList);
    } else if (boxKey == "mutualFollowings") {
      return localRepository.cacheFriendsList(boxKey: Friend.mutualFollowingsBoxKey, friendsList: friendsList);
    } else if (boxKey == "newStoryViewers") {
      return localRepository.cacheFriendsList(boxKey: Friend.newStoryViewersBoxKey, friendsList: friendsList);
    }
  }
}
