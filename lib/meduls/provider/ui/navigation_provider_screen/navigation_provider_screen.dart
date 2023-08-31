import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatlli/core/enums/loading_status.dart';
import 'package:hatlli/core/helpers/Notification_controller.dart';
import 'package:hatlli/core/helpers/helper_functions.dart';
import 'package:hatlli/core/router/routes.dart';
import 'package:hatlli/core/widgets/custom_button.dart';
import 'package:hatlli/core/widgets/texts.dart';

import 'package:hatlli/meduls/provider/ui/add_product_screen/add_product_screen.dart';
import 'package:hatlli/meduls/provider/ui/create_account_provider_screen/create_account_provider_screen.dart';

import '../../../../core/layout/app_fonts.dart';
import '../../../../core/layout/palette.dart';
import '../../../../core/utils/app_model.dart';
import '../../../../core/widgets/circular_progress.dart';
import '../../../common/bloc/home_cubit/home_cubit.dart';
import '../../../user/ui/components/darwer_widget.dart';
import '../home_screen/home_screen.dart';

class NavigationProviderScreen extends StatefulWidget {
  const NavigationProviderScreen({super.key});

  @override
  State<NavigationProviderScreen> createState() =>
      _NavigationProviderScreenState();
}

class _NavigationProviderScreenState extends State<NavigationProviderScreen> {
  final scaffolded = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getFCMToken();
    HomeCubit.get(context).getHomeProvider(context: context);

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      pushPageRoutName(context, notyUser);
    });

  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        switch (state.getHomeProviderState) {
          case RequestState.noInternet:
            return NoInternetWidget(
              onPress: () {
                 HomeCubit.get(context).getHomeProvider(context: context);
              },
            );
          case RequestState.loaded:
            return state.homeResponseProvider!.provider == null
                ? Scaffold(
                    body: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomButton(
                                title: "انشاء متجرى".tr(),
                                onPressed: () {
                                  pushPage(context,
                                      const CreateAccountProviderScreen());
                                }),
                            SizedBox(
                              height: 20,
                            ),
                            TextButton(
                                onPressed: () {
                                  signOut(ctx: context);
                                },
                                child: Text(
                                  "تسجيل خروج".tr(),
                                  style: TextStyle(
                                      fontFamily: AppFonts.caB,
                                      color: Colors.red),
                                ))
                          ],
                        ),
                      ),
                    ),
                  )
                : Scaffold(
                    key: scaffolded,
                    backgroundColor: const Color(0xffFEFEFE),
                    drawer: const DrawerWidget(),
                    appBar: appBarWidget(
                        scaffolded: scaffolded,
                        countNoty:
                            state.homeResponseProvider!.notiyCount.toString(),
                        context: context,
                        title: setTitleAppBar(state.currentNavIndex).tr()),
                    floatingActionButton: state.currentNavIndex == 3
                        ? const SizedBox()
                        : GestureDetector(
                            onTap: () {
                              // todo : add product
                              pushPage(context, AddProductScreen());
                            },
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: const BoxDecoration(
                                color: Palette.mainColor,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: .8, color: Colors.white),
                                      shape: BoxShape.circle,
                                    ),
                                    child: SvgPicture.asset(
                                        "assets/icons/add.svg")),
                              ),
                            ),
                          ),
                    bottomNavigationBar: Container(
                      padding: const EdgeInsets.only(top: 15),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25))),
                      child: BottomNavigationBar(
                          elevation: 0,
                          currentIndex: state.currentNavIndex,
                          fixedColor: Palette.mainColor,
                          enableFeedback: false,
                          type: BottomNavigationBarType.fixed,
                          unselectedItemColor: const Color(0xffADADAD),
                          showUnselectedLabels: true,
                          backgroundColor: Colors.transparent,
                          unselectedIconTheme:
                              const IconThemeData(color: Color(0xffADADAD)),
                          onTap: (value) {
                            HomeCubit.get(context).changeCurrentIndexNav(value);
                          },
                          items: [
                            BottomNavigationBarItem(
                                icon: SvgPicture.asset(
                                  "assets/icons/home.svg",
                                  color: state.currentNavIndex == 0
                                      ? Palette.mainColor
                                      : const Color(0xffADADAD),
                                ),
                                label: "الرئيسية".tr()),
                            BottomNavigationBarItem(
                                icon: SvgPicture.asset(
                                    "assets/icons/orders.svg",
                                    color: state.currentNavIndex == 1
                                        ? Palette.mainColor
                                        : const Color(0xffADADAD)),
                                label: "طلباتي".tr()),
                            BottomNavigationBarItem(
                                icon: SvgPicture.asset(
                                    "assets/icons/providers.svg",
                                    color: state.currentNavIndex == 2
                                        ? Palette.mainColor
                                        : const Color(0xffADADAD)),
                                label: "المنتجات".tr()),
                            BottomNavigationBarItem(
                                icon: SvgPicture.asset(
                                    "assets/icons/account.svg",
                                    color: state.currentNavIndex == 3
                                        ? Palette.mainColor
                                        : const Color(0xffADADAD)),
                                label: "حسابي".tr()),
                          ]),
                    ),
                    body: RefreshIndicator(
                      onRefresh: () async {
                        HomeCubit.get(context)
                            .getHomeProvider(context: context);
                      },
                      child: IndexedStack(
                        index: state.currentNavIndex,
                        children: screensProvider,
                      ),
                    ),
                  );

          case RequestState.error:
          case RequestState.loading:
            return const Scaffold(
              body: CustomCircularProgress(
                fullScreen: true,
                strokeWidth: 4,
                size: Size(50, 50),
              ),
            );
          default:
            return const Scaffold(
              body: CustomCircularProgress(
                fullScreen: true,
                strokeWidth: 4,
                size: Size(50, 50),
              ),
            );
        }
      },
    );
  }

  String setTitleAppBar(int index) {
    switch (index) {
      case 0:
        return "الرئيسية";
      case 1:
        return "الطلبات";
      case 2:
        return "منتجاتك";

      default:
        return "حسابي";
    }
  }

  void getFCMToken() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      // NotifyAowsome(notification!.title!,notification.body!);
      if (notification != null && android != null && !kIsWeb) {
        print("tokrrrrrrnseneeeeee");
        HomeCubit.get(context)
            .getHomeProvider(context: context, isState: false);

        AwesomeNotifications().createNotification(
            content: NotificationContent(
          id: createUniqueId(),

          color: Colors.blue,

          channelKey: 'hattli',
          title: notification.title,
          body: notification.body,

          // notificationLayout: NotificationLayout.BigPicture,
          // largeIcon: "asset://assets/images/logo_final.png"
        ));
        AwesomeNotifications().setListeners(
            onActionReceivedMethod:
                NotificationController.onActionReceivedMethod,
            onNotificationCreatedMethod:
                NotificationController.onNotificationCreatedMethod,
            onNotificationDisplayedMethod:
                NotificationController.onNotificationDisplayedMethod,
            onDismissActionReceivedMethod:
                NotificationController.onDismissActionReceivedMethod);
        // print("aaaaaaaaaaaawww${message.data["desc"]}");
      }
    });
  }
}

class NoInternetWidget extends StatelessWidget {
  final void Function() onPress;
  const NoInternetWidget({
    super.key,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Texts(
              title: "لا يوجد اتصال بالانترنت".tr(),
              family: AppFonts.taB,
              size: 20,
              textColor: Colors.black,
              widget: FontWeight.w700),
          SizedBox(
            height: 20,
          ),
          Icon(
            Icons.signal_wifi_statusbar_connected_no_internet_4,
            size: 80,
            color: Colors.grey,
          ),
          SizedBox(
            height: 50,
          ),
          CustomButton(
            title: "اعادة المحاولة".tr(),
            onPressed: onPress,
            backgroundColor: Colors.red,
          )
        ],
      ),
    ));
  }
}
