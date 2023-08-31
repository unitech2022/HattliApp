import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../core/layout/app_fonts.dart';
import '../../../../../core/widgets/texts.dart';

class ContainerTotalWidget extends StatelessWidget {
  final int countProduct;
  final double total;
  const ContainerTotalWidget({
    super.key, required this.countProduct, required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.all(20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19.0),
        border: Border.all(width: 1.0, color: const Color(0xffe9e9ec)),
      ),
      child:  Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Texts(
              title: "المنتجات".tr() + " : ",
              family: AppFonts.caR,
              size: 13,
              textColor: Color(0xff2D2E49),
            ),
            Texts(
              title: countProduct.toString(),
              family: AppFonts.caR,
              size: 13,
              textColor: const Color(0xff2D2E49),
            ),
          ],
        ),
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Texts(
              title: "اجمالي".tr() +" : ",
              family: AppFonts.caB,
              size: 15,
              textColor: Color(0xff2D2E49),
            ),
            Texts(
              title: "$total SAR",
              family: AppFonts.caR,
              size: 13,
              textColor: Color(0xff2D2E49),
            ),
          ],
        )
      ]),
    );
  }
}
