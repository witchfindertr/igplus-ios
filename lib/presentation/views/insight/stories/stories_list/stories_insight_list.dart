import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:igplus_ios/domain/entities/stories_user.dart';
import 'package:igplus_ios/domain/entities/story.dart';
import 'package:igplus_ios/presentation/blocs/insight/stories_insight/cubit/stories_insight_cubit.dart';
import 'package:igplus_ios/presentation/resources/colors_manager.dart';
import 'package:igplus_ios/presentation/resources/theme_manager.dart';
import 'package:igplus_ios/presentation/views/insight/stories/stories_list/stories_insight_list_item.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class StoriesInsightList extends StatefulWidget {
  const StoriesInsightList({Key? key, required this.type}) : super(key: key);

  final String type;

  @override
  State<StoriesInsightList> createState() => _StoriesInsightListState();
}

class _StoriesInsightListState extends State<StoriesInsightList> {
  static const _pageSize = 30;
  static const int _initialPageKey = 0;
  PagingController<int, Story> _pagingController = PagingController(firstPageKey: _initialPageKey);
  String? _searchTerm;
  late ScrollController _scrollController;
  late FocusNode _searchFocusNode;

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });

    _pagingController.addStatusListener((status) {
      if (status == PagingStatus.subsequentPageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Something went wrong while fetching a new page.',
            ),
            action: SnackBarAction(
              label: 'Retry',
              onPressed: () => _pagingController.retryLastFailedRequest(),
            ),
          ),
        );
      }
    });

    _scrollController = ScrollController();
    _searchFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose(); // dispose the controller
    _pagingController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(pageKey) async {
    try {
      final List<Story>? storiesList = await context.read<StoriesInsightCubit>().getStoriesListFromLocal(
          boxKey: StoriesUser.boxKey,
          pageKey: pageKey,
          pageSize: _pageSize,
          searchTerm: _searchTerm,
          type: widget.type);

      if (storiesList == null || storiesList.isEmpty) {
        _pagingController.appendLastPage([]);
      } else {
        final isLastPage = storiesList.length < _pageSize;
        if (isLastPage) {
          _pagingController.appendLastPage(storiesList);
        } else {
          final nextPageKey = pageKey + storiesList.length;
          _pagingController.appendPage(storiesList, nextPageKey);
        }
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final String pageTitle;
    switch (widget.type) {
      case "mostPopularStories":
        pageTitle = "Most Popular Stories";
        break;
      case "mostLikedStories":
        pageTitle = "Most Liked Stories";
        break;
      case "mostCommentedStories":
        pageTitle = "Most Commented Stories";
        break;
      case "mostViewedStories":
        pageTitle = "Most Viewed Stories";
        break;
      default:
        pageTitle = "";
        break;
    }
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: ColorsManager.appBack,
        leading: GestureDetector(
            onTap: () => GoRouter.of(context).pop(),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 26.0,
            )),
        middle: Text(pageTitle, style: const TextStyle(fontSize: 16, color: Colors.white)),
        trailing: BlocBuilder<StoriesInsightCubit, StoriesInsightState>(
          builder: (context, state) {
            return SizedBox(
                width: 80.0,
                child: (state is StoriesInsightSuccess)
                    ? AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        child: GestureDetector(
                          onTap: () => context.read<StoriesInsightCubit>().init(),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text("Refresh", style: TextStyle(fontSize: 12, color: ColorsManager.secondarytextColor)),
                              SizedBox(width: 6.0),
                              Icon(
                                FontAwesomeIcons.arrowsRotate,
                                size: 20.0,
                                color: ColorsManager.textColor,
                              ),
                            ],
                          ),
                        ),
                      )
                    :
                    // mini loading
                    const AnimatedSwitcher(
                        duration: Duration(milliseconds: 500),
                        child: SizedBox(
                          width: 80.0,
                          height: 4.0,
                          child: LinearProgressIndicator(
                            backgroundColor: ColorsManager.appBack,
                            valueColor: AlwaysStoppedAnimation<Color>(ColorsManager.cardBack),
                          ),
                        ),
                      ));
          },
        ),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appMaterialTheme(),
        home: Scaffold(
          backgroundColor: ColorsManager.appBack,
          body: BlocBuilder<StoriesInsightCubit, StoriesInsightState>(
            builder: (context, state) {
              return CustomScrollView(
                slivers: <Widget>[
                  PagedSliverList<int, Story>(
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate<Story>(
                      itemBuilder: (context, item, index) => StoriesInsightListItem(
                        story: item,
                        index: index,
                        type: widget.type,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
