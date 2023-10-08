import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatlli/core/layout/app_fonts.dart';
import 'package:hatlli/core/utils/strings.dart';
import 'package:hatlli/core/widgets/custom_button.dart';
import 'package:hatlli/core/widgets/text_field_widget.dart';
import 'package:hatlli/core/widgets/texts.dart';
import 'package:hatlli/meduls/provider/bloc/provider_cubit/provider_cubit.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

import '../../../../core/helpers/helper_functions.dart';

class ChangePhoneProviderScreen extends StatefulWidget {
  const ChangePhoneProviderScreen({super.key});

  @override
  State<ChangePhoneProviderScreen> createState() =>
      _ChangePhoneProviderScreenState();
}

class _ChangePhoneProviderScreenState extends State<ChangePhoneProviderScreen> {
  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerEmail.dispose();
    _controllerPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProviderCubit, ProviderState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: true,
            title: Texts(
                title: "تغيير رقم الهاتف".tr(), family: AppFonts.caM, size: 14),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                const SizedBox(
                  height: 75,
                ),
                TextFieldWidget(
                  controller: _controllerEmail,
                  hint: "إيميل الشركة".tr(),
                  icon: const SizedBox(),
                  type: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFieldWidget(
                  controller: _controllerPassword,
                  isPhone: true,
                  display: state.isDisplay,
                  hint: "الرقم السرى".tr(),
                  icon: InkWell(
                      onTap: () {
                        bool display = !state.isDisplay;
                        ProviderCubit.get(context).viewPassword(display);
                      },
                      child: state.isDisplay
                          ? Icon(Icons.visibility_off)
                          : Icon(Icons.visibility)),
                  type: TextInputType.text,
                ),
                const SizedBox(
                  height: 55,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomButton(
                      title: Strings.send,
                      onPressed: () {
                        if (isValidate(context, state)) {
                          ProviderCubit.get(context).changePhoneProvider(
                              context: context,
                              email: _controllerEmail.text.trim(),
                              password: _controllerPassword.text.trim());
                        }
                      }),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool isValidate(BuildContext context, ProviderState state) {
    if (_controllerEmail.text.isEmpty || _controllerEmail.text == "") {
      showTopMessage(
          context: context,
          customBar: CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: "اكتب ايميل الشركة".tr(),
            textStyle: TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));
      return false;
    } else if (_controllerPassword.text.isEmpty ||
        _controllerPassword.text == "") {
      showTopMessage(
          context: context,
          customBar: CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: "اكتب الرقم السرى ".tr(),
            textStyle: TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));
      return false;
    } else {
      return true;
    }
  }
}
