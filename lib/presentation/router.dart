import 'package:go_router/go_router.dart';
import 'package:igplus_ios/app/bloc/app_bloc.dart';
import 'package:igplus_ios/domain/entities/stories_user.dart';
import 'package:igplus_ios/presentation/views/engagement/media_commenters/media_commenters_list.dart';
import 'package:igplus_ios/presentation/views/engagement/media_likers/media_likers_list.dart';
import 'package:igplus_ios/presentation/views/friends_list/friends_list.dart';
import 'package:igplus_ios/presentation/views/home/stories/stories_view.dart';
import 'package:igplus_ios/presentation/views/insight/stories/stories_list/stories_insight_list.dart';
import 'package:igplus_ios/presentation/views/insight/stories/story_viewers_list/story_viewers_list.dart';
import 'package:igplus_ios/presentation/views/insight/stories/stories_viewers_insight_list/stories_viewers_insight_list.dart';
import 'package:igplus_ios/presentation/views/login/instagram_login_page.dart';
import 'package:igplus_ios/presentation/views/login/login_page.dart';
import 'package:igplus_ios/presentation/views/insight/media/media_list/media_list.dart';
import 'package:igplus_ios/presentation/views/tab_page.dart';

GoRouter routes(AppBloc appBloc) {
  final Stream stream = appBloc.stream;
  return GoRouter(
    initialLocation: '/login',
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
          name: 'login',
          path: '/login',
          builder: (context, state) {
            return const LoginPage();
          },
          routes: [
            GoRoute(
              name: 'instagram_login',
              path: 'instagram_login',
              builder: (context, state) {
                bool updateInstagramAccount = false;
                if (state.queryParams['updateInstagramAccount'] != null) {
                  updateInstagramAccount = state.queryParams['updateInstagramAccount'] == 'true' ? true : false;
                }
                return InstagramLoginPage(
                  updateInstagramAccount: updateInstagramAccount,
                );
              },
            ),
          ]),
      GoRoute(
          name: 'home',
          path: '/home',
          builder: (context, state) {
            return const TabPage();
          },
          routes: [
            GoRoute(
              path: 'friendsList/:type',
              builder: (context, state) => FriendsList(type: state.params['type'] ?? ""),
            ),
            GoRoute(
              path: 'storiesView',
              builder: (context, state) => StoriesView(storyOwner: state.extra! as StoryOwner),
            ),
            GoRoute(
              path: 'mediaList/:type',
              builder: (context, state) => MediaList(type: state.params['type'] ?? ""),
            ),
            GoRoute(
              path: 'storiesViewersInsight/:type',
              builder: (context, state) => StoriesViewersInsightList(type: state.params['type'] ?? ""),
            ),
            GoRoute(
                path: 'storiesList/:type',
                builder: (context, state) => StoriesInsightList(type: state.params['type'] ?? ""),
                routes: [
                  GoRoute(
                    path: 'storyViewers/:mediaId',
                    builder: (context, state) => StoryViewersList(mediaId: state.params['mediaId'] ?? "", type: ""),
                  ),
                ]),
            GoRoute(
                path: 'engagement/:type',
                builder: (context, state) {
                  if (state.params['type'] == 'mostLikes') {
                    return MediaLikersList(type: state.params['type'] ?? "");
                  } else if (state.params['type'] == 'mostComments') {
                    return MediaCommentersList(type: state.params['type'] ?? "");
                  }
                  return MediaLikersList(type: state.params['type'] ?? "");
                }),
          ]),
    ],
    redirect: (state) {
      final authState = appBloc.state;
      final location = Uri.parse(state.location).path;
      final isLoginPage = location == '/login';
      final isInstagramLoginPage = location == '/login/instagram_login';

      // if user is not logged in and is not on login page, redirect to login page
      if (authState.status == AppStatus.unauthenticated && !isLoginPage && !isInstagramLoginPage) {
        return '/login';
      }
      // if user is logged in and is on login page, redirect to home page
      // if (authState.status == AppStatus.authenticated && isLoginPage) {
      //   return '/home';
      // }

      return null;
    },
    refreshListenable: GoRouterRefreshStream(stream),
  );
}
