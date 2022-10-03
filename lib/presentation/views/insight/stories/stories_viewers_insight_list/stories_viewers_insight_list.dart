import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:igplus_ios/domain/entities/stories_viewers.dart';
import 'package:igplus_ios/presentation/blocs/insight/stories_insight/story_viewers/cubit/story_viewers_cubit.dart';
import 'package:igplus_ios/presentation/resources/colors_manager.dart';
import 'package:igplus_ios/presentation/resources/theme_manager.dart';
import 'package:igplus_ios/presentation/views/friends_list/friend_search.dart';
import 'package:igplus_ios/presentation/views/insight/stories/stories_viewers_insight_list/stories_viewers_insight_list_item.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class StoriesViewersInsightList extends StatefulWidget {
  const StoriesViewersInsightList({Key? key, required this.type}) : super(key: key);

  final String type;

  @override
  State<StoriesViewersInsightList> createState() => _StoriesViewersInsightState();
}

class _StoriesViewersInsightState extends State<StoriesViewersInsightList> {
  static const _pageSize = 15;
  static const int _initialPageKey = 0;
  final PagingController<int, StoriesViewer> _pagingController = PagingController(firstPageKey: _initialPageKey);
  String? _searchTerm;
  bool _showSearchForm = false;
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
      final List<StoriesViewer>? topStoriesViewers;
      if (widget.type == "viewersNotFollowingYou") {
        topStoriesViewers = await context.read<StoryViewersCubit>().getViewersNotFollowingYouBack();
      } else if (widget.type == "topStoriesViewers") {
        topStoriesViewers = await context.read<StoryViewersCubit>().getTopViewersList();
      } else {
        topStoriesViewers = null;
      }

      if (topStoriesViewers == null || topStoriesViewers.isEmpty) {
        _pagingController.appendLastPage([]);
      } else {
        final isLastPage = topStoriesViewers.length < _pageSize || topStoriesViewers.length > _pageSize;
        if (isLastPage) {
          _pagingController.appendLastPage(topStoriesViewers);
        } else {
          final nextPageKey = pageKey + topStoriesViewers.length;
          _pagingController.appendPage(topStoriesViewers, nextPageKey);
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
      case "topStoriesViewers":
        pageTitle = "Top Viewers";
        break;
      case "viewersNotFollowingYou":
        pageTitle = "Viewers Not Following You";
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
        trailing: GestureDetector(
          onTap: () {
            if (_showSearchForm == false) {
              _scrollToTop();
              try {
                _searchFocusNode.requestFocus();
              } catch (e) {
                // print(e);
              }
            }
            setState(() {
              _showSearchForm = !_showSearchForm;
            });
          },
          child: const Icon(
            Icons.search,
            color: ColorsManager.textColor,
            size: 26.0,
          ),
        ),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appMaterialTheme(),
        home: Scaffold(
          backgroundColor: ColorsManager.appBack,
          body: BlocBuilder<StoryViewersCubit, StoryViewersState>(
            builder: (context, state) {
              return (_showSearchForm)
                  ? CustomScrollView(
                      controller: _scrollController,
                      slivers: <Widget>[
                        FriendSearch(
                          onChanged: (searchTerm) => _updateSearchTerm(searchTerm),
                          searchFocusNode: _searchFocusNode,
                        ),
                        PagedSliverList<int, StoriesViewer>(
                          pagingController: _pagingController,
                          builderDelegate: PagedChildBuilderDelegate<StoriesViewer>(
                            animateTransitions: true,
                            itemBuilder: (context, item, index) => StoriesViewersInsightListItem(
                              storiesTopViewer: item,
                              index: index,
                            ),
                          ),
                        )
                      ],
                    )
                  : CustomScrollView(
                      controller: _scrollController,
                      slivers: <Widget>[
                        PagedSliverList<int, StoriesViewer>(
                          pagingController: _pagingController,
                          builderDelegate: PagedChildBuilderDelegate<StoriesViewer>(
                            animateTransitions: true,
                            itemBuilder: (context, item, index) => StoriesViewersInsightListItem(
                              storiesTopViewer: item,
                              index: index,
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

  void _updateSearchTerm(String searchTerm) {
    _searchTerm = searchTerm;
    _pagingController.refresh();
  }

  void _scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.linear,
      );
    }
  }
}
