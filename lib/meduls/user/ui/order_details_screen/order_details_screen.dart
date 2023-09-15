import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        title: Texts(
            title: "تفاصيل الطلب".tr(),
            family: AppFonts.taB,
            size: 18,
            height: 1.0,
            widget: FontWeight.bold),
        actions: [IconAlertWidget()],
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
                          state.orderDetailsResponse!.order!.type == 0
                              ? TableOrderDetailsWidget(
                                  list: state.orderDetailsResponse!.products!)
                              : SizedBox(),
                          //* =========
                          state.orderDetailsResponse!.order!.type == 0
                              ? Divider(
                                  height: .8,
                                )
                              : SizedBox(),
                          const SizedBox(
                            height: 47,
                          ),
                          //** order Details */
                        
                          state.orderDetailsResponse!.order!.type ==1&&(state.orderDetailsResponse!.order!.status == 0 ||state.orderDetailsResponse!.order!.status == 4 )?SizedBox():    DetailsOrderWidget(
                                  total: state
                                      .orderDetailsResponse!.order!.totalCost,
                                  status:
                                      state.orderDetailsResponse!.order!.status,
                                ),
                                 Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Texts(
                                            title:  state.orderDetailsResponse!.order!.type == 0? "ملحوظة".tr(): "تفاصيل الطلب".tr(),
                                            family: AppFonts.taB,
                                            size: 14,
                                            textColor: Colors.red),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Texts(
                                            title: state.orderDetailsResponse!
                                                .order!.notes,
                                            family: AppFonts.taB,
                                            line: 30,
                                            size: 14,
                                            textColor:
                                                Color.fromARGB(255, 71, 71, 71))
                                      ],
                                    ),
                                  ],
                                )
                          //** ========== */
                          // ** COMMENTS ORDER
                         ,
                          SizedBox(
                            height: 17,
                          ),

                          // state.orderDetailsResponse!.order!.notes.isNotEmpty &&
                          //         state.orderDetailsResponse!.order!.notes !=
                          //             "not" &&
                          //         state.orderDetailsResponse!.order!.type == 0
                          //     ? Row(
                          //         children: [
                          //           Column(
                          //             crossAxisAlignment:
                          //                 CrossAxisAlignment.start,
                          //             children: [
                          //               Texts(
                          //                   title: "ملحوظة".tr(),
                          //                   family: AppFonts.taB,
                          //                   size: 14,
                          //                   textColor: Colors.red),
                          //               SizedBox(
                          //                 height: 10,
                          //               ),
                          //               Texts(
                          //                   title: state.orderDetailsResponse!
                          //                       .order!.notes,
                          //                   family: AppFonts.taB,
                          //                   line: 30,
                          //                   size: 14,
                          //                   textColor:
                          //                       Color.fromARGB(255, 71, 71, 71))
                          //             ],
                          //           ),
                          //         ],
                          //       )
                          //     : SizedBox()
                        ]),
                      ),
                      const SizedBox(
                        height: 37,
                      ),
                      //** button cancel  Order*/

                      currentUser.role == AppModel.userRole
                          ? state.orderDetailsResponse!.order!.status == 0 &&
                                  state.orderDetailsResponse!.order!.payment ==
                                      0
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
                4, state.orderDetailsResponse!.order!.id, 0,
                context: context);
          }),
    );
  }
}

class ButtonProviderOrder extends StatefulWidget {
  final OrderState state;
  const ButtonProviderOrder(this.state, {super.key});

  @override
  State<ButtonProviderOrder> createState() => _ButtonProviderOrderState();
}

class _ButtonProviderOrderState extends State<ButtonProviderOrder> {
  final _controllerPrice = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerPrice.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          widget.state.orderDetailsResponse!.order!.status == 0
              ? Container()
              : const SizedBox(),
          CustomButton(
              title: widget.state.orderDetailsResponse!.order!.status > 0
                  ? "متابعة الطلب".tr()
                  : "تأكيد الطلب".tr(),
              onPressed: () {
                if (widget.state.orderDetailsResponse!.order!.status == 0) {
                  if (widget.state.orderDetailsResponse!.order!.type == 0) {
                    OrderCubit.get(context).updateOrder(
                        1, widget.state.orderDetailsResponse!.order!.id, 1,
                        context: context);
                  } else {
                    // ** confirm order manual
                    confirmManualOrder(
                        context, widget.state.orderDetailsResponse!.order!.id);
                  }
                } else {
                  pushPage(
                      context,
                      TrackingOrderScreen(
                          lat: widget.state.orderDetailsResponse!.address!.lat!,
                          lng: widget
                              .state.orderDetailsResponse!.address!.lng!));
                }
              }),
          widget.state.orderDetailsResponse!.order!.status == 0 &&
                  widget.state.orderDetailsResponse!.order!.payment == 0
              ? TextButton(
                  onPressed: () {
                    OrderCubit.get(context).updateOrder(
                        4, widget.state.orderDetailsResponse!.order!.id, 1,
                        context: context);
                  },
                  child: Text(
                    "الغاء الطلب".tr(),
                    style:
                        TextStyle(fontFamily: AppFonts.caB, color: Colors.red),
                  ))
              : const SizedBox()
        ],
      ),
    );
  }

  Future<dynamic> confirmManualOrder(BuildContext context, orderId) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  width: double.infinity,
                  // height: heightScreen(context) / 1.5,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // sizedHeight(15),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                pop(context);
                              },
                              icon: Icon(Icons.close, color: Colors.black))
                        ],
                      ),

                      Row(
                        children: [
                          Texts(
                            title: "اكتب السعر".tr(),
                            textColor: Colors.black,
                            size: 20,
                            widget: FontWeight.bold,
                            family: AppFonts.taB,
                          ),
                        ],
                      ),

                      sizedHeight(20),

                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black38, width: .8)),
                        child: TextField(
                          controller: _controllerPrice,
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                         
                          decoration: InputDecoration(
                              hintText: "اكتب سعر الطلب  + قيمة التوصيل".tr(),
                              hintStyle:
                                  TextStyle(fontSize: 12, color: Colors.grey,fontFamily: AppFonts.taM),
                              border: InputBorder.none),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      state.updateOrderState == RequestState.loading
                          ? CustomCircularProgress(
                              size: Size(30, 30),
                              strokeWidth: 4,
                            )
                          : CustomButton(
                              onPressed: () {
                                OrderCubit.get(context)
                                    .confirmManualOrder(
                                        _controllerPrice.text.trim(), orderId,
                                        context: context)
                                    .then((value) {
                                 pop(context);
                                  _controllerPrice.clear();
                                });
                              },
                              title: "ارسال".tr(),
                            ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }


}
