import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igplus_ios/domain/entities/media_likers.dart';
import 'package:igplus_ios/presentation/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:igplus_ios/presentation/views/global/follow_unfollow_button.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as timeago;

/// List item representing a single Character with its photo and name.
class MediaLikersListItem extends StatefulWidget {
  const MediaLikersListItem({
    required this.mediaLikers,
    required this.index,
    required this.type,
    Key? key,
  }) : super(key: key);

  final MediaLikers mediaLikers;
  final int index;
  final String type;

  @override
  State<MediaLikersListItem> createState() => _MediaLikersListItemState();
}

class _MediaLikersListItemState extends State<MediaLikersListItem> {
  // initShowFollowButton
  bool showFollowButton = true;

  @override
  Widget build(BuildContext context) {
    if (widget.type == 'notFollowingBack') {
      showFollowButton = false;
    } else if (widget.type == 'mutualFollowings') {
      showFollowButton = false;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        tileColor: ColorsManager.cardBack,
        leading: GestureDetector(
          onTap: () => _openProfileLinkOnInsta(widget.mediaLikers.mediaLikerList.first.user.username),
          child: CircleAvatar(
            radius: 20,
            backgroundImage: CachedNetworkImageProvider(
              widget.mediaLikers.mediaLikerList.first.user.picture,
              errorListener: () => const Icon(
                FontAwesomeIcons.image,
                color: ColorsManager.appBack,
              ),
            ),
          ),
        ),
        title: GestureDetector(
          onTap: () => _openProfileLinkOnInsta(widget.mediaLikers.mediaLikerList.first.user.username),
          child: SizedBox(
            height: 40.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  child: Text(widget.mediaLikers.mediaLikerList.first.user.username,
                      overflow: TextOverflow.ellipsis, style: const TextStyle(color: ColorsManager.cardText)),
                ),
                const SizedBox(height: 4),
                Text('${widget.mediaLikers.likesCount} likes',
                    style: const TextStyle(color: ColorsManager.secondarytextColor, fontSize: 12)),
              ],
            ),
          ),
        ),
        trailing: FollowUnfollowButton(
          igUserId: widget.mediaLikers.mediaLikerList.first.user.igUserId,
          showFollow: showFollowButton,
        ),
      ),
    );
  }

  void _openProfileLinkOnInsta(String username) async {
    var url = 'instagram://user?username=$username';
    Uri uri = Uri.parse(url);
    try {
      var rs = await launchUrl(
        uri,
      );
      if (rs == false) {
        var url = 'https://instagram.com/$username';
        Uri uri = Uri.parse(url);
        await launchUrl(
          uri,
        );
      }
    } catch (e) {
      throw 'There was a problem to open the url: $url';
    }
  }
}
