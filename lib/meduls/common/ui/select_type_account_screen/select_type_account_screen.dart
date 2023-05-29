import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatlli/core/helpers/helper_functions.dart';
import 'package:hatlli/core/layout/app_fonts.dart';
import 'package:hatlli/core/layout/palette.dart';
import 'package:hatlli/core/router/routes.dart';
import 'package:hatlli/core/widgets/custom_button.dart';
import 'package:hatlli/core/widgets/texts.dart';

import '../../../../core/layout/app_assets.dart';
import '../../../../core/utils/strings.dart';
import '../login_screem/login_screen.dart';

class SelectTypeAccountScreen extends StatelessWidget {
  const SelectTypeAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffFCFCFD),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 54,
            ),
            Image.asset(AppAssets.logoBlack),
            const SizedBox(
              height: 43,
            ),
            Expanded(
                child: Card(
              elevation: 25,
              margin: const EdgeInsets.only(top: 15),
              shape: const RoundedRectangleBorder(
                side: BorderSide(color: Colors.white70, width: 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(44.0),
                  topRight: Radius.circular(44.0),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.only(
                  top: 31,
                  left: 22,
                  right: 22,
                ),
                width: double.infinity,
                child: Column(children: [
                  const Texts(
                      title: Strings.selectAccountType,
                      family: AppFonts.taB,
                      size: 20,
                      textColor: Colors.black,
                      widget: FontWeight.w700),
                  const SizedBox(
                    height: 15,
                  ),
                  const Texts(
                      title: Strings.selectAccountTypedesc,
                      family: AppFonts.taM,
                      size: 14,
                      textColor: Color(0xff44494E),
                      widget: FontWeight.normal),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ContainerTypeAccount(
                        onTap: () {},
                        title: Strings.user,
                        image: AppAssets.imageUser,
                        cheked: true,
                      ),
                      ContainerTypeAccount(
                        onTap: () {},
                        title: Strings.provider,
                        image: AppAssets.imageProvider,
                        cheked: true,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 72,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: CustomButton(
                        title: Strings.next,
                        onPressed: () {
                          pushPageRoutName(context, login);
                        }),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Texts(
                      title: Strings.vistor,
                      family: AppFonts.taB,
                      size: 14,
                      textColor: Color(0xff292626),
                      widget: FontWeight.bold),
                ]),
              ),
            ))
          ],
        ));
  }
}

class ContainerTypeAccount extends StatelessWidget {
  final String title, image;
  final bool cheked;
  final void Function() onTap;

  const ContainerTypeAccount(
      {super.key,
      required this.title,
      required this.image,
      required this.onTap,
      required this.cheked});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 168,
          width: 155,
          // color: Colors.red,
          decoration: BoxDecoration(
            color: const Color(0xffffffff),
            borderRadius: BorderRadius.circular(18.0),
            boxShadow: const [
              BoxShadow(
                color: Color(0x52ebebeb),
                offset: Offset(2, 2),
                blurRadius: 10,
              ),
            ],
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Checkbox(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      fillColor: MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.selected)) {
                          return Palette
                              .mainColor; // the color when checkbox is selected;
                        }
                        return Colors
                            .white; //the color when checkbox is unselected;
                      }),
                      checkColor: Colors.white,
                      value: cheked,
                      onChanged: (vlue) {}),
                ),
              ),
              Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    image,
                    fit: BoxFit.cover,
                  )),
              Align(
                alignment: Alignment.bottomCenter,
                child: Texts(
                    title: title,
                    family: AppFonts.taB,
                    size: 14,
                    textColor: Color(0xff858585),
                    widget: FontWeight.normal),
              )
            ],
          )),
    );
  }
}
