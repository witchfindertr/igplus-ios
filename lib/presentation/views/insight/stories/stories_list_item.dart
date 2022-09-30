import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:igplus_ios/domain/entities/story.dart';
import 'package:igplus_ios/presentation/resources/colors_manager.dart';
import 'package:igplus_ios/presentation/views/global/images_stack.dart';
import 'package:igplus_ios/presentation/views/global/loading_indicator.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_image_stack/flutter_image_stack.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: SizedBox(
        height: 220.0,
        child: Card(
          color: ColorsManager.cardBack,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CachedNetworkImage(
                  imageUrl: widget.story.mediaThumbnailUrl,
                  placeholder: (context, url) => const Center(
                    child: LoadingIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    FontAwesomeIcons.image,
                    color: ColorsManager.appBack,
                  ),
                  imageBuilder: (context, imageProvider) => Container(
                    width: 120.0,
                    height: 220.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () =>
                      GoRouter.of(context).go('/home/storiesList/${widget.type}/storyViewers/${widget.story.mediaId}'),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  NumberFormat.compact().format(widget.story.viewersCount),
                                  style: const TextStyle(
                                    color: ColorsManager.cardText,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const Text(
                                  'Viewers',
                                  style: TextStyle(
                                    color: ColorsManager.secondarytextColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            FontAwesomeIcons.angleRight,
                            color: ColorsManager.secondarytextColor,
                            size: 32,
                          ),
                        ],
                      ),
                      imageStack(
                          imageList: widget.story.viewers.map((e) => e.picture).toList(),
                          totalCount: widget.story.viewersCount ?? 0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
