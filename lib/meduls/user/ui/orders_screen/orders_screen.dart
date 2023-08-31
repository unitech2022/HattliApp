import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatlli/core/helpers/helper_functions.dart';
import 'package:hatlli/core/layout/palette.dart';

import 'package:hatlli/meduls/common/bloc/home_cubit/home_cubit.dart';
import 'package:hatlli/meduls/user/ui/components/login_widget.dart';
import '../../../../core/layout/app_fonts.dart';
import '../../../../core/widgets/texts.dart';
import 'components/list_orders_widget.dart';

class OrdersScreen extends StatefulWidget {
  OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return isLogin()
              ? Padding(
                  padding: const EdgeInsets.only(
                    left: 19,
                    right: 19,
                    top: 100,
                  ),
                  child: Column(
                    children: [
                      //* tap Widget
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TabContainerOder(
                            backgroundColor: state.currentIndexTap == 0
                                ? Palette.mainColor
                                : Colors.transparent,
                            textColor: state.currentIndexTap == 0
                                ? Colors.white
                                : const Color(0xffBBBBBB),
                            colorTextCount: state.currentIndexTap == 0
                                ? Palette.mainColor
                                : Colors.white,
                            title: "جديد".tr(),
                            count: state.homeUserResponse!.orders!
                                .where((element) => element.order.status == 0)
                                .toList()
                                .length
                                .toString(),
                            onTap: () {
                              HomeCubit.get(context).changeCurrentIndexTap(0);
                              HomeCubit.get(context).flitterListOrders(state
                                  .homeUserResponse!.orders!
                                  .where((element) => element.order.status == 0)
                                  .toList());
                            },
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          TabContainerOder(
                            backgroundColor: state.currentIndexTap == 1
                                ? Palette.mainColor
                                : Colors.transparent,
                            textColor: state.currentIndexTap == 1
                                ? Colors.white
                                : const Color(0xffBBBBBB),
                            colorTextCount: state.currentIndexTap == 1
                                ? Palette.mainColor
                                : Colors.white,
                            title: "في التسليم".tr(),
                            count: state.homeUserResponse!.orders!
                                .where((element) =>
                                    element.order.status <= 2 &&
                                    element.order.status > 0)
                                .toList()
                                .length
                                .toString(),
                            onTap: () {
                              HomeCubit.get(context).changeCurrentIndexTap(1);
                              HomeCubit.get(context).flitterListOrders(state
                                  .homeUserResponse!.orders!
                                  .where((element) =>
                                      element.order.status <= 2 &&
                                      element.order.status > 0)
                                  .toList());
                            },
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          TabContainerOder(
                            backgroundColor: state.currentIndexTap == 2
                                ? Palette.mainColor
                                : Colors.transparent,
                            textColor: state.currentIndexTap == 2
                                ? Colors.white
                                : const Color(0xffBBBBBB),
                            colorTextCount: state.currentIndexTap == 2
                                ? Palette.mainColor
                                : Colors.white,
                            title: "تم التسليم".tr(),
                            count: state.orders
                                .where((element) => element.order.status == 3)
                                .toList()
                                .length
                                .toString(),
                            onTap: () {
                              // state.homeUserResponse.orders.f
                              HomeCubit.get(context).changeCurrentIndexTap(2);
                              HomeCubit.get(context).flitterListOrders(state
                                  .homeUserResponse!.orders!
                                  .where((element) => element.order.status == 3)
                                  .toList());
                            },
                          )
                        ],
                      )
                      //* * ================
                      //** list Orders */
                      ,
                      ListOrdersWidget(list: state.orders)
                      //* * ================
                    ],
                  ),
                )
              : LoginWidget();
        },
      ),
    );
  }
}


class TabContainerOder extends StatelessWidget {
  final String title, count;
  final Color textColor, backgroundColor, colorTextCount;
  final void Function() onTap;
  const TabContainerOder({
    super.key,
    required this.title,
    required this.textColor,
    required this.backgroundColor,
    required this.onTap,
    required this.count,
    required this.colorTextCount,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30,
        width: 100,
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: textColor),
            color: backgroundColor,
            borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Texts(
                title: title,
                family: AppFonts.taM,
                size: 12,
                height: .8,
                textColor: textColor,
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: textColor),
                child: Texts(
                  title: count,
                  family: AppFonts.taM,
                  size: 9,
                  height: .8,
                  textColor: colorTextCount,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
