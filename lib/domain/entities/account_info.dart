import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'account_info.g.dart';

@HiveType(typeId: 4)
class AccountInfo extends Equatable {
  static const String boxKey = "accountInfoBoxKey";

  @HiveField(0)
  final String igUserId; //pk
  @HiveField(1)
  final String username; //username
  @HiveField(2)
  final bool isPrivate; //is_private
  @HiveField(3)
  final String picture; // profile_pic_url
  @HiveField(4)
  final int followers; //follower_count
  @HiveField(5)
  final int followings; //following_count
  @HiveField(6)
  final String? contactPhoneNumber; //contact_phone_number
  @HiveField(7)
  final String? phoneCountryCode; //public_phone_country_code
  @HiveField(8)
  final String? publicPhoneNumber; //public_phone_number
  @HiveField(9)
  final String? publicEmail; //public_email

  const AccountInfo({
    required this.igUserId,
    required this.username,
    required this.isPrivate,
    required this.picture,
    required this.followers,
    required this.followings,
    this.contactPhoneNumber,
    this.phoneCountryCode,
    this.publicPhoneNumber,
    this.publicEmail,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        igUserId,
        username,
        isPrivate,
        picture,
        followers,
        followings,
        contactPhoneNumber,
        phoneCountryCode,
        publicPhoneNumber,
        publicEmail,
      ];
}
