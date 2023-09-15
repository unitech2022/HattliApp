import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatlli/core/enums/loading_status.dart';

import 'package:hatlli/core/extension/theme_extension.dart';
import 'package:hatlli/core/layout/palette.dart';
import 'package:hatlli/core/layout/screen_size.dart';
import 'package:hatlli/meduls/common/bloc/auth_cubit/auth_cubit.dart';
import 'package:hatlli/meduls/common/bloc/home_cubit/home_cubit.dart';
import 'package:hatlli/meduls/user/ui/account_screen/update_profile_screen.dart';
import 'package:hatlli/meduls/user/ui/components/login_widget.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/layout/app_fonts.dart';
import '../../../../core/layout/app_radius.dart';

import '../../../../core/utils/api_constatns.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/texts.dart';
import '../home_user_screen/home_user_screen.dart';

class AccountScreen extends StatefulWidget {
  AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  GlobalKey<ScaffoldState> scaffoldkey4 = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldkey4,
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return isLogin()
                ? Padding(
                    padding: const EdgeInsets.only(
                      left: 22,
                      right: 22,
                      top: 100,
                    ),
                    child: Column(
                      children: [
                        MaterialButton(
                          onPressed: () {
                            pushPage(
                                context,
                                UpdateProfileScreen(
                                    user: state.userModel!, type: 1));
                          },
                          child: Row(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset("assets/icons/edit.svg"),
                                  const SizedBox(
                                    width: 18,
                                  ),
                                  Texts(
                                      title: "تعديل البيانات".tr(),
                                      family: AppFonts.taM,
                                      size: 12)
                                ],
                              ),
                            ],
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.all(30),
                          // decoration: BoxDecoration(
                          //   color: const Color(0xfffcfcfd),
                          //   borderRadius: BorderRadius.circular(15),
                          //   // border: Border.all(width: .6,color: Colors.grey),
                          //   boxShadow: const [
                          //     BoxShadow(
                          //       color: Color(0x269b9b9b),
                          //       offset: Offset(0, 0),
                          //       blurRadius: 50,
                          //     ),
                          //   ],
                          // ),
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Palette.mainColor, width: 2)),
                              child: CircleImageNetwork(
                                imageError: "assets/images/person.png",
                                image: ApiConstants.imageUrl(
                                    state.homeUserResponse!.user!.profileImage),
                                height: 76,
                                width: 76,
                                colorBackground: Palette.mainColor,
                              ),
                            ),
                            SizedBox(
                              height: 45,
                            ),
                            ContainerItemAccount(
                              onTap: () {
                                // pushPage(
                                //     context,
                                //     UpdateProfileScreen(
                                //         value: state.userModel!.fullName,
                                //         type: 0));
                              },
                              title: "الأسم  : ".tr(),
                              isPhone: true,
                              value: state.userModel!.fullName,
                              image: "assets/icons/account2.svg",
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ContainerItemAccount(
                              onTap: () {},
                              isPhone: true,
                              title: "رقم الهاتف  : ".tr(),
                              value: state.userModel!.userName,
                              image: "assets/icons/call2.svg",
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ContainerItemAccount(
                              onTap: () {},
                              title: "المدينة  : ".tr(),
                              value: state.userModel!.city,
                              isPhone: true,
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
                              shape:
                                  MaterialStateProperty.resolveWith((states) {
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
                                  "تسجيل الخروج".tr(),
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
                  )
                : LoginWidget();
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
  final bool isPhone;

  const ContainerItemAccount(
      {super.key,
      required this.image,
      required this.title,
      required this.value,
      required this.onTap,
      this.isPhone = false});

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
        isPhone
            ? SizedBox()
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Texts(
                    title: "تعديل",
                    family: AppFonts.caSi,
                    size: 12,
                    textColor: Colors.red,
                  ),
                  SvgPicture.asset(
                    "assets/icons/edit2.svg",
                    color: Colors.red,
                  )
                ],
              )
      ],
    );
  }
}
