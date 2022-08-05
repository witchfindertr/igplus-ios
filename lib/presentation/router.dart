import 'package:go_router/go_router.dart';
import 'package:igplus_ios/presentation/views/home/home_page.dart';
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
      name: 'tabs',
      path: '/tabs',
      builder: (context, state) {
        return const TabPage();
      },
    ),
  ]);
}
