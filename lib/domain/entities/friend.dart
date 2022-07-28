import 'package:equatable/equatable.dart';

class Friend extends Equatable {
  int igUserId;
  String username;
  bool isPrivate;
  String picture;
  Friend({
    required this.igUserId,
    required this.username,
    required this.isPrivate,
    required this.picture,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        igUserId,
        username,
        isPrivate,
        picture,
      ];
}
