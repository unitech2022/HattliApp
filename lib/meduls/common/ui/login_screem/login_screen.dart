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

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
                        const Texts(
                            title: Strings.login,
                            family: AppFonts.taB,
                            size: 20,
                            textColor: Colors.black,
                            widget: FontWeight.w700),
                        const SizedBox(
                          height: 15,
                        ),
                        const Texts(
                            title: Strings.sendCode,
                            family: AppFonts.taM,
                            size: 14,
                            textColor: Color(0xff44494E),
                            widget: FontWeight.normal),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFieldWidget(
                          controller: _controller,
                          hint: Strings.number,
                          maxLength: 9,
                          icon: SvgPicture.asset(
                            AppAssets.callIcon,
                            color: Colors.black,
                          ),
                          type: TextInputType.number,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: CustomButton(
                              title: Strings.theLogin,
                              onPressed: () {
                                if (_controller.text.isEmpty||_controller.text.length < 9) {
                                  showTopMessage(
                                      context: context,
                                      customBar: const CustomSnackBar.error(
                                        backgroundColor: Colors.red,
                                        message: "من فضلك أدخل رقم الهاتف",
                                        textStyle: TextStyle(
                                            fontFamily: "font",
                                            fontSize: 16,
                                            color: Colors.white),
                                      ));
                                } else {
                                  AuthCubit.get(context).checkUserName(
                                      context: context,
                                      userName: "+996${_controller.text.trim()}");
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
