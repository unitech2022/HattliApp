import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatlli/core/enums/loading_status.dart';
import 'package:hatlli/core/helpers/helper_functions.dart';
import 'package:hatlli/core/layout/app_fonts.dart';
import 'package:hatlli/core/utils/api_constatns.dart';
import 'package:hatlli/core/utils/app_model.dart';
import 'package:hatlli/core/widgets/custom_button.dart';
import 'package:hatlli/core/widgets/texts.dart';
import 'package:hatlli/meduls/common/ui/map_screen/map_screen.dart';
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
                      isLogin()
                          ? const DetailsUserWidget()
                          : Image.asset(AppAssets.logoBlack),
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
                        title: "الرئيسية".tr(),
                        onTap: () {
                          HomeCubit.get(context)
                              .changeCurrentIndexDrawer("الرئيسية".tr());
                          pop(context);
                          if (isLogin()) {
                            pushPageRoutName(
                                context,
                                currentUser.role == AppModel.userRole
                                    ? navUser
                                    : navProvider);
                          } else {
                            pushPageRoutName(context, navUser);
                          }
                        },
                        color: state.indexHomeSide == "الرئيسية".tr()
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
                      isLogin() && currentUser.role == AppModel.userRole
                          ? Column(
                              children: [
                                ItemDrawerWidget(
                                  title: "سلة المشتريات".tr(),
                                  onTap: () {
                                    HomeCubit.get(context)
                                        .changeCurrentIndexDrawer(
                                            "سلة المشتريات".tr());
                                    pop(context);
                                    pushPageRoutName(context, cart);
                                  },
                                  color: state.indexHomeSide == "سلة المشتريات".tr()
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
                                  title: "المفضلة".tr(),
                                  onTap: () {
                                    HomeCubit.get(context)
                                        .changeCurrentIndexDrawer("المفضلة".tr());
                                    pop(context);
                                    pushPageRoutName(context, fav);
                                  },
                                  color: state.indexHomeSide == "المفضلة".tr()
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
                                ItemDrawerWidget(
                                  title: "تغيير عنوانى".tr(),
                                  onTap: () {
                                    HomeCubit.get(context)
                                        .changeCurrentIndexDrawer(
                                            "تغيير عنوانى".tr());
                                    pop(context);
                                   pushPage(
                                      context,
                                     MapScreen(
                                        type: 2,addressModel:  state.homeUserResponse!.address,
                                      ),
                                    );

                                  },
                                  color: state.indexHomeSide == "تغيير عنوانى".tr()
                                      ? Colors.black
                                      : const Color(0xff7E7E7E),
                                  currentIndex: state.indexHomeSide,
                                  icon: 'assets/icons/location.svg',
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

                          // ***  change Lang 
                            ItemDrawerWidget(
                                  title: "تغيير اللغة".tr(),
                                  onTap: () {
                                    HomeCubit.get(context)
                                        .changeCurrentIndexDrawer("تغيير اللغة".tr());
                                    pop(context);
                                    // pushPageRoutName(context, statistics);
                                  showChangeLangDialog(context);
                                  },
                                  color: state.indexHomeSide == "تغيير اللغة".tr()
                                      ? Colors.black
                                      : const Color(0xff7E7E7E),
                                  currentIndex: state.indexHomeSide,
                                  icon: 'assets/icons/translate.svg',
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
                      currentUser.role == AppModel.providerRole
                          ? Column(
                              children: [
                                ItemDrawerWidget(
                                  title: "احصائيات".tr(),
                                  onTap: () {
                                    HomeCubit.get(context)
                                        .changeCurrentIndexDrawer("احصائيات".tr());
                                    pop(context);
                                    pushPageRoutName(context, statistics);
                                  },
                                  color: state.indexHomeSide == "احصائيات".tr()
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
                      // ** update Address

                      ItemDrawerWidget(
                        title: "اتصل بنا".tr(),
                        onTap: () {
                          HomeCubit.get(context)
                              .changeCurrentIndexDrawer("اتصل بنا".tr());
                          // pop(context);
                          showBottomSheetWidget(context, callUs(context));
                        },
                        color: state.indexHomeSide == "اتصل بنا".tr()
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
                        title: "من نحن".tr(),
                        onTap: () {
                          HomeCubit.get(context)
                              .changeCurrentIndexDrawer("من نحن".tr());
                          pop(context);
                          pushPageRoutName(context, abouteUs);
                        },
                        color: state.indexHomeSide == "من نحن".tr()
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
                        title: "سياسة الاستخدام".tr(),
                        onTap: () {
                          HomeCubit.get(context)
                              .changeCurrentIndexDrawer("سياسة الاستخدام".tr());
                          pop(context);
                          pushPageRoutName(context, praivcy);
                        },
                        color: state.indexHomeSide == "سياسة الاستخدام".tr()
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
                        title: "الأسئلة الشائعة".tr(),
                        onTap: () {
                          HomeCubit.get(context)
                              .changeCurrentIndexDrawer("الأسئلة الشائعة".tr());
                          pop(context);
                          pushPageRoutName(context, quizscreen);
                        },
                        color: state.indexHomeSide == "الأسئلة الشائعة".tr()
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
                        title: isLogin() ? "تسجيل الخروج".tr() : "تسجيل الدخول".tr(),
                        onTap: () {
                          // HomeCubit.get(context)
                          //     .changeCurrentIndexDrawer("تسجيل الخروج");
                          if (isLogin()) {
                            signOut(ctx: context);
                          } else {
                            pushPageRoutName(context, selectAccount);
                          }
                        },
                        color: state.indexHomeSide == "تسجيل الخروج".tr()
                            ? Colors.black
                            : const Color(0xff7E7E7E),
                        currentIndex: state.indexHomeSide,
                        icon: 'assets/icons/logout.svg',
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      isLogin() ? Image.asset(AppAssets.logoBlack) : SizedBox(),
                    ]),
                  ),
                )
              : const SizedBox();
        },
      ),
    );
  }
  
  void showChangeLangDialog(BuildContext context) {
      showDialog<void>(
                context: context,
    
                barrierDismissible: false,
                // user must tap button!
                builder: (BuildContext context) {
                  return AlertDialog(
                    insetPadding: EdgeInsets.symmetric(horizontal: 20),
                    title: Text(
                      "تغيير اللغة".tr(),
                      style: TextStyle(fontSize: 20, color: Palette.mainColor),
                    ),
                    content: Container(
                      width: widthScreen(context),
                      child: SingleChildScrollView(
                        child: ListBody(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: Text(
                                  "هل تريد تغيير لغة التطبيق  ؟".tr(),
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                  textAlign: TextAlign.center,
                                )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: <Widget>[
                      Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                              elevation: 0,
                              backgroundColor: Palette.mainColor,
                              titleColor: Colors.white,
                              onPressed: () async {
                                if(AppModel.lang=="en"){
                                  AppModel.lang = "ar";
                                context.setLocale(Locale('ar'));
                                await saveData(ApiConstants.langKey, 'ar');
                                pop(context);
                                Navigator.pushNamed(context, splash);
                                }else {
                                  AppModel.lang = "en";
                                context.setLocale(Locale('en'));
                                await saveData(ApiConstants.langKey, 'en');
                                pop(context);
                                Navigator.pushNamed(context, splash);
                                }
                              },
                              title:"تغيير".tr(),
                                  
                              
                            ),
                          ),
                          SizedBox(width: 20,),
                          Expanded(
                            child: CustomButton(
                               elevation: 0,
                              backgroundColor: Colors.white,
                              titleColor: Colors.red,
                              onPressed: () async {
                               
                                pop(context);
                              
                              },
                              title: "الغاء".tr(),
                                  
                              ),
                            ),
                          
                    
                        ],
                      )
                    ],
                  );
                },
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
                  height: 25,width: 25,
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
                icon:AppModel.lang=="en"?Icon(Icons.arrow_right_alt_outlined,color: color,):SvgPicture.asset("assets/icons/arrow-left.svg",color: color,))
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
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Column(
          children: [
            Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Palette.mainColor, width: 2)),
              child: CircleImageNetwork(
                imageError: "assets/images/person.png",
                image: ApiConstants.imageUrl(
                    currentUser.role == AppModel.userRole
                        ? state.homeUserResponse!.user!.profileImage
                        : state.homeResponseProvider!.provider!.logoCompany),
                height: 66,
                width: 66,
                colorBackground: Palette.mainColor,
              ),
            ),
            const SizedBox(
              height: 9,
            ),
            Texts(
                title: currentUser.role == AppModel.userRole
                    ? state.homeUserResponse!.user!.fullName
                    : state.homeResponseProvider!.provider!.title,
                family: AppFonts.caM,
                size: 12,
                textColor: Colors.black,
                widget: FontWeight.normal),
            Texts(
                title: currentUser.role == AppModel.userRole
                    ? ""
                    : state.homeResponseProvider!.provider!.email,
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
