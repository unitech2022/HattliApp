import 'package:flutter/material.dart';

import '../layout/app_sizes.dart';
import '../layout/palette.dart';



class CustomCircularProgress extends StatelessWidget {
  const CustomCircularProgress({
    super.key,
    this.size = const Size(AppSize.s28, AppSize.s28),
    this.strokeWidth = AppSize.s3,
    this.color = Palette.mainColor,
    this.fullScreen = false,
  });

  final Size size;
  final double strokeWidth;
  final Color color;
  final bool fullScreen;

  @override
  Widget build(BuildContext context) {
    if (fullScreen) {
      return Scaffold(
        body: Center(
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Center(
              child: CircularProgressIndicator.adaptive(
                strokeWidth: strokeWidth,
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
          ),
        ),
      );
    }
    return Center(
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Center(
          child: CircularProgressIndicator.adaptive(
            strokeWidth: strokeWidth,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ),
    );
  }
}
