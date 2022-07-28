import 'package:equatable/equatable.dart';

class AccountInfo extends Equatable {
  final String igUserId; //pk
  final String username; //username
  final bool isPrivate; //is_private
  final String picture; // profile_pic_url
  final int followers; //follower_count
  final int followings; //following_count
  final String? contactPhoneNumber; //contact_phone_number
  final String? phoneCountryCode; //public_phone_country_code
  final String? publicPhoneNumber; //public_phone_number
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
