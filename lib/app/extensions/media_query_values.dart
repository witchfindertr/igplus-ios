import 'package:flutter/material.dart';

extension MediaQueryValues on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  double get topPadding => MediaQuery.of(this).viewPadding.top;
  double get bottom => MediaQuery.of(this).viewInsets.bottom;

  // double get safeAreaHeight => MediaQuery.of(this).padding.top + MediaQuery.of(this).padding.bottom;
  // double get safeAreaWidth => MediaQuery.of(this).padding.left + MediaQuery.of(this).padding.right;
  // double get safeAreaHorizontal => MediaQuery.of(this).padding.left + MediaQuery.of(this).padding.right;
  // double get safeAreaVertical => MediaQuery.of(this).padding.top + MediaQuery.of(this).padding.bottom;
  // double get safeAreaHorizontalRatio => MediaQuery.of(this).padding.left + MediaQuery.of(this).padding.right / MediaQuery.of(this).size.width;
  // double get safeAreaVerticalRatio => MediaQuery.of(this).padding.top + MediaQuery.of(this).padding.bottom / MediaQuery.of(this).size.height;
  // double get safeAreaHorizontalRatioWithoutStatusBar => MediaQuery.of(this).padding.left + MediaQuery.of(this).padding.right / MediaQuery.of(this).size.width;
  // double get safeAreaVerticalRatioWithoutStatusBar => MediaQuery.of(this).padding.top + MediaQuery.of(this).padding.bottom / MediaQuery.of(this).size.height;
  // double get safeAreaHorizontalWithoutStatusBar => MediaQuery.of(this).padding.left + MediaQuery.of(this).padding.right;

}
