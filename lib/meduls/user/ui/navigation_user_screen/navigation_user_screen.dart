import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatlli/core/enums/loading_status.dart';
import 'package:hatlli/core/layout/palette.dart';
import 'package:hatlli/core/utils/app_model.dart';

import '../../../../core/widgets/circular_progress.dart';
import '../../../common/bloc/home_cubit/home_cubit.dart';

class NavigationUserScreen extends StatefulWidget {
  const NavigationUserScreen({super.key});

  @override
  State<NavigationUserScreen> createState() => _NavigationUserScreenState();
}

class _NavigationUserScreenState extends State<NavigationUserScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HomeCubit.get(context).getHomeUser(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return state.getHomeUserState == RequestState.loaded
            ? RefreshIndicator(
              onRefresh: ()async { 
                 HomeCubit.get(context).getHomeUser(context: context);
               },
              child: Scaffold(
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
                              icon: SvgPicture.asset("assets/icons/orders.svg",
                                  color: state.currentNavIndex == 1
                                      ? Palette.mainColor
                                      : const Color(0xffADADAD)),
                              label: "طلباتي"),
                          BottomNavigationBarItem(
                              icon: SvgPicture.asset("assets/icons/providers.svg",
                                  color: state.currentNavIndex == 2
                                      ? Palette.mainColor
                                      : const Color(0xffADADAD)),
                              label: "المزودين"),
                          BottomNavigationBarItem(
                              icon: SvgPicture.asset("assets/icons/account.svg",
                                  color: state.currentNavIndex == 3
                                      ? Palette.mainColor
                                      : const Color(0xffADADAD)),
                              label: "حسابي"),
                        ]),
                  ),
                  body: IndexedStack(
                    index: state.currentNavIndex,
                    children: screensUser,
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
}
