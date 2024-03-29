import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatlli/core/helpers/helper_functions.dart';
import 'package:hatlli/core/utils/api_constatns.dart';
import 'package:hatlli/core/utils/app_model.dart';
import 'package:hatlli/core/widgets/empty_list_widget.dart';
import 'package:hatlli/meduls/common/models/order.dart';
import '../../../../../core/layout/app_fonts.dart';
import '../../../../../core/layout/palette.dart';
import '../../../../../core/widgets/texts.dart';
import '../../order_details_screen/order_details_screen.dart';

class ListOrdersWidget extends StatelessWidget {
  final List<OrderResponse> list;
  const ListOrdersWidget({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: list.isEmpty
            ?  EmptyListWidget(message: "لا توجد طلبات ".tr())
            : ListView.builder(
                padding: const EdgeInsets.only(top: 45, left: 4, right: 4),
                itemCount: list.length,
                itemBuilder: (ctx, index) {
                  OrderResponse orderResponse = list[index];
                  return GestureDetector(
                    onTap: () {
                      pushPage(context,
                          OrderDetailsScreen(id: orderResponse.order.id));
                    },
                    child: Container(
                        margin: const EdgeInsets.only(bottom: 13),
                        padding: const EdgeInsets.all(8),
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
                        height: 140,
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: DataTable(
                                  headingRowHeight: 45,
                                  horizontalMargin: 0,
                                  columnSpacing: 10,
                                  columns:  [
                                    DataColumn(
                                      label: Texts(
                                        title: "الطلب : ".tr(),
                                        family: AppFonts.taB,
                                        size: 12,
                                        textColor: Color(0xff343434),
                                      ),
                                    ),
                                    DataColumn(
                                        label: Texts(
                                      title: "وقت الطلب".tr(),
                                      family: AppFonts.taB,
                                      size: 12,
                                      textColor: Color(0xff343434),
                                    )),
                                    DataColumn(
                                        label: Texts(
                                            title: "اجمالي".tr(),
                                            family: AppFonts.taB,
                                            size: 12,
                                            textColor: Color(0xff343434))),
                                  ],
                                  rows: [
                                    DataRow(cells: [
                                      DataCell(Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(50),
                                            child: CachedNetworkImage(
                                              imageUrl: ApiConstants.imageUrl(
                                                  orderResponse.imageUrl),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Image.asset(
                                                "assets/images/provider.png",
                                                height: 28,
                                                width: 28,
                                                fit: BoxFit.fill,
                                              ),
                                              height: 28,
                                              width: 28,
                                               fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Texts(
                                              title: orderResponse.name,
                                              family: AppFonts.taM,
                                              size: 13,
                                              textColor: Color(0xff343434))
                                        ],
                                      )),
                                      DataCell(Texts(
                                          title: orderResponse.order.createdAt
                                              .split("T")[0],
                                          family: AppFonts.taM,
                                          size: 13,
                                          textColor: Color(0xff343434))),
                                      DataCell(Texts(
                                          title:
                                              "${orderResponse.order.totalCost} SAR",
                                          family: AppFonts.taM,
                                          size: 13,
                                          textColor: Color(0xff343434))),
                                    ])
                                  ]),
                            ),
                            const Divider(
                              height: .8,
                            ),
                            // ignore: prefer_const_constructors
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SvgPicture.asset("assets/icons/edit.svg"),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                     Texts(
                                      title: "تفاصيل الطلب".tr(),
                                      family: AppFonts.taM,
                                      size: 12,
                                      textColor: Palette.mainColor,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      height: 12,
                                      width: 12,
                                      decoration:  BoxDecoration(
                                        color: orderStatusColors[ orderResponse.order.status],
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Texts(
                                      title: orderStatus[
                                          orderResponse.order.status].tr(),
                                      family: AppFonts.taM,
                                      size: 12,
                                      textColor: orderStatusColors[ orderResponse.order.status],
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        )),
                  );
                }));
  }
}
