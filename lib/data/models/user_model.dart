import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:igplus_ios/data/models/ig_headers_model.dart';
import 'package:igplus_ios/domain/entities/ig_headers.dart';

import '../../domain/entities/user.dart';

class UserModel {
  final String uid;
  final String igUserId;
  final String username;
  final String contactPhoneNumber;
  final String phoneCountryCode;
  final String publicPhoneNumber;
  final String publicEmail;
  final String picture;
  final Map<String, dynamic> igHeaders;
  final bool igAuth; // true if user is logged in to instagram;
  final bool isActive;
  final dynamic createdAt;
  final String privateMessage;

  UserModel({
    required this.uid,
    required this.igUserId,
    required this.username,
    required this.contactPhoneNumber,
    required this.phoneCountryCode,
    required this.publicPhoneNumber,
    required this.publicEmail,
    required this.picture,
    required this.igHeaders,
    required this.igAuth,
    required this.isActive,
    required this.createdAt,
    required this.privateMessage,
  });

  // return a UserModel object from a Firestore document
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      igUserId: data['igUserId'],
      username: data['username'],
      contactPhoneNumber: data['contactPhoneNumber'],
      phoneCountryCode: data['phoneCountryCode'],
      publicPhoneNumber: data['publicPhoneNumber'],
      publicEmail: data['publicEmail'],
      picture: data['picture'],
      igHeaders: data['igHeaders'],
      igAuth: data['igAuth'],
      isActive: data['isActive'],
      createdAt: data['createdAt'],
      privateMessage: data['privateMessage'],
    );
  }

  // to entity
  User toEntity() {
    return User(
      uid: uid,
      igUserId: igUserId,
      username: username,
      contactPhoneNumber: contactPhoneNumber,
      phoneCountryCode: phoneCountryCode,
      publicPhoneNumber: publicPhoneNumber,
      publicEmail: publicEmail,
      picture: picture,
      igHeaders: IgHeadersModel.fromJson(igHeaders).toEntity(),
      igAuth: igAuth,
      isActive: isActive,
      createdAt: createdAt,
      privateMessage: privateMessage,
    );
  }
}
