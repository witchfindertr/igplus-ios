import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:igplus_ios/domain/entities/story.dart';
import 'package:igplus_ios/presentation/resources/colors_manager.dart';
import 'package:igplus_ios/presentation/views/global/loading_indicator.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:provider/provider.dart';

/// List item representing a single Character with its photo and name.
class StoriesListItem extends StatefulWidget {
  const StoriesListItem({
    required this.story,
    required this.index,
    required this.type,
    Key? key,
  }) : super(key: key);

  final Story story;
  final int index;
  final String type;

  @override
  State<StoriesListItem> createState() => _StoriesListItemState();
}

class _StoriesListItemState extends State<StoriesListItem> {
  // initShowFollowButton
  bool showFollowButton = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: widget.story.mediaUrl,
            placeholder: (context, url) => const Center(
              child: LoadingIndicator(),
            ),
            errorWidget: (context, url, error) => const Icon(
              FontAwesomeIcons.image,
              color: ColorsManager.appBack,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: ColorsManager.appBack.withOpacity(0.5),
            ),
            padding: const EdgeInsets.all(4.0),
            margin: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  (widget.type == "mostLikedStories")
                      ? FontAwesomeIcons.heart
                      : (widget.type == "mostCommentedStories")
                          ? FontAwesomeIcons.comment
                          : (widget.type == "mostViewedStories")
                              ? FontAwesomeIcons.eye
                              : FontAwesomeIcons.groupArrowsRotate,
                  color: Colors.white,
                  size: 12,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  NumberFormat.compact().format(widget.story.viewersCount),
                  style: const TextStyle(color: Colors.white, fontSize: 10),
                ),
              ],
            ),
          ),
        ],
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
