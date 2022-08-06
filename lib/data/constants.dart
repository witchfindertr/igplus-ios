class InstagramUrls {
  static const baseUrl = 'https://i.instagram.com/api/v1';
  static String getAccountInfoById(String igUserId) => '$baseUrl/users/$igUserId/info';
  static String getAccountInfoByUsername(String username) => '$baseUrl/users/web_profile_info/?username=$username';
  //'https://i.instagram.com/api/v1/friendships/$friendIgUserId/following/?order=date_followed_latest$maxIdString'); //?max_id=$i&order=date_followed_latest
  static String getFollowings(String igUserId, String maxId) =>
      '$baseUrl/friendships/$igUserId/following/?order=date_followed_latest$maxId';
  //'https://i.instagram.com/api/v1/friendships/$friendIgUserId/followers/?order=date_followed_latest$maxIdString'); //?max_id=$i&order=date_followed_latest
  static String getFollowers(String igUserId, String maxId) =>
      '$baseUrl/friendships/$igUserId/followers/?order=date_followed_latest$maxId';
}

class FirebaseFunctionsUrls {
  static const baseUrl = 'us-central1-igplus-452cf.cloudfunctions.net';
  static String getLatestHeaders() => '$baseUrl/getLatestHeaders';
}
