import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hatlli/core/helpers/helper_functions.dart';
import 'package:hatlli/core/router/routes.dart';
import 'package:hatlli/core/widgets/custom_button.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomButton(
              title: "تسجيل الدخول".tr(),
              onPressed: (() {
                pushPageRoutName(context, selectAccount);
              })),
        ));
  }
}
