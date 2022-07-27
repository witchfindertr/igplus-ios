class InstagramUrls {
  static const baseUrl = 'https://api.instagram.com/v1';
  static String getAccountInfoByUsername(String igUserId) => '$baseUrl/users/$igUserId/info';
  static String getAccountInfoById(String username) => '$baseUrl/users/web_profile_info/?username=$username';
}

class FirebaseFunctionsUrls {
  static const baseUrl = 'us-central1-igplus-452cf.cloudfunctions.net';
  static String getLatestHeaders() => '$baseUrl/getLatestHeaders';
}
