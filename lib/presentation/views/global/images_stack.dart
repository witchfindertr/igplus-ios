import 'package:flutter/material.dart';
import 'package:flutter_image_stack/flutter_image_stack.dart';
import 'package:igplus_ios/presentation/resources/colors_manager.dart';

Widget imageStack({required List<String> imageList, required int totalCount, double itemRadius = 30.0}) {
  if (imageList.isEmpty) {
    return const SizedBox.shrink();
  }
  return FlutterImageStack(
    backgroundColor: ColorsManager.appBack,
    itemBorderColor: ColorsManager.cardBack,
    imageList: imageList,
    showTotalCount: true,
    totalCount: totalCount,
    itemRadius: itemRadius, // Radius of each images
    itemCount: 4, // Maximum number of images to be shown in stack
    itemBorderWidth: 1, // Border width around the images
    extraCountTextStyle: const TextStyle(fontSize: 8.0),
  );
}
