import 'package:flutter/cupertino.dart';

import 'package:igplus_ios/presentation/resources/colors_manager.dart';

CupertinoThemeData appTheme() {
  return CupertinoThemeData(
    primaryColor: ColorManager.primaryColor,
    brightness: ColorManager.brightness,
  );
}
