import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:hatlli/meduls/common/ui/select_type_account_screen/select_type_account_screen.dart';

import 'core/router/routes.dart';
import 'core/styles/thems.dart';
import 'meduls/common/ui/login_screem/login_screen.dart';
import 'meduls/common/ui/splash_screen/splash_screen.dart';

void main()async {
    WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale("ar"), Locale("en")],
        path: "assets/i18n",
        // <-- change the path of the translation files
        fallbackLocale: const Locale("ar"),
        startLocale: const Locale("ar"),
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
 ));
    return MaterialApp(
      title: 'Flutter Demo',
       localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
       theme: lightTheme(context),
       initialRoute: selectAccount,
          routes: {
            splash: (context) => const SplashScreen(),
            selectAccount: (context) => const SelectTypeAccountScreen(),
            
        login :(context) =>const LoginScreen(),
          }
    );
  }
}
