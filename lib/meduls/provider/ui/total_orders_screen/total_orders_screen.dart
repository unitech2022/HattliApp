import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatlli/core/enums/loading_status.dart';
import 'package:hatlli/core/helpers/helper_functions.dart';
import 'package:hatlli/core/layout/app_fonts.dart';
import 'package:hatlli/core/layout/palette.dart';
import 'package:hatlli/core/utils/app_model.dart';
import 'package:hatlli/core/widgets/circular_progress.dart';
import 'package:hatlli/core/widgets/empty_list_widget.dart';
import 'package:hatlli/meduls/common/models/order.dart';
import 'package:hatlli/meduls/provider/bloc/statist_cubit/statist_cubit.dart';
import 'package:hatlli/meduls/user/ui/components/app_bar_widget.dart';
import 'package:hatlli/meduls/user/ui/order_details_screen/order_details_screen.dart';

import '../../../../core/widgets/back_button.dart';
import '../../../../core/widgets/texts.dart';
import '../../../user/ui/details_provider_screen/details_provider_screen.dart';

class TotalOrdersScreen extends StatefulWidget {
  final int providerId;
  const TotalOrdersScreen({required this.providerId});

  @override
  State<TotalOrdersScreen> createState() => _TotalOrdersScreenState();
}

class _TotalOrdersScreenState extends State<TotalOrdersScreen> {

  
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    StatistCubit.get(context).getAllOrders(providerId: widget.providerId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StatistCubit, StatistState>(
      builder: (context, state) {
        return Scaffold(
          body:state.getAllOrdersState==RequestState.loaded? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                //** app bar */
                AppBarWidget(
                  loading: BackButtonWidget(),
                  title: "اجمالي الطلبات".tr(),
                ),
                const SizedBox(
                  height: 28,
                ),
                //** =========== */
                //** tab Widget  */
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TabContainerProvider(
                       fonSize: 14,
                      height: 35,
                      width: 140,
                      title: "الطلبات المقبولة".tr(),
                      textColor: state.currentIndexTap == 0
                          ? Palette.white
                          : const Color(0xffBBBBBB),
                      backgroundColor: state.currentIndexTap == 0
                          ? Palette.mainColor
                          : Colors.white,
                      onTap: () {
                        StatistCubit.get(context)
                            .changeCurrentIndexNav(0);
                      },
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    TabContainerProvider(
                      title: "الطلبات الملغية".tr(),
                      fonSize: 14,
                      height: 35,
                      width: 130,
                      textColor: state.currentIndexTap == 1
                          ? Palette.white
                          : const Color(0xffBBBBBB),
                      backgroundColor: state.currentIndexTap == 1
                          ? Palette.mainColor
                          : Colors.white,
                      onTap: () {
                         StatistCubit.get(context)
                            .changeCurrentIndexNav(1);
                      },
                    )
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Expanded(
                  child:ListAllOrdersWidget(list: state.currentIndexTap==0? state.allOrders!.successOrders:state.allOrders!.unsuccessfulOrders,))
              ],
            ),
          )
       :CustomCircularProgress(fullScreen: true,strokeWidth: 3,) );
      },
    );
  }
}

class ListAllOrdersWidget extends StatelessWidget {
  final List<Order> list;
  const ListAllOrdersWidget({required this.list});

  @override
  Widget build(BuildContext context) {
    return list.isEmpty
            ?  EmptyListWidget(message: "لا توجد طلبات ".tr())
            : ListView.builder(
                padding: const EdgeInsets.only(top:0, left: 4, right: 4),
                itemCount: list.length,
                itemBuilder: (ctx, index) {
                  Order orderResponse = list[index];
                  return GestureDetector(
                    onTap: () {
                      pushPage(context,
                          OrderDetailsScreen(id: orderResponse.id));
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
                                         
                                          Texts(
                                              title: orderResponse.id.toString() + " #",
                                              family: AppFonts.taM,
                                              size: 13,
                                              textColor: Color(0xff343434))
                                        ],
                                      )),
                                      DataCell(Texts(
                                          title: orderResponse.createdAt
                                              .split("T")[0],
                                          family: AppFonts.taM,
                                          size: 13,
                                          textColor: Color(0xff343434))),
                                      DataCell(Texts(
                                          title:
                                              "${orderResponse.totalCost} SAR",
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
                                        color: orderStatusColors[ orderResponse.status],
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    Texts(
                                      title: orderStatus[
                                          orderResponse.status].tr(),
                                      family: AppFonts.taM,
                                      size: 12,
                                      textColor: orderStatusColors[ orderResponse.status],
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        )),
                  );
                });
 
  }
}