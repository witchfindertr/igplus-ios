import 'package:equatable/equatable.dart';

import '../../domain/entities/friend.dart';

class FriendModel extends Equatable {
  final int igUserId;
  final String username;
  final String picture;
  final DateTime createdOn;
  const FriendModel({
    required this.igUserId,
    required this.username,
    required this.picture,
    required this.createdOn,
  });

  factory FriendModel.fromJson(Map<String, dynamic> json) {
    return FriendModel(
      igUserId: json['pk'], //
      username: json['username'],
      picture: json['profile_pic_url'],
      createdOn: DateTime.now(),
    );
  }

  factory FriendModel.fromFriend(Friend friend) {
    return FriendModel(
      igUserId: friend.igUserId,
      username: friend.username,
      picture: friend.picture,
      createdOn: friend.createdOn,
    );
  }

  Friend toEntity() {
    return Friend(
      igUserId: igUserId,
      username: username,
      picture: picture,
      createdOn: createdOn,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        igUserId,
        username,
        picture,
        createdOn,
      ];
}
