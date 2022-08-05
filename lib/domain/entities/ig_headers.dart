import 'package:equatable/equatable.dart';

class IgHeaders extends Equatable {
  final String userAgent; // 'User-Agent'
  final String cookie; //Cookie
  final String accept; //Accept

  final String acceptEncoding; // Accept-Encoding
  final String acceptLanguage; //Accept-Language
  final String upgradeInsecureRequests; // Upgrade-Insecure-Requests
  final String XIGAppID; //X-IG-App-ID
  final String XCSRFToken; // X-CSRFToken

  IgHeaders({
    required this.XCSRFToken,
    required this.XIGAppID,
    required this.accept,
    required this.acceptEncoding,
    required this.acceptLanguage,
    required this.cookie,
    required this.upgradeInsecureRequests,
    required this.userAgent,
  });

  // to map
  Map<String, String> toMap() {
    return {
      'User-Agent': userAgent,
      'Cookie': cookie,
      'Accept': accept,
      'Accept-Encoding': acceptEncoding,
      'Accept-Language': acceptLanguage,
      'Upgrade-Insecure-Requests': upgradeInsecureRequests,
      'X-IG-App-ID': XIGAppID,
      'X-CSRFToken': XCSRFToken,
    };
  }

  @override
  // TODO: implement props
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
