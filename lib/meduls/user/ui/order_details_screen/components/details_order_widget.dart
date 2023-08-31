import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
            title: "اجمالي".tr(),
            value: total.toString(),
          ),
           ContainerDetails(
            title: "قيمة التوصيل".tr(),
            value: " 2 " + "ريال".tr(),
          ),
           ContainerDetails(
            title: "خصم".tr(),
            value: "0",
          ),
          ContainerDetails(
            title: "اجمالي بعد الخصم".tr(),
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
                       Texts(
                          title: "حالة الطلب  : ".tr(),
                          family: AppFonts.taB,
                          size: 12),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 12,
                            width: 12,
                            decoration:  BoxDecoration(
                              color:orderStatusColors[status],
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                           Texts(
                            title: orderStatus[status].tr(),
                            family: AppFonts.taM,
                            size: 12,
                            textColor:orderStatusColors[status],
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
