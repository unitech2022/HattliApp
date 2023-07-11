import 'package:flutter/material.dart';





// final mediaQuery = MediaQueryData.fromWindow(WidgetsBinding.instance.window);

// extension APIImage on BuildContext {
//   String getImageURL(String? image) {
//     if (image != null) {
//       return Endpoints.baseURLImages + image;
//     } else {
//       return "";
//     }
//   }
// }

extension Direction on BuildContext {
  bool isRTL() =>
      dependOnInheritedWidgetOfExactType<Directionality>()!.textDirection ==
              TextDirection.rtl
          ? true
          : false;

  TextDirection direction() =>
      dependOnInheritedWidgetOfExactType<Directionality>()!.textDirection;
}

extension Routes on BuildContext {}
