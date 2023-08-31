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
import 'package:hatlli/core/layout/app_fonts.dart';
import 'package:hatlli/core/layout/palette.dart';
import 'package:hatlli/core/router/routes.dart';
import 'package:hatlli/core/utils/app_model.dart';
import 'package:hatlli/core/widgets/texts.dart';
import 'package:badges/badges.dart' as badges;
import 'package:hatlli/meduls/user/ui/components/darwer_widget.dart';
import '../../../../core/widgets/circular_progress.dart';
import '../../../common/bloc/home_cubit/home_cubit.dart';
import '../../../provider/ui/navigation_provider_screen/navigation_provider_screen.dart';

class NavigationUserScreen extends StatefulWidget {
  const NavigationUserScreen({super.key});

  @override
  State<NavigationUserScreen> createState() => _NavigationUserScreenState();
}

class _NavigationUserScreenState extends State<NavigationUserScreen> {
  GlobalKey<ScaffoldState> scaffoldkey1 = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getFCMToken();
    if(mounted){
      HomeCubit.get(context).getHomeUser(context: context);
    }

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
// here you have your message do as you wish
      pushPageRoutName(context, notyUser);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
       

    

        switch (state.getHomeUserState) {
          case RequestState.noInternet:
            return NoInternetWidget(
              onPress: () {
                HomeCubit.get(context).getHomeUser(context: context);
              },
            );
          case RequestState.loaded:
            return
            RefreshIndicator(
              onRefresh: () async {
                HomeCubit.get(context).getHomeUser(context: context);
              },
              child: Scaffold(
                key: scaffoldkey1,
                drawer: const DrawerWidget(),
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
                            icon: SvgPicture.asset("assets/icons/orders.svg",
                                color: state.currentNavIndex == 1
                                    ? Palette.mainColor
                                    : const Color(0xffADADAD)),
                            label: "طلباتي".tr()),
                        BottomNavigationBarItem(
                            icon: SvgPicture.asset("assets/icons/providers.svg",
                                color: state.currentNavIndex == 2
                                    ? Palette.mainColor
                                    : const Color(0xffADADAD)),
                            label: "المزودين".tr()),
                        BottomNavigationBarItem(
                            icon: SvgPicture.asset("assets/icons/account.svg",
                                color: state.currentNavIndex == 3
                                    ? Palette.mainColor
                                    : const Color(0xffADADAD)),
                            label: "حسابي".tr()),
                      ]),
                ),
                body: Stack(
                  children: [
                    IndexedStack(
                      index: state.currentNavIndex,
                      children: screensUser,
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding:
                        const EdgeInsets.only(left: 0, right: 0, top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                MenuIconWidget(scaffoldkey: scaffoldkey1),
                                const SizedBox(
                                  width: 8,
                                ),
                                Texts(
                                    title: setTitleAppBar(state.currentNavIndex)
                                        .tr(),
                                    family: AppFonts.taB,
                                    size: 18,
                                    widget: FontWeight.bold),
                              ],
                            ),
                            MaterialButton(
                              onPressed: () {
                                pushPageRoutName(context, notyUser);
                              },
                              minWidth: 40,
                              height: 40,
                              child: badges.Badge(
                                badgeContent: Text(
                                  state.homeUserResponse!.notiyCount.toString(),
                                  style: const TextStyle(
                                      color: Colors.white, height: 1.8),
                                ),
                                position:
                                badges.BadgePosition.topStart(top: -12),
                                badgeStyle: const badges.BadgeStyle(
                                    badgeColor: Palette.mainColor),
                                child:
                                SvgPicture.asset("assets/icons/noty.svg"),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
           case RequestState.error:
          case RequestState.loading:
            return Scaffold(
              body: CustomCircularProgress(
                fullScreen: true,
                strokeWidth: 4,
                size: Size(50, 50),
              ),
            );
          default:
            return Scaffold(
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
        return "طلباتي";
      case 2:
        return "المزودين";
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
        // print("tokrrrrrrnseneeeeee");
        HomeCubit.get(context).getHomeUser(context: context, isStat: false);

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

class MenuIconWidget extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldkey;
  const MenuIconWidget({
    super.key,
    required this.scaffoldkey,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        scaffoldkey.currentState!.openDrawer();
      },
      child: SvgPicture.asset("assets/icons/menu.svg"),
    );
  }
}
