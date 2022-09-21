import 'package:equatable/equatable.dart';

import '../../domain/entities/account_info.dart';

class AccountInfoModel extends Equatable {
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

  const AccountInfoModel({
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

  factory AccountInfoModel.fromJsonById(Map<String, dynamic> json) {
    final String igUserId = json['user']['pk'].toString();
    final String username = json['user']['username'];
    final bool isPrivate = json['user']['is_private'];
    final String picture = Uri.encodeFull(json['user']['profile_pic_url']);
    final int followers = json['user']['follower_count'];
    final int followings = json['user']['following_count'];
    final String? contactPhoneNumber = json['user']['contact_phone_number'];
    final String? phoneCountryCode = json['user']['public_phone_country_code'];
    final String? publicPhoneNumber = json['user']['public_phone_number'];
    final String? publicEmail = json['user']['public_email'];

    return AccountInfoModel(
      igUserId: igUserId,
      username: username,
      isPrivate: isPrivate,
      picture: picture,
      followers: followers,
      followings: followings,
      contactPhoneNumber: contactPhoneNumber ?? "",
      publicPhoneNumber: publicPhoneNumber ?? "",
      phoneCountryCode: phoneCountryCode ?? "",
      publicEmail: publicEmail ?? "",
    );
  }

  factory AccountInfoModel.fromJsonByUsername(Map<String, dynamic> json) {
    final String igUserId = json['data']['user']['id'].toString();
    final String username = json['data']['user']['username'];
    final bool isPrivate = json['data']['user']['is_private'];
    final String picture = Uri.encodeFull(json['data']['user']['profile_pic_url']);
    final int followers = json['data']['user']['edge_followed_by']['count'];
    final int followings = json['data']['user']['edge_follow']['count'];
    final String? contactPhoneNumber = json['data']['user']['business_phone_number'];
    const String? phoneCountryCode = null;
    const String? publicPhoneNumber = null;
    final String? publicEmail = json['data']['user']['business_email'];

    return AccountInfoModel(
      igUserId: igUserId,
      username: username,
      isPrivate: isPrivate,
      picture: picture,
      followers: followers,
      followings: followings,
      contactPhoneNumber: contactPhoneNumber ?? "",
      publicPhoneNumber: publicPhoneNumber ?? "",
      phoneCountryCode: phoneCountryCode ?? "",
      publicEmail: publicEmail ?? "",
    );
  }

  AccountInfo toEntity() {
    return AccountInfo(
      igUserId: igUserId,
      username: username,
      isPrivate: isPrivate,
      picture: picture,
      followers: followers,
      followings: followings,
      // contactPhoneNumber: contactPhoneNumber,
      // phoneCountryCode: phoneCountryCode,
      // publicPhoneNumber: publicPhoneNumber,
      // publicEmail: publicEmail,
    );
  }

  // return a Map object from LocaStorage (shared preference)
  Map<String, dynamic> toJson() {
    return {
      'igUserId': igUserId,
      'username': username,
      'isPrivate': isPrivate,
      'picture': picture,
      'followers': followers,
      'followings': followings
    };
  }

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

// // return a Map object from LocaStorage (shared preference)
//   Map<String, dynamic> toJson(accountInfoModel userData) {
//     return {
//       'igUserId': userData.igUserId,
//       'username': userData.username,
//       'isPrivate': userData.isPrivate,
//       'picture': userData.picture,
//       'followers': userData.followers,
//       'following': userData.following
//     };
//   }

  // return User from LocalStorage (shared preference)

  // factory AccountInfo.fromLocalMap(Map<String, dynamic> data) {
  //   try {
  //     AccountInfo userData = AccountInfo();
  //     userData.igUserId = data['igUserId'] as String;
  //     userData.username = data['username'] as String;
  //     userData.isPrivate = data['isPrivate'] as bool;
  //     userData.picture = data['picture'] as String;
  //     userData.followers = data['followers'] as int;
  //     userData.following = data['following'] as int;

  //     return userData;
  //   } catch (e) {
  //     print(e);
  //     throw Exception("Error while parsing user from User LocalStorage");
  //   }
  // }
}
