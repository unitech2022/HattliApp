import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hatlli/core/enums/loading_status.dart';
import 'package:hatlli/core/utils/api_constatns.dart';
import 'package:hatlli/core/widgets/custom_button.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/layout/app_fonts.dart';
import '../../../../core/layout/palette.dart';
import '../../../../core/widgets/back_button.dart';
import '../../../../core/widgets/circular_progress.dart';
import '../../../../core/widgets/empty_list_widget.dart';
import '../../../../core/widgets/icon_alert_widget.dart';
import '../../../../core/widgets/texts.dart';
import '../../bloc/cart_cubit/cart_cubit.dart';
import '../../models/cart_response.dart';
import 'components/container_total_widget.dart';
import 'components/details_order_cart.dart';

class CartsScreen extends StatefulWidget {
  const CartsScreen({super.key});

  @override
  State<CartsScreen> createState() => _CartsScreenState();
}

class _CartsScreenState extends State<CartsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CartCubit.get(context).getCarts(isState: true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return  state.getCartsState == RequestState.loaded
              ?  Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading:BackButtonWidget(),
            title:  Texts(
                title: "سلة المشتريات".tr(),
                family: AppFonts.taB,
                size: 18,
                widget: FontWeight.bold),
            actions: [
            IconAlertWidget(),
            ],
          ),
          bottomSheet:state.cartResponse!.carts!.isEmpty? const SizedBox() : Container(
            height: 230,
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              ContainerTotalWidget(
                countProduct: state.cartResponse!.countProducts!,
                total: CartCubit.get(context).total,
              ),
              const SizedBox(
                height: 39,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: CustomButton(
                  title: "إتمام الطلب".tr(),
                  onPressed: () {
                    pushPage(context, OrderDetailsCart(carts:state.cartResponse!.carts!,total:CartCubit.get(context).total));
                  },
                  backgroundColor: Colors.black,
                ),
              )
            ]),
          ),
          body:state.cartResponse!.carts!.isEmpty?
               EmptyListWidget(message:  "لا توجد منتجات في السلة ".tr(),)
              
                 : ListView.builder(
                  itemCount: state.cartResponse!.carts!.length,
                  padding: const EdgeInsets.only(
                      left: 12, right: 12, bottom: 240, top: 12),
                  itemBuilder: (ctx, index) {
                    CartDetails cart = state.cartResponse!.carts![index];
                    return Container(
                      height: 105,
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(19.0),
                        border: Border.all(
                            width: 1.0, color: const Color(0xffe9e9ec)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                width: 80,
                                height: 100,
                                fit: BoxFit.cover,
                                  imageUrl: ApiConstants.imageUrl(
                                      cart.product.images.split("#")[0]),errorWidget: (context, url, error) => Image.asset("assets/images/logo_black.png",width: 100,
                                height: 100,),),
                            ),
                          ),
                          const SizedBox(
                            width: 11,
                          ),
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Texts(
                                  title: cart.product.name,
                                  family: AppFonts.taB,
                                  size: 14),
                              const SizedBox(
                                height: 6,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.local_offer_rounded,
                                    color: Palette.mainColor,
                                    size: 18,
                                  ),
                                  const SizedBox(
                                    width: 1,
                                  ),
                                  Texts(
                                    title:
                                        "${CartCubit.get(context).prices[cart.product.id].toString()} SAR",
                                    family: AppFonts.taM,
                                    size: 13,
                                    height: .8,
                                    textColor: const Color(0xff343434),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Texts(
                                title: cart.product.description,
                                family: AppFonts.caSi,
                                size: 11,
                                textColor: const Color(0xff2B2A2A),
                              )
                            ],
                          )),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  CartCubit.get(context).deleteCart(
                                      cartId: cart.cart.id, context: context,providerId: cart.cart.providerId,productId: cart.cart.productId);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Icon(
                                    Icons.close,
                                    size: 15.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              //*** quantity  */
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  MaterialButton(
                                    
                                    minWidth:0,
                                    color: Palette.mainColor,
                                    padding: EdgeInsets.all(5),
                                    shape:CircleBorder(),
                                    height: 22,
                                    onPressed: () {
                                      CartCubit.get(context).add(index,
                                          cart.product.price, cart.cart.id,cart.product.id);
                                    },
                                    child: const Center(
                                      child: Icon(
                                        Icons.add,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Texts(
                                      title: CartCubit.get(context)
                                          .quantitiesMap[cart.product.id]
                                          .toString(),
                                      family: AppFonts.moM,
                                      size: 15),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                 MaterialButton(
                                    
                                    minWidth:0,
                                    color: Palette.mainColor,
                                    padding: EdgeInsets.all(5),
                                    shape:CircleBorder(),
                                    height: 22,
                                    onPressed: () {
                                      CartCubit.get(context).mins(index,
                                          cart.product.price, cart.cart.id,cart.product.id);
                                    },
                                    child: const Center(
                                      child: Icon(
                                        Icons.remove,
                                        size: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  })) : const Center(
                  child: CustomCircularProgress(
                    fullScreen: true,
                    strokeWidth: 4,
                    size: Size(50, 50),
                  ),
                );
      
             
      },
    );
  }
}

