import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hatlli/core/layout/palette.dart';
import 'package:hatlli/core/utils/app_model.dart';

import '../../../../../core/layout/app_fonts.dart';
import '../../../../../core/widgets/texts.dart';

class DetailsOrderWidget extends StatelessWidget {
  final int type;
  final double total;
  final int status;
  const DetailsOrderWidget({
    super.key,
    this.type = 0,
    this.status=0,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          ContainerDetails(
            title: "اجمالي",
            value: total.toString(),
          ),
          const ContainerDetails(
            title: "الضريبة",
            value: "3%",
          ),
          const ContainerDetails(
            title: "خصم",
            value: "3%",
          ),
          ContainerDetails(
            title: "اجمالي بعد الخصم",
            value: total.toString(),
          ),
          type == 1
              ? const SizedBox()
              : Container(
                  height: 40,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Texts(
                          title: "حالة الطلب  : ",
                          family: AppFonts.taB,
                          size: 12),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 12,
                            width: 12,
                            decoration:  BoxDecoration(
                              color:status==4?Colors.red: Color(0xffffa827),
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                           Texts(
                            title: orderStatus[status],
                            family: AppFonts.taM,
                            size: 12,
                            textColor:status==4?Colors.red: Palette.mainColor,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
          const SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }
}

class ContainerDetails extends StatelessWidget {
  final String title, value;

  const ContainerDetails({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: .5, color: Color.fromARGB(255, 194, 193, 193)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Texts(title: title, family: AppFonts.taB, size: 12),
          Texts(title: value, family: AppFonts.taM, size: 12)
        ],
      ),
    );
  }
}
