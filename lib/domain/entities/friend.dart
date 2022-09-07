import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'friend.g.dart';

@HiveType(typeId: 0)
class Friend extends Equatable {
  static const String followersBoxKey = "followersBoxKey";
  static const String followingsBoxKey = "followingsBoxKey";

  @HiveField(0)
  final int igUserId;
  @HiveField(1)
  final String username;
  @HiveField(2)
  final String picture;

  const Friend({
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
