import 'package:equatable/equatable.dart';

class AccountInfo extends Equatable {
  String igUserId; //pk
  String username; //username
  bool isPrivate; //is_private
  String picture; // profile_pic_url
  int followers; //follower_count
  int following; //following_count
  String? contactPhoneNumber; //contact_phone_number
  String? phoneCountryCode; //public_phone_country_code
  String? publicPhoneNumber; //public_phone_number
  String? publicEmail; //public_email

  AccountInfo({
    required this.igUserId,
    required this.username,
    required this.isPrivate,
    required this.picture,
    required this.followers,
    required this.following,
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
        following,
        contactPhoneNumber,
        phoneCountryCode,
        publicPhoneNumber,
        publicEmail,
      ];
}
