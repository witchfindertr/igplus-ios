import 'package:igshark/domain/entities/ig_headers.dart';

class IgHeadersModel {
  String userAgent; // 'User-Agent'
  final String cookie; //Cookie
  final String accept; //Accept

  final String acceptEncoding; // Accept-Encoding
  final String acceptLanguage; //Accept-Language
  final String upgradeInsecureRequests; // Upgrade-Insecure-Requests
  final String XIGAppID; //X-IG-App-ID
  final String XCSRFToken; // X-CSRFToken

  IgHeadersModel({
    required this.XCSRFToken,
    required this.XIGAppID,
    required this.accept,
    required this.acceptEncoding,
    required this.acceptLanguage,
    required this.cookie,
    required this.upgradeInsecureRequests,
    required this.userAgent,
  });

  factory IgHeadersModel.fromJson(Map<String, dynamic> json) => IgHeadersModel(
        userAgent: json['User-Agent'],
        cookie: json['Cookie'],
        accept: json['Accept'],
        acceptEncoding: json['Accept-Encoding'],
        acceptLanguage: json['Accept-Language'],
        upgradeInsecureRequests: json['Upgrade-Insecure-Requests'],
        XIGAppID: json['X-IG-App-ID'],
        XCSRFToken: json['X-CSRFToken'],
      );

  IgHeaders toEntity() {
    return IgHeaders(
      userAgent: userAgent,
      cookie: cookie,
      accept: accept,
      acceptEncoding: acceptEncoding,
      acceptLanguage: acceptLanguage,
      upgradeInsecureRequests: upgradeInsecureRequests,
      XIGAppID: XIGAppID,
      XCSRFToken: XCSRFToken,
    );
  }

  @override
  List<Object?> get props => [
        userAgent,
        cookie,
        accept,
        acceptEncoding,
        acceptLanguage,
        upgradeInsecureRequests,
        XIGAppID,
        XCSRFToken,
      ];
}
