import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatlli/core/helpers/helper_functions.dart';
import 'package:hatlli/meduls/common/bloc/auth_cubit/auth_cubit.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import '../../../../core/layout/app_assets.dart';
import '../../../../core/layout/app_fonts.dart';
import '../../../../core/utils/strings.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/text_field_widget.dart';
import '../../../../core/widgets/texts.dart';
import 'dart:ui' as ui;
class LoginScreen extends StatefulWidget {
  final String role;
  LoginScreen({required this.role});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffFCFCFD),
        body: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 43,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: IconButton(
                          onPressed: () {
                            pop(context);
                          },
                          icon: const Icon(Icons.arrow_back)),
                    ),
                  ],
                ),
                Image.asset(AppAssets.logoBlack),
                const SizedBox(
                  height: 58,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Card(
                    elevation: 0,
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
                        top: 35,
                        left: 40,
                        right: 40,
                      ),
                      width: double.infinity,
                      child: Column(children: [
                         Texts(
                            title: Strings.login.tr(),
                            family: AppFonts.taB,
                            size: 20,
                            textColor: Colors.black,
                            widget: FontWeight.w700),
                        const SizedBox(
                          height: 15,
                        ),
                         Texts(
                            title: Strings.sendCode.tr(),
                            family: AppFonts.taM,
                            size: 14,
                            textColor: Color(0xff44494E),
                            widget: FontWeight.normal),
                        const SizedBox(
                          height: 20,
                        ),
                        Directionality(

                          textDirection: ui.TextDirection.ltr,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                                sizedWidth(8),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset("assets/images/flag.png",fit: BoxFit.cover,width: 25,height: 25,)),
                            sizedWidth(4),
                             Texts(
                                title: Strings.codeNumber,
                                textColor: Color(0xff464646),
                                size: 14,
                                widget: FontWeight.bold,
                                algin: TextAlign.center, family: AppFonts.taB,),
                                 sizedWidth(8),
                              Expanded(
                                child: TextFieldWidget(
                                  controller: _controller,
                                  hint: Strings.number.tr(),
                                  isPhone: true,
                                  maxLength: 9,
                                  icon: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                                    child: SvgPicture.asset(
                                    
                                      AppAssets.callIcon,
                                      color: Colors.black,
                                    ),
                                  ),
                                  type: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: CustomButton(
                              title: Strings.theLogin.tr(),
                              onPressed: () {
                                if (_controller.text.isEmpty ) {
                                  showTopMessage(
                                      context: context,
                                      customBar:  CustomSnackBar.error(
                                        backgroundColor: Colors.red,
                                        message: "من فضلك أدخل رقم الهاتف".tr(),
                                        textStyle: TextStyle(
                                            fontFamily: "font",
                                            fontSize: 16,
                                            color: Colors.white),
                                      ));
                                } else {
                                  AuthCubit.get(context).checkUserName(
                                      context: context,
                                      role: widget.role,
                                      userName:
                                          "966${_controller.text.trim()}");
                                }
                              }),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                      ]),
                    ),
                  ),
                ))
              ],
            );
          },
        ));
  }
}
