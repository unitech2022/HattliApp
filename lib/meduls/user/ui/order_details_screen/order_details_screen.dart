import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatlli/core/enums/loading_status.dart';
import 'package:hatlli/core/utils/app_model.dart';
import 'package:hatlli/core/widgets/custom_button.dart';
import 'package:hatlli/core/widgets/icon_alert_widget.dart';
import 'package:hatlli/meduls/common/bloc/order_cubit/order_cubit.dart';
import 'package:hatlli/meduls/user/ui/order_details_screen/components/details_provider_order.dart';
import 'package:hatlli/meduls/user/ui/order_details_screen/traking_order_screen/traking_order_screen.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/layout/app_fonts.dart';
import '../../../../core/widgets/back_button.dart';
import '../../../../core/widgets/circular_progress.dart';
import '../../../../core/widgets/texts.dart';

import 'components/details_order_widget.dart';
import 'components/stepper_order_widget.dart';
import 'components/table_order_details_widget.dart';

class OrderDetailsScreen extends StatefulWidget {
  final int id;
  const OrderDetailsScreen({super.key, required this.id});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  void initState() {

    super.initState();
    OrderCubit.get(context).getOrderDetails(widget.id, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButtonWidget(),
        title: 
         Texts(
            title: "تفاصيل الطلب".tr(),
            family: AppFonts.taB,
            size: 18,
            height: 1.0,
            widget: FontWeight.bold),
        actions: [
            IconAlertWidget()
        ],
      ),
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          return state.getOrderDetailsState == RequestState.loaded
              ? SingleChildScrollView(
                  child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      //* details Provider
                      DetailsProviderOrder(
                          response: state.orderDetailsResponse!),
                      SizedBox(
                        height: currentUser.role == AppModel.userRole ? 52 : 0,
                      ),
                      currentUser.role == AppModel.userRole
                          ? const Divider(
                              height: .8,
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 20,
                      )
                      //* ===============
                      // ** stuper
                      ,
                      state.orderDetailsResponse!.order!.status == 4 ||
                              currentUser.role == AppModel.providerRole
                          ? const SizedBox()
                          : StepperOrderWidget(
                              statuse:
                                  state.orderDetailsResponse!.order!.status,
                            ),

                      SizedBox(
                        height:
                            currentUser.role == AppModel.providerRole ? 0 : 18,
                      ),
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
                          TableOrderDetailsWidget(
                              list: state.orderDetailsResponse!.products!),
                          //* =========
                          const Divider(
                            height: .8,
                          ),
                          const SizedBox(
                            height: 47,
                          ),
                          //** order Details */
                          DetailsOrderWidget(
                            total: state.orderDetailsResponse!.order!.totalCost ,
                            status: state.orderDetailsResponse!.order!.status,
                          )
                          //** ========== */
                          // ** COMMENTS ORDER
                           , SizedBox(
                            height: 17,
                          ),
                        
                state.orderDetailsResponse!.order!.notes.isNotEmpty&&  state.orderDetailsResponse!.order!.notes !="not"?      Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Texts(
                        title:  "ملحوظة".tr(),
                        family: AppFonts.taB,
                        size: 14,
                        textColor: Colors.red),
                        SizedBox(height: 10,),
                         Texts(
                        title:state.orderDetailsResponse!.order!.notes,
                        family: AppFonts.taB,
                        line: 30,
                        size: 14,
                        textColor: Color.fromARGB(255, 71, 71, 71))
                              ],
                            ),
                  ],
                ):SizedBox()

                        ]),
                      ),
                      const SizedBox(
                        height: 37,
                      ),
                      //** button cancel  Order*/

                      currentUser.role == AppModel.userRole
                          ? state.orderDetailsResponse!.order!.status == 0&&state.orderDetailsResponse!.order!.payment==0
                              ? ButtonUserOrder(state)
                              : const SizedBox()
                          : state.orderDetailsResponse!.order!.status == 4
                              ? const SizedBox()
                              : ButtonProviderOrder(state)
                    ],
                  ),
                ))
              : const Scaffold(
                  body: CustomCircularProgress(
                    fullScreen: true,
                    strokeWidth: 4,
                    size: Size(50, 50),
                  ),
                );
        },
      ),
    );
  }
}

class ButtonUserOrder extends StatelessWidget {
  final OrderState state;
  const ButtonUserOrder(this.state);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CustomButton(
          title: "الغاء الطلب".tr(),
          onPressed: () {
            OrderCubit.get(context).updateOrder(
                4, state.orderDetailsResponse!.order!.id,0,
                context: context);
          }),
    );
  }
}

class ButtonProviderOrder extends StatelessWidget {
  final OrderState state;
  const ButtonProviderOrder(this.state, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          state.orderDetailsResponse!.order!.status == 0?Container():const SizedBox(),
       


          CustomButton(
              title: state.orderDetailsResponse!.order!.status > 0
                  ? "متابعة الطلب".tr()
                  : "تأكيد الطلب".tr(),
              onPressed: () {
                if (state.orderDetailsResponse!.order!.status == 0) {
                  OrderCubit.get(context).updateOrder(
                      1, state.orderDetailsResponse!.order!.id,1,
                      context: context);
                } else {
                  pushPage(context,  TrackingOrderScreen(lat:state.orderDetailsResponse!.address!.lat! ,lng:state.orderDetailsResponse!.address!.lng!));
                }
              }),
               state.orderDetailsResponse!.order!.status == 0 && state.orderDetailsResponse!.order!.payment==0
              ? TextButton(
                  onPressed: () {
                    OrderCubit.get(context).updateOrder(
                        4, state.orderDetailsResponse!.order!.id,1,
                        context: context);
                  },
                  child:  Text(
                    "الغاء الطلب".tr(),
                    style:
                        TextStyle(fontFamily: AppFonts.caB, color: Colors.red),
                  ))
              : const SizedBox()
        ],
      ),
    );
  }
}
