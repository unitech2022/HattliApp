import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatlli/core/enums/loading_status.dart';
import 'package:hatlli/core/helpers/helper_functions.dart';
import 'package:hatlli/core/layout/app_fonts.dart';
import 'package:hatlli/core/utils/api_constatns.dart';
import 'package:hatlli/core/utils/app_model.dart';
import 'package:hatlli/core/widgets/texts.dart';
import '../../../../core/layout/app_assets.dart';
import '../../../../core/layout/palette.dart';
import '../../../../core/router/routes.dart';
import '../../../common/bloc/home_cubit/home_cubit.dart';
import '../home_user_screen/home_user_screen.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width / 1.5,
      backgroundColor: Colors.white,
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return state.getHomeProviderState == RequestState.loaded ||
                  state.getHomeUserState == RequestState.loaded
              ? SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(children: [
                      const SizedBox(height: 55),
                      const DetailsUserWidget(),
                      const SizedBox(
                        height: 15,
                      ),
                      const Divider(
                        height: .8,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      ItemDrawerWidget(
                        title: "الرئيسية",
                        onTap: () {
                          HomeCubit.get(context)
                              .changeCurrentIndexDrawer("الرئيسية");
                          pop(context);
                          pushPageRoutName(context,currentUser.role == AppModel.userRole? navUser:navProvider);
                        },
                        color: state.indexHomeSide == "الرئيسية"
                            ? Colors.black
                            : const Color(0xff7E7E7E),
                        currentIndex: state.indexHomeSide,
                        icon: 'assets/icons/home_menu.svg',
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Divider(
                        height: .8,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      currentUser.role == AppModel.userRole
                          ? Column(
                              children: [
                                ItemDrawerWidget(
                                  title: "سلة المشتريات",
                                  onTap: () {
                                    HomeCubit.get(context)
                                        .changeCurrentIndexDrawer(
                                            "سلة المشتريات");
                                    pop(context);
                                    pushPageRoutName(context, cart);
                                  },
                                  color: state.indexHomeSide == "سلة المشتريات"
                                      ? Colors.black
                                      : const Color(0xff7E7E7E),
                                  currentIndex: state.indexHomeSide,
                                  icon: 'assets/icons/cart_menu.svg',
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Divider(
                                  height: .8,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                ItemDrawerWidget(
                                  title: "المفضلة",
                                  onTap: () {
                                    HomeCubit.get(context)
                                        .changeCurrentIndexDrawer("المفضلة");
                                    pop(context);
                                    pushPageRoutName(context, fav);
                                  },
                                  color: state.indexHomeSide == "المفضلة"
                                      ? Colors.black
                                      : const Color(0xff7E7E7E),
                                  currentIndex: state.indexHomeSide,
                                  icon: 'assets/icons/fav_menu.svg',
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Divider(
                                  height: .8,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            )
                          : const SizedBox(),
                      currentUser.role == AppModel.providerRole
                          ? Column(
                              children: [
                                ItemDrawerWidget(
                                  title: "احصائيات",
                                  onTap: () {
                                    HomeCubit.get(context)
                                        .changeCurrentIndexDrawer("احصائيات");
                                    pop(context);
                                    pushPageRoutName(context, statistics);
                                  },
                                  color: state.indexHomeSide == "احصائيات"
                                      ? Colors.black
                                      : const Color(0xff7E7E7E),
                                  currentIndex: state.indexHomeSide,
                                  icon: 'assets/icons/graph.svg',
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Divider(
                                  height: .8,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            )
                          : const SizedBox(),
                      ItemDrawerWidget(
                        title: "اتصل بنا",
                        onTap: () {
                          HomeCubit.get(context)
                              .changeCurrentIndexDrawer("اتصل بنا");
                          pop(context);
                          pushPageRoutName(context, abouteUs);
                        },
                        color: state.indexHomeSide == "اتصل بنا"
                            ? Colors.black
                            : const Color(0xff7E7E7E),
                        currentIndex: state.indexHomeSide,
                        icon: 'assets/icons/call_menu.svg',
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Divider(
                        height: .8,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ItemDrawerWidget(
                        title: "من نحن",
                        onTap: () {
                          HomeCubit.get(context)
                              .changeCurrentIndexDrawer("من نحن");
                          pop(context);
                          pushPageRoutName(context, abouteUs);
                        },
                        color: state.indexHomeSide == "من نحن"
                            ? Colors.black
                            : const Color(0xff7E7E7E),
                        currentIndex: state.indexHomeSide,
                        icon: 'assets/icons/us.svg',
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Divider(
                        height: .8,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ItemDrawerWidget(
                        title: "سياسة الاستخدام",
                        onTap: () {
                          HomeCubit.get(context)
                              .changeCurrentIndexDrawer("سياسة الاستخدام");
                          pop(context);
                          pushPageRoutName(context, praivcy);
                        },
                        color: state.indexHomeSide == "سياسة الاستخدام"
                            ? Colors.black
                            : const Color(0xff7E7E7E),
                        currentIndex: state.indexHomeSide,
                        icon: 'assets/icons/us.svg',
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Divider(
                        height: .8,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ItemDrawerWidget(
                        title: "تسجيل الخروج ",
                        onTap: () {
                          // HomeCubit.get(context)
                          //     .changeCurrentIndexDrawer("تسجيل الخروج");
                          signOut(ctx: context);
                        },
                        color: state.indexHomeSide == "تسجيل الخروج "
                            ? Colors.black
                            : const Color(0xff7E7E7E),
                        currentIndex: state.indexHomeSide,
                        icon: 'assets/icons/logout.svg',
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Image.asset(AppAssets.logoBlack),
                    ]),
                  ),
                )
              : const SizedBox();
        },
      ),
    );
  }
}

class ItemDrawerWidget extends StatelessWidget {
  final String title, icon;
  final void Function() onTap;
  final String currentIndex;
  final Color color;
  const ItemDrawerWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    required this.currentIndex,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        padding: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: currentIndex == title ? const Color(0xfffbf8f5) : Colors.white,
          borderRadius: BorderRadius.circular(9.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  icon,
                  color: currentIndex == title
                      ? Palette.mainColor
                      : const Color(0xff7E7E7E),
                ),
                const SizedBox(
                  width: 8,
                ),
                Texts(
                    title: title,
                    family: AppFonts.caSi,
                    size: 14,
                    textColor: color,
                    widget: FontWeight.bold)
              ],
            ),
            IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
                  "assets/icons/back.svg",
                  color: color,
                ))
          ],
        ),
      ),
    );
  }
}

class DetailsUserWidget extends StatelessWidget {
  const DetailsUserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Column(
          children: [
            Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Palette.mainColor,
                  width: 2
                )
              ),
              child: CircleImageNetwork(
                imageError:"assets/images/person.png",
                image:ApiConstants.imageUrl(currentUser.role ==AppModel.userRole?state.homeUserResponse!.user!.profileImage:state.homeResponseProvider!.provider!.logoCompany),
                height: 66,
                width: 66,
                colorBackground: Palette.mainColor,
              ),
            ),
            const SizedBox(
              height: 9,
            ),
             Texts(
                title:currentUser.role ==AppModel.userRole?state.homeUserResponse!.user!.fullName:state.homeResponseProvider!.provider!.title,
                family: AppFonts.caM,
                size: 12,
                textColor: Colors.black,
                widget: FontWeight.normal),
             Texts(
                title: currentUser.role ==AppModel.userRole?state.homeUserResponse!.user!.email:state.homeResponseProvider!.provider!.email,
                family: AppFonts.caM,
                size: 12,
                textColor: Colors.black,
                widget: FontWeight.normal),
          ],
        );
      },
    );
  }
}
