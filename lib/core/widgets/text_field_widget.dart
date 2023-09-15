import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../layout/app_fonts.dart';

class TextFieldWidget extends StatelessWidget {
  final String hint;
  final Widget icon;
  final TextEditingController controller;
  final TextInputType type;
  final String family;
  final bool display;
  final int maxLength;
  final bool enable, isPhone;

  const TextFieldWidget(
      {super.key,
      required this.hint,
      required this.icon,
      required this.controller,
      required this.type,
      this.family = AppFonts.taM,
      this.enable = true,
       this.display = false,
      this.isPhone = false,
      this.maxLength = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: 55,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: const Color(0xfffefefe),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(width: 1.0, color: const Color(0xfff6f6f7)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0f000000),
            offset: Offset(1, 1),
            blurRadius: 6,
          ),
        ],
      ),
      child: TextField(
        enabled: enable,
        
        controller: controller,
        keyboardType: type,
        maxLength: maxLength == 0 ? null : maxLength,
        textAlign: TextAlign.start,
        style: const TextStyle(
            fontFamily: AppFonts.taM, fontSize: 14, color: Colors.black),
            obscureText: display,
        decoration: InputDecoration(
          
          isDense: false,
          fillColor: Colors.red,
          icon: isPhone ? SizedBox() : icon,
          suffixIcon: isPhone ? icon : SizedBox(),
          hintText: hint,
          counterText: "",
          border: InputBorder.none,
          hintStyle: TextStyle(
              fontFamily: family,
              fontSize: 14,
              color: Color(0xff1D1D1D),
              height: 1.6),
        ),
      ),
    );
  }
}
