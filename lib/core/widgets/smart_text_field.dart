import 'package:flutter/material.dart';
import 'package:hatlli/core/extension/theme_extension.dart';
import 'package:hatlli/core/layout/app_sizes.dart';

import '../layout/palette.dart';



@immutable
class RegularTextField extends StatelessWidget {
  const RegularTextField({
    super.key,
    this.label,
    this.onPressed,
    this.readOnly = false,
    this.hint,
    this.controller,
    this.validator,
  });

  final String? label;
  final String? hint;
  final GestureTapCallback? onPressed;
  final bool readOnly;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    var textStyle = const TextStyle(
      fontSize: 16,
      color: Palette.restaurantColor,
      fontWeight: FontWeight.bold,
    );
    return TextFormField(
      controller: controller,
      onTap: onPressed,
      readOnly: readOnly,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        label: hint != null
            ? null
            : Text(
                label!,
                style: textStyle,
              ),
        floatingLabelStyle: textStyle,
      ),
    );
  }
}

class SmartTextField extends StatelessWidget {
  const SmartTextField({
    Key? key,
    required this.outlineInputBorder,
  }) : super(key: key);

  final OutlineInputBorder outlineInputBorder;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textDirection: TextDirection.ltr,
      keyboardType: TextInputType.number,
      style: const TextStyle(
        height: 1.2,
        fontFamily: "",
      ),
      decoration: InputDecoration(
        border: outlineInputBorder,
        errorBorder: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        disabledBorder: outlineInputBorder,
        focusedErrorBorder: outlineInputBorder,
        fillColor: Palette.white,
        filled: true,
        isDense: true,
        hintStyle: const TextStyle(
          height: 1.2,
          fontFamily: "",
        ),
        hintTextDirection: TextDirection.ltr,
        suffixIcon: const CountryCodeWidget(),
      ),
    );
  }
}

class CountryCodeWidget extends StatelessWidget {
  const CountryCodeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      widthFactor: 0.5,
      child: Container(
        // color: Colors.red,
        padding: const EdgeInsetsDirectional.only(end: AppSize.s10),
        // width: 50,
        child: Text(
          "+966",
          textDirection: TextDirection.ltr,
          style: context.titleL.copyWith(
            color: Palette.restaurantColor,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
