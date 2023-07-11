import 'package:flutter/cupertino.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

import 'package:hatlli/core/widgets/icon_alert_widget.dart';
import '../../../../core/layout/app_fonts.dart';
import '../../../../core/widgets/texts.dart';

class AppBarWidget extends StatelessWidget {
  final String title;
  final Widget loading;
  const AppBarWidget({
    super.key, required this.title, required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
            loading,
              const SizedBox(
                width: 18,
              ),
               Texts(
                  title:title,
                  family: AppFonts.taB,
                  size: 18,
                  widget: FontWeight.bold),
            ],
          ),
       IconAlertWidget(t: 0,l: 0,) ],
      ),
    );
  }
}
