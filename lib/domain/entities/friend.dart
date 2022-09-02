import 'package:equatable/equatable.dart';

class Friend extends Equatable {
  int igUserId;
  String username;

  String picture;
  Friend({
    required this.igUserId,
    required this.username,
    required this.picture,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        igUserId,
        username,
        picture,
      ];
}
