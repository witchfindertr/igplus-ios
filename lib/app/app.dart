import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:igplus_ios/presentation/router.dart';
import 'package:igplus_ios/presentation/resources/theme_manager.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);
  final router = routes();
  @override
  Widget build(BuildContext context) {
    return CupertinoApp.router(
      localizationsDelegates: const [
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
    );
  }
}
