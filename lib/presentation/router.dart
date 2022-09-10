import 'package:go_router/go_router.dart';
import 'package:igplus_ios/presentation/views/friends_list/friends_list.dart';
import 'package:igplus_ios/presentation/views/login/instagram_login_page.dart';
import 'package:igplus_ios/presentation/views/login/login_page.dart';
import 'package:igplus_ios/presentation/views/tab_page.dart';

GoRouter routes() {
  return GoRouter(initialLocation: '/login', debugLogDiagnostics: true, routes: [
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
              return const InstagramLoginPage();
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
        ]),
  ]);
}
