import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:igplus_ios/presentation/resources/colors_manager.dart';

CupertinoThemeData appTheme() {
  return const CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: ColorsManager.primaryColor,
    scaffoldBackgroundColor: ColorsManager.appBack,
    textTheme: CupertinoTextThemeData(
        primaryColor: ColorsManager.textColor,
        textStyle: TextStyle(
          color: ColorsManager.textColor,
          fontSize: 14,
          fontStyle: FontStyle.italic,
        )),
  );
}

ThemeData appMaterialTheme() {
  return ThemeData.dark().copyWith(
    brightness: Brightness.dark,
    primaryColor: ColorsManager.primaryColor,
    scaffoldBackgroundColor: ColorsManager.appBack,
    primaryColorDark: ColorsManager.primaryColor,
    primaryColorLight: ColorsManager.primaryColor,
    colorScheme: ColorScheme.fromSwatch(
      primaryColorDark: ColorsManager.primaryColor,
      primarySwatch: generateMaterialColor(color: ColorsManager.primaryColor),
    ),
    iconTheme: const IconThemeData(color: ColorsManager.primaryColor),
    textTheme: const TextTheme(
      bodyText1: TextStyle(
        color: ColorsManager.textColor,
        fontSize: 14,
        fontStyle: FontStyle.italic,
      ),
    ),
  );
}
