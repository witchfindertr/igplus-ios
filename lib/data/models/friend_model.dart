import 'package:equatable/equatable.dart';

import '../../domain/entities/friend.dart';

class FriendModel extends Equatable {
  final int igUserId;
  final String username;
  final String picture;
  const FriendModel({
    required this.igUserId,
    required this.username,
    required this.picture,
  });

  factory FriendModel.fromJson(Map<String, dynamic> json) {
    return FriendModel(
      igUserId: json['pk'],
      username: json['username'],
      picture: json['profile_pic_url'],
    );
  }

  factory FriendModel.fromFriend(Friend friend) {
    return FriendModel(
      igUserId: friend.igUserId,
      username: friend.username,
      picture: friend.picture,
    );
  }

  Friend toEntity() {
    return Friend(
      igUserId: igUserId,
      username: username,
      picture: picture,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        igUserId,
        username,
        picture,
      ];
}
