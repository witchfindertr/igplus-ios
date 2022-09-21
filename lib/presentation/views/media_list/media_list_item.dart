import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:igplus_ios/domain/entities/media.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:provider/provider.dart';

/// List item representing a single Character with its photo and name.
class MediaListItem extends StatefulWidget {
  const MediaListItem({
    required this.media,
    required this.index,
    required this.type,
    Key? key,
  }) : super(key: key);

  final Media media;
  final int index;
  final String type;

  @override
  State<MediaListItem> createState() => _MediaListItemState();
}

class _MediaListItemState extends State<MediaListItem> {
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
      padding: const EdgeInsets.all(2.0),
      child: CachedNetworkImage(
        imageUrl: widget.media.url,
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
