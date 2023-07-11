import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatlli/meduls/common/models/order_response.dart';

import '../../../../../core/layout/app_fonts.dart';
import '../../../../../core/utils/app_model.dart';
import '../../../../../core/widgets/texts.dart';

class TableOrderDetailsWidget extends StatelessWidget {
  final List<ProductOrder> list;
  const TableOrderDetailsWidget({
    super.key,
    required this.list,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: DataTable(
          headingRowHeight: 45,
          horizontalMargin: 0,
          columnSpacing: 10,
          columns: const [
            DataColumn(
              label: Texts(
                title: "الصنف",
                family: AppFonts.taB,
                size: 12,
                textColor: Color(0xff343434),
              ),
            ),
            DataColumn(
                label: Texts(
              title: "الكمية",
              family: AppFonts.taB,
              size: 12,
              textColor: Color(0xff343434),
            )),
            DataColumn(
                label: Texts(
                    title: "السعر",
                    family: AppFonts.taB,
                    size: 12,
                    textColor: Color(0xff343434))),
            DataColumn(
                label: Texts(
                    title: "اجمالي",
                    family: AppFonts.taB,
                    size: 12,
                    textColor: Color(0xff343434))),
            DataColumn(label: SizedBox()),
          ],
          rows: list.map((e) =>
             DataRow(cells: [
               DataCell(Texts(
                  title: e.product!.name,
                  family: AppFonts.taM,
                  size: 13,
                  textColor: Color(0xff343434))),
               DataCell(Texts(
                  title: e.order!.quantity.toString(),
                  family: AppFonts.taM,
                  size: 13,
                  textColor: Color(0xff343434))),
               DataCell(Texts(
                  title: e.product!.price.toString(),
                  family: AppFonts.taM,
                  size: 13,
                  textColor: Color(0xff343434))),
               DataCell(Texts(
                  title: e.order!.cost.toString(),
                  family: AppFonts.taM,
                  size: 13,
                  textColor: Color(0xff343434))),
              DataCell(
              currentUser.role==  AppModel.userRole?  Row(
                children: [
                  SvgPicture.asset("assets/icons/edit.svg"),
                  const SizedBox(
                    width: 4,
                  ),
                  SvgPicture.asset("assets/icons/delete.svg")
                ],
              ):const SizedBox()),
            ])
         
          
          
          ).toList()),
    );
  }
}
