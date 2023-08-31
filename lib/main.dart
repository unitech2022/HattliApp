import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:hatlli/core/helpers/helper_functions.dart';
import 'package:hatlli/meduls/common/bloc/address_cubit/address_cubit.dart';
import 'package:hatlli/meduls/common/bloc/auth_cubit/auth_cubit.dart';
import 'package:hatlli/meduls/common/bloc/notification_cubit/notification_cubit.dart';
import 'package:hatlli/meduls/common/ui/chose_lang_screen/chose_lang_screen.dart';
import 'package:hatlli/meduls/common/ui/quiez_screen/quiz_screen.dart';
import 'package:hatlli/meduls/common/ui/select_type_account_screen/select_type_account_screen.dart';
import 'package:hatlli/meduls/provider/bloc/provider_cubit/provider_cubit.dart';
import 'package:hatlli/meduls/provider/bloc/statist_cubit/statist_cubit.dart';
import 'package:hatlli/meduls/provider/ui/create_account_provider_screen/create_account_provider_screen.dart';
import 'package:hatlli/meduls/provider/ui/home_screen/home_screen.dart';
import 'package:hatlli/meduls/provider/ui/navigation_provider_screen/navigation_provider_screen.dart';
import 'package:hatlli/meduls/provider/ui/statistics_screen/statistics_screen.dart';
import 'package:hatlli/meduls/user/bloc/cart_cubit/cart_cubit.dart';
import 'package:hatlli/meduls/user/bloc/favoraite_cubit/favoraite_cubit.dart';

import 'package:hatlli/meduls/common/ui/aboute_us_screen/aboute_us_screen.dart';
import 'package:hatlli/meduls/user/ui/cart_screen/cart_screen.dart';

import 'package:hatlli/meduls/user/ui/favorait_screen/favorait_screen.dart';
import 'package:hatlli/meduls/user/ui/home_user_screen/home_user_screen.dart';
import 'package:hatlli/meduls/user/ui/navigation_user_screen/navigation_user_screen.dart';
import 'package:hatlli/meduls/user/ui/notifications_screen/notifications_screen.dart';
import 'package:hatlli/meduls/common/ui/privacy_screen/privacy_screen.dart';
import 'core/router/routes.dart';
import 'core/styles/thems.dart';
import 'meduls/common/bloc/app_cubit/app_cubit.dart';
import 'meduls/common/bloc/home_cubit/home_cubit.dart';
import 'meduls/common/bloc/order_cubit/order_cubit.dart';
import 'meduls/common/bloc/product_cubit/product_cubit.dart';

import 'meduls/common/ui/splash_screen/splash_screen.dart';

Future<void> _messageHandler(RemoteMessage message) async {}
void initLocalNotification() {
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
      channelKey: 'hattli',
      channelName: 'hattli',
      channelDescription: "Notification nawte",
      defaultColor: Colors.transparent,
      ledColor: Colors.blue,
      channelShowBadge: true,

      importance: NotificationImportance.High,
      // playSound: true,
      // enableLights:true,
      // enableVibration: false
    )
  ]);
  
}

void main() async {
  // WidgetsBinding widgetsBinding=

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  FirebaseMessaging.onMessageOpenedApp;
//  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await EasyLocalization.ensureInitialized();
  
  await readToken();
  initLocalNotification();
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
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (BuildContext context) => AuthCubit()),
        BlocProvider<AppCubit>(create: (BuildContext context) => AppCubit()),
        BlocProvider<HomeCubit>(create: (BuildContext context) => HomeCubit()),
        BlocProvider<ProductCubit>(
            create: (BuildContext context) => ProductCubit()),
        BlocProvider<OrderCubit>(
            create: (BuildContext context) => OrderCubit()),
        BlocProvider<ProviderCubit>(
            create: (BuildContext context) => ProviderCubit()),
        BlocProvider<AddressCubit>(
            create: (BuildContext context) => AddressCubit()),
        BlocProvider<CartCubit>(create: (BuildContext context) => CartCubit()),
        BlocProvider<FavoriteCubit>(
            create: (BuildContext context) => FavoriteCubit()),
        BlocProvider<NotificationCubit>(
            create: (BuildContext context) => NotificationCubit()),
        BlocProvider<StatistCubit>(
            create: (BuildContext context) => StatistCubit()),
      ],
      child: MaterialApp(
          navigatorKey: MyApp.navigatorKey,
          title: "هاتلي",
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          debugShowCheckedModeBanner: false,
          theme: lightTheme(context),
          initialRoute: splash,
          routes: {
            splash: (context) => const SplashScreen(),
            selectAccount: (context) => const SelectTypeAccountScreen(),
            lang: (context) => const ChoseLangScreen(),
            createProvider: (context) => const CreateAccountProviderScreen(),
            homeProvider: (context) => HomeProviderScreen(),
            homeUser: (context) => HomeUserScreen(),
            navUser: (context) => const NavigationUserScreen(),
            // detailsProvider: (context) => const DetailsProviderScreen(),
            cart: (context) => const CartsScreen(),
            fav: (context) => FavoriteScreen(),
            notyUser: (context) => NotificationsScreen(),
            abouteUs: (context) => AboutUsScreen(),
            praivcy: (context) => PrivacyScreen(),
            navProvider: (context) => NavigationProviderScreen(),
            statistics: (context) => StatisticsScreen(),
            quizscreen: (context) => QuizScreen(),
            
          }),
    );
  }
}
