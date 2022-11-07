import 'package:igplus_ios/domain/entities/friend.dart';

class LikesAndComments {
  final int total;
  final Friend user;

  LikesAndComments({
    required this.total,
    required this.user,
  });
}
