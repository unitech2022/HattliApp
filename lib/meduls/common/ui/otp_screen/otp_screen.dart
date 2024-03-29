import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatlli/meduls/common/bloc/auth_cubit/auth_cubit.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/layout/app_assets.dart';
import '../../../../core/layout/app_fonts.dart';
import '../../../../core/utils/app_model.dart';
import '../../../../core/utils/strings.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/texts.dart';
import 'dart:ui' as ui;

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  final String codeSend;

  OtpScreen({required this.phoneNumber, required this.codeSend});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String code = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AuthCubit.get(context).startTimer();
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
                    child: Container(
                  margin: const EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(44.0),
                    topRight: Radius.circular(44.0),
                  )),
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.only(
                        top: 35,
                        left: 40,
                        right: 40,
                      ),
                      width: double.infinity,
                      child: Column(children: [
                        Texts(
                            title: Strings.verCode.tr(),
                            family: AppFonts.taB,
                            size: 20,
                            textColor: Colors.black,
                            widget: FontWeight.w700),
                        const SizedBox(
                          height: 15,
                        ),
                        Texts(
                            title: Strings.verCodeDesc.tr(),
                            family: AppFonts.taM,
                            size: 14,
                            textColor: Color(0xff44494E),
                            widget: FontWeight.normal),
                        const SizedBox(
                          height: 20,
                        ),
                        Directionality(
                          textDirection: ui.TextDirection.ltr,
                          child: PinCodeTextField(
                            appContext: context,
                            pastedTextStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 40,
                              fontWeight: FontWeight.normal,
                            ),
                            length: 4,
                            obscureText: false,
                            obscuringCharacter: '*',
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 40,
                              fontWeight: FontWeight.normal,
                            ),
                            blinkWhenObscuring: true,
                            boxShadows: const [
                              BoxShadow(
                                offset: Offset(0, 0),
                                blurRadius: 3,
                                spreadRadius: 3,
                                color: Color.fromARGB(25, 0, 0, 0),
                              ),
                            ],
                            animationType: AnimationType.fade,
                            pinTheme: PinTheme(
                              fieldOuterPadding: const EdgeInsets.only(left: 2),
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(4),
                              fieldHeight: 78,
                              fieldWidth: 55,
                              borderWidth: 0,
                              inactiveColor: Colors.white,
                              inactiveFillColor: Colors.white,
                              selectedFillColor: const Color(0xFFE2E2E2),
                              activeFillColor: Colors.white,
                            ),
                            cursorColor: Colors.black,
                            animationDuration:
                                const Duration(milliseconds: 300),
                            backgroundColor: Colors.white,
                            enableActiveFill: true,
                            keyboardType: TextInputType.number,
                            onCompleted: (v) {
                              code = v;
                            },
                            onChanged: (value) {},
                            beforeTextPaste: (text) {
                              return true;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextButton(
                                onPressed: () {
                                  // ** resent code
                                  if (state.timerCount == 0) {
                                    AuthCubit.get(context).resendCode(
                                        code: widget.codeSend,
                                        userName: widget.phoneNumber,
                                        context: context);
                                  }
                                },
                                child: Texts(
                                    title: Strings.reSend.tr(),
                                    family: AppFonts.taB,
                                    size: 14,
                                    textColor: state.timerCount > 0
                                        ? Colors.grey
                                        : Color(0xff292626),
                                    widget: FontWeight.bold)),
                            SizedBox(
                              height: 5,
                            ),
                            state.timerCount != 0
                                ? Texts(
                                    title: state.timerCount.toString(),
                                    family: AppFonts.taB,
                                    textColor: Colors.red,
                                    size: 20,
                                  )
                                : SizedBox(),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: CustomButton(
                              title: "تحقق".tr(),
                              onPressed: () {
                                if (code != widget.codeSend && code != "0000") {
                                  showTopMessage(
                                      context: context,
                                      customBar: const CustomSnackBar.error(
                                        backgroundColor: Colors.red,
                                        message: "الكود غير صحيح",
                                        textStyle: TextStyle(
                                            fontFamily: "font",
                                            fontSize: 16,
                                            color: Colors.white),
                                      ));
                                } else if (state.roleUser == 0) {
                                  AuthCubit.get(context).userLogin(
                                      context: context,
                                      role: AppModel.userRole,
                                      code: code,
                                      userName: widget.phoneNumber);
                                } else {
                                  AuthCubit.get(context).userLogin(
                                      code: code,
                                      context: context,
                                      role: AppModel.providerRole,
                                      userName: widget.phoneNumber);
                                }
                              }),
                        ),
                        const SizedBox(
                          height: 20,
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
