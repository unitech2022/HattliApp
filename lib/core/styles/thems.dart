import 'package:flutter/material.dart';

import '../layout/app_fonts.dart';
import '../layout/app_sizes.dart';
import '../layout/palette.dart';

ThemeData lightTheme(BuildContext context) {
  // final currentLang = prefs.getString(AppConstants.langugageCode);
  return ThemeData(
    // useMaterial3: true,
    scaffoldBackgroundColor:const Color(0xffFEFEFE),
    // primaryColor: Palette.restaurantColor,
    splashFactory: InkRipple.splashFactory,
    fontFamily: AppFonts.taM,
    // currentLang == AppConstants.ar ? AppFonts.stc : AppFonts.montserrat,
    colorScheme: Theme.of(context).colorScheme.copyWith(
          primary: Palette.mainColor,
        ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.all(
        Palette.mainColor,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Palette.white,
      elevation: AppSize.s5,
      shadowColor: Color(0x9AF1F1F1),
      iconTheme: IconThemeData(
        color: Palette.kDarkGrey,
      ),
      titleTextStyle: TextStyle(
        color: Palette.kDarkGrey,
        fontFamily: AppFonts.taM,
        fontSize: AppSize.s20,
      ),
    ),
    // colorScheme: ColorScheme.fromSeed(
    //   seedColor: Palette.restaurantColor,
    // ),
  );
}
