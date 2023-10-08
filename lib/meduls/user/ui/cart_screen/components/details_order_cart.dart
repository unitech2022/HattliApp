import 'package:easy_localization/easy_localization.dart';
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

class OrderDetailsCart extends StatefulWidget {
  final List<CartDetails> carts;
  final double total;
  OrderDetailsCart({super.key, required this.carts, required this.total});

  @override
  State<OrderDetailsCart> createState() => _OrderDetailsCartState();
}

class _OrderDetailsCartState extends State<OrderDetailsCart> {
  final scaffoldkey = GlobalKey<ScaffoldState>();
 final _controllerDesc = TextEditingController();

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
        _controllerDesc.dispose();
  }

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
        title:  Texts(
            title: "تفاصيل الطلب".tr(),
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
                      columns:   [
                        DataColumn(
                          label: Texts(
                            title: "الصنف".tr(),
                            family: AppFonts.taB,
                            size: 12,
                            textColor: Color(0xff343434),
                          ),
                        ),
                        DataColumn(
                            label: Texts(
                          title: "الكمية".tr(),
                          family: AppFonts.taB,
                          size: 12,
                          textColor: Color(0xff343434),
                        )),
                        DataColumn(
                            label: Texts(
                                title: "السعر".tr(),
                                family: AppFonts.taB,
                                size: 12,
                                textColor: Color(0xff343434))),
                        DataColumn(
                            label: Texts(
                                title: "اجمالي".tr(),
                                family: AppFonts.taB,
                                size: 12,
                                textColor: Color(0xff343434))),
                      ],
                      rows: widget.carts.map((e) =>   DataRow(cells: [
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
                              title: "${e.cart.cost} SAR",
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
                  total :widget.total + 2
                )
                //** ========== */
              ]),
            ),
            const SizedBox(
              height: 17,
            ),
            //** button cancel  Order*/
             

                  //*** desc
                  Container(
                    padding: const EdgeInsets.only(
                        right: 25, left: 18, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xfffefefe),
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                          width: 1.0, color: const Color(0xfff6f6f7)),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0f000000),
                          offset: Offset(1, 1),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _controllerDesc,
                      keyboardType: TextInputType.multiline,
                      style: const TextStyle(
                          fontFamily: AppFonts.taM,
                          fontSize: 14,
                          color: Colors.black),
                      maxLines: 8,
                      decoration:  InputDecoration(
                        hintText: "ضع تعليق".tr(),
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontFamily: AppFonts.caM,
                            fontSize: 14,
                            color: Color(0xff1D1D1D)),
                      ),
                    ),
                  ),
               

 const SizedBox(
              height: 37,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                title: "تأكيد الطلب".tr(),
                onPressed: () {
                 pushPage(context,  PaymentScreen(total:widget.total,note:_controllerDesc.text.isNotEmpty?_controllerDesc.text:"not"));
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
