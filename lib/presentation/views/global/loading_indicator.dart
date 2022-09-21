import 'package:flutter/material.dart';
import 'package:igplus_ios/presentation/resources/colors_manager.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        SizedBox(
          width: 15,
          height: 15,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(ColorsManager.appBack),
            backgroundColor: ColorsManager.cardBack,
            strokeWidth: 2,
          ),
        )
      ],
    );
  }
}
