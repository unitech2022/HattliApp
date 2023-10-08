import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/layout/app_fonts.dart';
import '../../../../core/layout/palette.dart';
import '../../../../core/styles/style_widget.dart';

class ContainerSearchWidget extends StatefulWidget {
  final String text;
  final void Function(String value) onTap;
  const ContainerSearchWidget({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  State<ContainerSearchWidget> createState() => _ContainerSearchWidgetState();
}

class _ContainerSearchWidgetState extends State<ContainerSearchWidget> {
  final _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.text = widget.text;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: decoration(color: Colors.white, 10),
        child: Row(children: [
          Expanded(
            child: TextField(
                style: const TextStyle(
                  fontFamily: AppFonts.taM,
                  fontSize: 14,
                  color: Color(0xff343434),
                  fontWeight: FontWeight.w500,
                ),
                textInputAction: TextInputAction.search,
                controller: _controller,
                onSubmitted: (value) {
                  widget.onTap(_controller.text);
                  // if (_controller.text.isNotEmpty) {
                  //   pushPage(context,
                  //       SearchProductsScreen(textSearch: _controller.text));
                  // }
                },
                decoration:  InputDecoration(
                  border: InputBorder.none,
                  hintText: "البحث".tr(),
                  hintStyle: TextStyle(
                    fontFamily: AppFonts.taM,
                    fontSize: 14,
                    color: Color(0xff343434),
                    fontWeight: FontWeight.w500,
                  ),
                )),
          ),
          GestureDetector(
            onTap: () {

              widget.onTap(_controller.text);
            },
            child: Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                color: Palette.mainColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: SvgPicture.asset("assets/icons/search.svg"),
              ),
            ),
          )
        ]));
  
  
  }
}
