import 'package:flutter/cupertino.dart';
import 'package:igplus_ios/presentation/router.dart';
import 'package:igplus_ios/presentation/resources/theme_manager.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);
  final router = routes();
  @override
  Widget build(BuildContext context) {
    return CupertinoApp.router(
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      theme: appTheme(),
    );
  }
}
