class InstagramUrls {
  static const baseUrl = 'https://i.instagram.com/api/v1';
  static String getAccountInfoById(String igUserId) => '$baseUrl/users/$igUserId/info';
  static String getAccountInfoByUsername(String username) => '$baseUrl/users/web_profile_info/?username=$username';
}

class FirebaseFunctionsUrls {
  static const baseUrl = 'us-central1-igplus-452cf.cloudfunctions.net';
  static String getLatestHeaders() => '$baseUrl/getLatestHeaders';
}
