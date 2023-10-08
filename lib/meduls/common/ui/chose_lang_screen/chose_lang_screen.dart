import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hatlli/core/layout/app_fonts.dart';
import 'package:hatlli/core/layout/palette.dart';
import 'package:hatlli/core/router/routes.dart';
import 'package:hatlli/core/widgets/custom_button.dart';

import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/widgets/texts.dart';
import '../../bloc/app_cubit/app_cubit.dart';

class ChoseLangScreen extends StatefulWidget {
  const ChoseLangScreen({super.key});

  @override
  State<ChoseLangScreen> createState() => _ChoseLangScreenState();
}

class _ChoseLangScreenState extends State<ChoseLangScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Palette.mainColor,
          body: Container(
            alignment: Alignment.center,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    height: 150,
                    width: 150,
                    child: Image.asset(
                      "assets/images/logo_white.png",
                      height: 150,
                      width: 150,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Texts(
                        title: "اختار اللغة".tr(),
                        textColor: Colors.white,
                        family: AppFonts.taB,
                        widget: FontWeight.bold,
                        size: 20,
                      ),
                      sizedHeight(25),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: CustomButton(
                          elevation: 10,
                          titleColor: Palette.mainColor,
                          backgroundColor: Colors.white,
                          onPressed: () {
                            context.setLocale(Locale('ar'));

                            AppCubit.get(context).changeLang("ar", context);
                            pushPageRoutName(context, selectAccount);
                          },
                          title: 'اللغة العربية',
                        ),
                      ),
                      sizedHeight(20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: CustomButton(
                          elevation: 10,
                          titleColor: Colors.white,
                          backgroundColor: Palette.mainColor,
                          onPressed: () {
                            context.setLocale(Locale('en'));

                            AppCubit.get(context).changeLang("en", context);
                              pushPageRoutName(context, selectAccount);
                          },
                          title: "English",
                        ),
                      ),
                      sizedHeight(50),
                    ]),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
