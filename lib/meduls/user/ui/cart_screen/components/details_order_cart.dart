import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hatlli/meduls/user/models/cart_response.dart';
import 'package:hatlli/meduls/user/ui/payment_screen/payment_screen.dart';
import '../../../../../core/helpers/helper_functions.dart';
import '../../../../../core/layout/app_fonts.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/icon_alert_widget.dart';
import '../../../../../core/widgets/texts.dart';
import '../../order_details_screen/components/details_order_widget.dart';

class OrderDetailsCart extends StatelessWidget {
  final List<CartDetails> carts;
  final double total;
  OrderDetailsCart({super.key, required this.carts, required this.total});
  final scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: const Texts(
            title: "تفاصيل الطلب",
            family: AppFonts.taB,
            size: 18,
            widget: FontWeight.bold),
        actions: [
         IconAlertWidget(),
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(
              height: 52,
            ),

            //* ===============
            // ** stuper

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x269b9b9b),
                    offset: Offset(0, 0),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Column(children: [
                //* table
                SizedBox(
                  width: double.infinity,
                  child: DataTable(
                      headingRowHeight: 45,
                      horizontalMargin: 0,
                      columnSpacing: 10,
                      columns:  const [
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
                      ],
                      rows: carts.map((e) =>   DataRow(cells: [
                          DataCell(Texts(
                              title:e.product.name,
                              family: AppFonts.taM,
                              size: 13,
                              textColor: Color(0xff343434))),
                          DataCell(Texts(
                              title: e.cart.quantity.toString(),
                              family: AppFonts.taM,
                              size: 13,
                              textColor: Color(0xff343434))),
                          DataCell(Texts(
                              title: "${e.product.price} SAR",
                              family: AppFonts.taM,
                              size: 13,
                              textColor: Color(0xff343434))),
                          DataCell(Texts(
                              title: "${e.cart.cost}SAR",
                              family: AppFonts.taM,
                              size: 13,
                              textColor: Color(0xff343434))),
                        ])
                    ).toList()),
                ),

                //* =========
                const Divider(
                  height: .8,
                ),
                const SizedBox(
                  height: 47,
                ),
                //** order Details */
                 DetailsOrderWidget(
                  type: 1,
                  total :total
                )
                //** ========== */
              ]),
            ),
            const SizedBox(
              height: 37,
            ),
            //** button cancel  Order*/

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                title: "تأكيد الطلب",
                onPressed: () {
                 pushPage(context, const PaymentScreen());
                },
                backgroundColor: Colors.black,
              ),
            )
          ],
        ),
      )),
    );
  }
}
