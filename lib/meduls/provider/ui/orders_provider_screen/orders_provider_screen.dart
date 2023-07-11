import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatlli/core/layout/palette.dart';
import 'package:hatlli/meduls/user/ui/orders_screen/components/list_orders_widget.dart';

import '../../../common/bloc/home_cubit/home_cubit.dart';


import '../../../user/ui/orders_screen/orders_screen.dart';

class OrdersProviderScreen extends StatelessWidget {
  const OrdersProviderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 10),
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
                      title: "جديد",
                      count: state.homeResponseProvider!.orders!.where((element) => element.order.status == 0).toList().length.toString(),
                      onTap: () {
                        HomeCubit.get(context).changeCurrentIndexTap(0);
                          HomeCubit.get(context).flitterListOrders(state
                            .homeResponseProvider!.orders!
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
                      title: "في التسليم",
                      count: state.homeResponseProvider!.orders!.where((element) => element.order.status <=2 && element.order.status>0).toList().length.toString(),
                      onTap: () {
                        HomeCubit.get(context).changeCurrentIndexTap(1);
                        HomeCubit.get(context).flitterListOrders(state
                            .homeResponseProvider!.orders!
                            .where((element) => element.order.status <=2&& element.order.status>0)
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
                      title: "تم التسليم",
                      count:state.homeResponseProvider!.orders!.where((element) => element.order.status==3).toList().length.toString(),
                      onTap: () {
                        HomeCubit.get(context).changeCurrentIndexTap(2);
                          HomeCubit.get(context).flitterListOrders(state
                            .homeResponseProvider!.orders!
                            .where((element) => element.order.status==3)
                            .toList());
                      },
                    )
                  ],
                )
                //* * ================
                //** list Orders */
                ,
                  ListOrdersWidget(list: state.orders,)
                //* * ================
              ],
            ),
          );
        },
      ),
    );
  }
}