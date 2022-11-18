import 'package:igshark/domain/entities/ig_headers.dart';

class User {
  String uid;
  String igUserId;
  String username;
  String contactPhoneNumber;
  String phoneCountryCode;
  String publicPhoneNumber;
  String publicEmail;
  String picture;
  IgHeaders igHeaders;
  bool igAuth; // true if user is logged in to instagram;
  bool isActive;
  dynamic createdAt; // FieldValue.serverTimestamp() || TimeStamp
  String privateMessage;

  User({
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

  // transform a User object to a Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'igUserId': igUserId,
      'username': username,
      'contactPhoneNumber': contactPhoneNumber,
      'phoneCountryCode': phoneCountryCode,
      'publicPhoneNumber': publicPhoneNumber,
      'publicEmail': publicEmail,
      'picture': picture,
      'igHeaders': igHeaders.toMap(),
      'igAuth': igAuth,
      'isActive': isActive,
      'createdAt': createdAt,
      'privateMessage': privateMessage,
    };
  }
}
