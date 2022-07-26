import 'package:flutter/cupertino.dart';

import 'package:igplus_ios/presentation/resources/colors_manager.dart';

CupertinoThemeData appTheme() {
  return const CupertinoThemeData(
      brightness: Brightness.dark,
      primaryColor: ColorsManager.primaryColor,
      scaffoldBackgroundColor: ColorsManager.appBack,
      textTheme: CupertinoTextThemeData(
        primaryColor: ColorsManager.textColor,
        textStyle: TextStyle(color: ColorsManager.textColor),
      ));
}
