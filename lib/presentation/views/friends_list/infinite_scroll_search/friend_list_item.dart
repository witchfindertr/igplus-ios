import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igplus_ios/domain/entities/friend.dart';
import 'package:igplus_ios/presentation/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:timeago/timeago.dart' as timeago;

/// List item representing a single Character with its photo and name.
class FriendListItem extends StatelessWidget {
  const FriendListItem({
    required this.friend,
    required this.index,
    Key? key,
  }) : super(key: key);

  final Friend friend;
  final int index;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        child: ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          tileColor: ColorsManager.cardBack,
          onTap: () => _openProfileLinkOnInsta(friend.username),
          leading: CircleAvatar(
            radius: 20,
            backgroundImage: CachedNetworkImageProvider(friend.picture),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(friend.username, style: const TextStyle(color: ColorsManager.cardText)),
              const SizedBox(height: 4),
              Text(timeago.format(friend.createdOn),
                  style: const TextStyle(color: ColorsManager.secondarytextColor, fontSize: 12)),
            ],
          ),
          trailing: const Icon(
            FontAwesomeIcons.instagram,
            color: ColorsManager.cardText,
          ),
        ),
      );
}

void _openProfileLinkOnInsta(String username) async {
  var url = 'instagram://user?username=$username';
  Uri uri = Uri.parse(url);
  try {
    await launchUrl(
      uri,
    );
  } catch (e) {
    throw 'There was a problem to open the url: $url';
  }
}
