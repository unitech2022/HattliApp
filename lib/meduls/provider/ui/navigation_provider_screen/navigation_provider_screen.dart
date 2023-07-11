import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatlli/core/enums/loading_status.dart';
import 'package:hatlli/core/helpers/helper_functions.dart';
import 'package:hatlli/core/widgets/custom_button.dart';

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
    HomeCubit.get(context).getHomeProvider(context: context);
    //  NotificationCubit.get(context).getAlerts(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return state.getHomeProviderState == RequestState.loaded
            ? state.homeResponseProvider!.provider == null
                ? Scaffold(
                    body: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomButton(
                                title: "انشاء متجرى",
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
                                child: const Text(
                                  "تسجيل خروج",
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
                        title: setTitleAppBar(state.currentNavIndex)),
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
                                label: "الرئيسية"),
                            BottomNavigationBarItem(
                                icon: SvgPicture.asset(
                                    "assets/icons/orders.svg",
                                    color: state.currentNavIndex == 1
                                        ? Palette.mainColor
                                        : const Color(0xffADADAD)),
                                label: "طلباتي"),
                            BottomNavigationBarItem(
                                icon: SvgPicture.asset(
                                    "assets/icons/providers.svg",
                                    color: state.currentNavIndex == 2
                                        ? Palette.mainColor
                                        : const Color(0xffADADAD)),
                                label: "المنتجات"),
                            BottomNavigationBarItem(
                                icon: SvgPicture.asset(
                                    "assets/icons/account.svg",
                                    color: state.currentNavIndex == 3
                                        ? Palette.mainColor
                                        : const Color(0xffADADAD)),
                                label: "حسابي"),
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
                  )
            : const Scaffold(
                body: CustomCircularProgress(
                  fullScreen: true,
                  strokeWidth: 4,
                  size: Size(50, 50),
                ),
              );
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
}
