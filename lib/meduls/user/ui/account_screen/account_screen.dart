import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:hatlli/core/extension/theme_extension.dart';
import 'package:hatlli/core/layout/screen_size.dart';
import 'package:hatlli/meduls/common/bloc/home_cubit/home_cubit.dart';
import 'package:hatlli/meduls/user/ui/account_screen/update_profile_screen.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/layout/app_fonts.dart';
import '../../../../core/layout/app_radius.dart';

import '../../../../core/widgets/icon_alert_widget.dart';
import '../../../../core/widgets/texts.dart';
import '../components/darwer_widget.dart';


class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});

  final scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldkey,
        drawer: const DrawerWidget(),
        appBar: AppBar(
          backgroundColor: const Color(0xffFEFEFE),
          elevation: 0,
          leading: GestureDetector(
              onTap: () {
                scaffoldkey.currentState!.openDrawer();
              },
              child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: SvgPicture.asset(
                    "assets/icons/menu.svg",
                    height: 17,
                    width: 26,
                  ))),
          title: const Texts(
              title: "حسابي",
              family: AppFonts.taB,
              size: 18,
              widget: FontWeight.bold),
          actions: [
             IconAlertWidget()  ],
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: const Color(0xfffcfcfd),
                      borderRadius: BorderRadius.circular(15),
                      // border: Border.all(width: .6,color: Colors.grey),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x269b9b9b),
                          offset: Offset(0, 0),
                          blurRadius: 50,
                        ),
                      ],
                    ),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      ContainerItemAccount(
                        onTap: () {
                          pushPage(
                              context,
                              UpdateProfileScreen(
                                  value: state.userModel!.fullName, type: 0));
                        },
                        title: "الأسم  : ",
                        value: state.userModel!.fullName,
                        image: "assets/icons/account2.svg",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ContainerItemAccount(
                        onTap: () {},
                        title: "رقم الهاتف  : ",
                        value: state.userModel!.userName,
                        image: "assets/icons/call2.svg",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ContainerItemAccount(
                        onTap: () {
                          pushPage(
                              context,
                              UpdateProfileScreen(
                                  value: state.userModel!.city, type: 1));
                        },
                        title: "المدينة  : ",
                        value: state.userModel!.city,
                        image: "assets/icons/location_tick.svg",
                      )
                    ]),
                  ),
                  const Spacer(),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    width: context.wSize,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        signOut(ctx: context);
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          // onPressed == null ? Palette.kGreyColor : Palette.mainColor,
                          const Color(0xffD13A3A),
                        ),
                        elevation: MaterialStateProperty.all(12),
                        shape: MaterialStateProperty.resolveWith((states) {
                          if (!states.contains(MaterialState.pressed)) {
                            return const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                              side: BorderSide.none,
                            );
                          }
                          return const RoundedRectangleBorder(
                            borderRadius: AppRadius.r10,
                          );
                        }),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset("assets/icons/logout2.svg"),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "تسجيل الخروج",
                            style: context.titleM.copyWith(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontFamily: AppFonts.caSi,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  )
                ],
              ),
            );
          },
        ));
  }

  void showDialogUpdateUser({context, title}) {
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            insetPadding: const EdgeInsets.symmetric(horizontal: 30),
            content: Container(
              // padding: const EdgeInsets.all(12),
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(25)),
              width: widthScreen(context),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            pop(context);
                          },
                          child: SvgPicture.asset("assets/icons/close.svg")),
                    ],
                  ),
                  SvgPicture.asset("assets/icons/successd.svg"),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class ContainerItemAccount extends StatelessWidget {
  final String image, title, value;
  final void Function() onTap;

  const ContainerItemAccount({
    super.key,
    required this.image,
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            SvgPicture.asset(image),
          ],
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Texts(title: title, family: AppFonts.moM, size: 12),
            Texts(
              title: value,
              family: AppFonts.caSi,
              size: 12,
              textColor: const Color(0xffC3C3C3),
            ),
          ],
        ),
        const Spacer(),
        GestureDetector(
          onTap: onTap,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Texts(
                title: "تعديل",
                family: AppFonts.caSi,
                size: 12,
                textColor: Color(0xffC3C3C3),
              ),
              SvgPicture.asset("assets/icons/edit2.svg")
            ],
          ),
        )
      ],
    );
  }
}
