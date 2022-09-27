class InstagramUrls {
  static const baseUrl = 'https://i.instagram.com/api/v1';
  static String getAccountInfoById(String igUserId) => '$baseUrl/users/$igUserId/info';
  static String getAccountInfoByUsername(String username) => '$baseUrl/users/web_profile_info/?username=$username';

  // get user following
  //'https://i.instagram.com/api/v1/friendships/$friendIgUserId/following/?order=date_followed_latest$maxIdString'); //?max_id=$i&order=date_followed_latest
  static String getFollowings(String igUserId, String maxId) =>
      '$baseUrl/friendships/$igUserId/following/?order=date_followed_latest$maxId';

  // get user followers
  //'https://i.instagram.com/api/v1/friendships/55299305811/followers/?order=date_followed_latest'); //?max_id=$i&order=date_followed_latest
  static String getFollowers(String igUserId, String maxId) =>
      '$baseUrl/friendships/$igUserId/followers/?order=date_followed_latest$maxId';

  //https://i.instagram.com/api/v1/feed/reels_tray/
  static String getUserStories() => '$baseUrl/feed/reels_tray/';

  // get stories
  //https://i.instagram.com/api/v1/feed/reels_media/?reel_ids=3139331705
  static String getStories({required userId}) => '$baseUrl/feed/reels_media/?reel_ids=$userId';

  // follow user
  // https://i.instagram.com/api/v1/web/friendships/3923655548/follow/
  static String followUser(String userId) => '$baseUrl/web/friendships/$userId/follow/';

  // unfollow user
  // https://i.instagram.com/api/v1/web/friendships/3923655548/unfollow/
  static String unfollowUser(String userId) => '$baseUrl/web/friendships/$userId/unfollow/';

  // User feed
  static String getUserFeed(String userId) => '$baseUrl/feed/user/$userId/';

  // get media info
  // https://i.instagram.com/api/v1/media/2345678901234567890/info/
  static String getMediaInfo(String mediaId) => '$baseUrl/media/$mediaId/info/';

  // get media comments
  // https://i.instagram.com/api/v1/media/2345678901234567890/comments/
  static String getMediaComments(String mediaId) => '$baseUrl/media/$mediaId/comments/';

  // get media likes
  // https://i.instagram.com/api/v1/media/2345678901234567890/likers/
  static String getMediaLikes(String mediaId) => '$baseUrl/media/$mediaId/likers/';
}

class FirebaseFunctionsUrls {
  static const baseUrl = 'us-central1-igplus-452cf.cloudfunctions.net';
  static String getLatestHeaders() => '$baseUrl/getLatestHeaders';
}

// https://www.instagram.com/graphql/query/?query_hash=c9100bf9110dd6361671f113dd02e7d6&variables={%22user_id%22:%2255072545782%22,%22include_chaining%22:false,%22include_reel%22:true,%22include_suggested_users%22:false,%22include_logged_out_extras%22:false,%22include_highlight_reels%22:false,%22include_related_profiles%22:false}
