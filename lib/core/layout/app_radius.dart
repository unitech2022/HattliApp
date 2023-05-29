import 'package:flutter/material.dart';

import 'app_sizes.dart';

class AppRadius {
  static const BorderRadius r10 = BorderRadius.all(
    Radius.circular(AppSize.s10),
  );
  static const BorderRadius r20 = BorderRadius.all(
    Radius.circular(AppSize.s20),
  );
  static const BorderRadius r50 = BorderRadius.all(
    Radius.circular(AppSize.s50),
  );
  static const BorderRadius bottomRadius = BorderRadius.all(
    Radius.circular(AppSize.s10),
  );
  static const BorderRadius textFieldRadius = BorderRadius.all(
    Radius.circular(AppSize.s10),
  );
}

extension MyRadius on BuildContext {
  BorderRadius rounded(double size) => BorderRadius.all(
        Radius.circular(size),
      );

  Radius roundedSide(double size) => Radius.circular(size);
}
