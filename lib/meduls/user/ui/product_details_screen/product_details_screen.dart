import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatlli/core/enums/loading_status.dart';
import 'package:hatlli/core/extension/theme_extension.dart';
import 'package:hatlli/core/layout/palette.dart';
import 'package:hatlli/core/layout/screen_size.dart';
import 'package:hatlli/core/utils/api_constatns.dart';
import 'package:hatlli/core/utils/app_model.dart';
import 'package:hatlli/core/widgets/circular_progress.dart';
import 'package:hatlli/core/widgets/icon_alert_widget.dart';
import 'package:hatlli/core/widgets/rating_bar_widget.dart';
import 'package:hatlli/meduls/common/bloc/home_cubit/home_cubit.dart';
import 'package:hatlli/meduls/common/bloc/product_cubit/product_cubit.dart';
import 'package:hatlli/meduls/common/models/product.dart';
import 'package:hatlli/meduls/common/ui/payment/payment.dart';
import 'package:hatlli/meduls/user/bloc/cart_cubit/cart_cubit.dart';
import 'package:hatlli/meduls/user/models/rate_response.dart';
import 'package:hatlli/meduls/user/ui/product_details_screen/show_image_screen/show_image_screen.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/layout/app_fonts.dart';
import '../../../../core/layout/app_radius.dart';
import '../../../../core/router/routes.dart';
import '../../../../core/widgets/back_button.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/texts.dart';
import '../../../provider/ui/add_product_screen/add_product_screen.dart';
import '../../models/cart_model.dart';
import '../details_provider_screen/components/fav_icon_widget.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;
  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  List<String> images = [];
  int quantity = 1;
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    images = widget.product.images.split("#");

    ProductCubit.get(context)
        .getRateProduct(productId: widget.product.id, context: context);

    if (CartCubit.get(context).cartsFound.containsValue(widget.product.id)) {
      int quntity = CartCubit.get(context).quantitiesMap[widget.product.id]!;
      CartCubit.get(context).changeQuantity(quntity);
    } else {
      CartCubit.get(context).changeQuantity(1);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        return Scaffold(
          bottomSheet: currentUser.role == AppModel.providerRole
              ? Container(
                  height: 80,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: context.wSize,
                          height: 50,
                          child: CustomButton(
                            title: "تعديل".tr(),
                            onPressed: () {
                              pushPage(
                                  context,
                                  AddProductScreen(
                                    type: 1,
                                    product: widget.product,
                                  ));
                            },
                            backgroundColor: Colors.black,
                            titleColor: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 13,
                      ),
                      Expanded(
                        child: SizedBox(
                          width: context.wSize,
                          height: 50,
                          child: CustomButton(
                            title: "حذف".tr(),
                            onPressed: () {
                              showDialogWidget(
                                  context,
                                  Container(
                                    height: 200,
                                    width: widthScreen(context),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Texts(
                                            title: " هل أنت متأكد أنك تريد حذف "
                                                    .tr() +
                                                widget.product.name,
                                            family: AppFonts.taB,
                                            size: 16,
                                            textColor: Colors.red),
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        Container(
                                          height: 80,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: SizedBox(
                                                  width: context.wSize,
                                                  height: 50,
                                                  child: CustomButton(
                                                    title: "حذف".tr(),
                                                    onPressed: () {
                                                      pop(context);
                                                      ProductCubit.get(context)
                                                          .deleteProduct(
                                                              productId: widget
                                                                  .product.id,
                                                              context: context);
                                                    },
                                                    backgroundColor: Colors.red,
                                                    titleColor: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 13,
                                              ),
                                              Expanded(
                                                child: SizedBox(
                                                  width: context.wSize,
                                                  height: 50,
                                                  child: CustomButton(
                                                    title: "الغاء".tr(),
                                                    elevation: 0,
                                                    onPressed: () {
                                                      pop(context);
                                                    },
                                                    backgroundColor:
                                                        Colors.white,
                                                    titleColor: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ));
                            },
                            backgroundColor: Colors.red,
                            titleColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : BlocBuilder<CartCubit, CartState>(
                  builder: (context, stateCart) {
                    return Container(
                      height: 80,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              width: context.wSize,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (isLogin()) {
                                    if (CartCubit.get(context)
                                        .cartsFound
                                        .containsValue(widget.product.id)) {
                                      pushPageRoutName(context, cart);
                                    } else {
                                      CartModel cartModel = CartModel(
                                          id: 0,
                                          userId: currentUser.id!,
                                          productId: widget.product.id,
                                          providerId: widget.product.providerId,
                                          quantity: stateCart.quantity,
                                          status: 0,
                                          orderId: 0,
                                          cost: 0,
                                          createdAt: "createdAt");
                                      CartCubit.get(context)
                                          .addCart(cartModel, context: context);
                                    }
                                  } else {
                                    showDialogLogin(context: context);
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    // onPressed == null ? Palette.kGreyColor : Palette.mainColor,
                                    const Color(0xff000000),
                                  ),
                                  elevation: MaterialStateProperty.all(10),
                                  shape: MaterialStateProperty.resolveWith(
                                      (states) {
                                    if (!states
                                        .contains(MaterialState.pressed)) {
                                      return const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                        side: BorderSide.none,
                                      );
                                    }
                                    return const RoundedRectangleBorder(
                                      borderRadius: AppRadius.r10,
                                    );
                                  }),
                                ),
                                child: CartCubit.get(context)
                                        .cartsFound
                                        .containsValue(widget.product.id)
                                    ? Text(
                                        "أكمل الطلب".tr(),
                                        style: context.titleM.copyWith(
                                          fontSize: 12,
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: AppFonts.caSi,
                                        ),
                                      )
                                    : Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "اضف للسلة".tr(),
                                            style: context.titleM.copyWith(
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontWeight: FontWeight.normal,
                                              fontFamily: AppFonts.caSi,
                                            ),
                                          ),
                                          SvgPicture.asset(
                                              "assets/icons/cart_item.svg"),
                                        ],
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 13,
                          ),
                          Expanded(
                            child: SizedBox(
                              width: context.wSize,
                              height: 40,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (isLogin()) {
                                    if (currentUser.status == 1) {
                                      showTopMessage(
                                          context: context,
                                          customBar: CustomSnackBar.error(
                                              backgroundColor: Colors.red,
                                              message:
                                                  "هذا الرقم محظور تواصل مع خدمة العملاء"
                                                      .tr(),
                                              textStyle: TextStyle(
                                                  fontFamily: "font",
                                                  fontSize: 16,
                                                  color: Colors.white)));
                                    } else {
                                      pushPage(
                                          context,
                                          PaymentMethodsConfirmed(
                                            note: "not",
                                            total: (widget.product.price *
                                                        quantity)
                                                    .toInt() *
                                                100,
                                            productId: widget.product.id,
                                            providerId:
                                                widget.product.providerId,
                                            type: 1,
                                            quntity: quantity,
                                          ));
                                    }
                                  } else {
                                    showDialogLogin(context: context);
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                    // onPressed == null ? Palette.kGreyColor : Palette.mainColor,
                                    Palette.mainColor,
                                  ),
                                  elevation: MaterialStateProperty.all(10),
                                  shape: MaterialStateProperty.resolveWith(
                                      (states) {
                                    if (!states
                                        .contains(MaterialState.pressed)) {
                                      return const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                        side: BorderSide.none,
                                      );
                                    }
                                    return const RoundedRectangleBorder(
                                      borderRadius: AppRadius.r10,
                                    );
                                  }),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "شراء الآن".tr(),
                                      style: context.titleM.copyWith(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: AppFonts.caSi,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    SvgPicture.asset("assets/icons/walet.svg"),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: GestureDetector(
              onTap: () {
                pop(context);
              },
              child: BackButtonWidget(),
            ),
            title: Texts(
                title: "تفاصيل المنتج".tr(),
                family: AppFonts.taB,
                size: 18,
                widget: FontWeight.bold),
            actions: [
              IconAlertWidget(),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 45,
                  ),

                  //** slider Widget */

                  SizedBox(
                    height: 200,
                    child: Stack(
                      children: [
                        CarouselSlider.builder(
                            itemCount: images.length,
                            itemBuilder: (ctx, index, page) {
                              return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5)),
                                height: 200,
                                child: Stack(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        pushPage(context,
                                            ShowImageScreen(images: images));
                                      },
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: CachedNetworkImage(
                                            imageUrl: ApiConstants.imageUrl(
                                                images[index]),
                                            errorWidget: (context, url,
                                                    error) =>
                                                Image.asset(
                                                    "assets/images/logo_black.png"),
                                            width: double.infinity,
                                            fit: BoxFit.contain,
                                            height: double.infinity,
                                          )),
                                    ),
                                    // Align(
                                    //   alignment: Alignment.topRight,
                                    //   child: Container(
                                    //     width: 75,
                                    //     height: 27,
                                    //     decoration: BoxDecoration(
                                    //         borderRadius: BorderRadius.circular(5),
                                    //         color: Colors.red),
                                    //     child: const Center(
                                    //         child: Texts(
                                    //       title: "نفذت الكمية",
                                    //       family: AppFonts.caR,
                                    //       size: 12,
                                    //       textColor: Colors.white,
                                    //       height: 1.8,
                                    //     )),
                                    //   ),
                                    // )
                                  ],
                                ),
                              );
                            },
                            options: CarouselOptions(
                                onPageChanged: (index, reason) {
                                  HomeCubit.get(context)
                                      .changeCurrentPageSlider(index);
                                },
                                height: 200,
                                enableInfiniteScroll: false,
                                viewportFraction: 1,
                                scrollDirection: Axis.horizontal)),
                        BlocBuilder<HomeCubit, HomeState>(
                          builder: (context, state) {
                            return Positioned(
                              bottom: 10,
                              left: 0,
                              right: 0,
                              child: IndicatorWidget(
                                  state.currentPageSlider, images.length),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  //* ===============
                  const SizedBox(
                    height: 29,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Texts(
                              title: "${widget.product.price} SAr ",
                              family: AppFonts.taB,
                              size: 14),
                          widget.product.discount > 0
                              ? Text(
                                  "${(widget.product.discount + widget.product.price).toString()}  SAR",
                                  style: TextStyle(
                                    fontFamily: AppFonts.caR,
                                    color: Colors.black54,
                                    height: 1.2,
                                    fontSize: 12,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                      currentUser.role == AppModel.providerRole
                          ? const SizedBox()
                          : Container(
                              width: 33.0,
                              height: 33.0,
                              decoration: BoxDecoration(
                                color: const Color(0xfff5f5f6),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: IconFavorite(product: widget.product),
                            )
                    ],
                  )

                  //** quantity */
                  ,
                  const SizedBox(
                    height: 20,
                  ),
                  currentUser.role == AppModel.providerRole
                      ? const SizedBox()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Texts(
                                title: "حدد الكمية".tr(),
                                family: AppFonts.taB,
                                size: 14),
                            BlocBuilder<CartCubit, CartState>(
                              builder: (context, stateCart) {
                                return Container(
                                  width: 120,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color(0xffD6DCE0)),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            CartCubit.get(context)
                                                .minusQuantityProductDetails(
                                                    quantity: stateCart
                                                        .quantity,
                                                    cartId: CartCubit.get(
                                                                context)
                                                            .cartsFound
                                                            .containsValue(
                                                                widget
                                                                    .product.id)
                                                        ? stateCart
                                                            .cartResponse!
                                                            .carts!
                                                            .firstWhere(
                                                                (element) =>
                                                                    element
                                                                        .product
                                                                        .id ==
                                                                    widget
                                                                        .product
                                                                        .id)
                                                            .cart
                                                            .id
                                                        : 0);
                                            // if (quantity > 1) {
                                            //   setState(() {
                                            //     quantity--;
                                            //   });
                                            // }

                                            // // ** update cart
                                            // if (CartCubit.get(context)
                                            //     .cartsFound
                                            //     .containsValue(
                                            //         widget.product.id)) {
                                            //   print("update");
                                            //   CartCubit.get(context).updateCart(
                                            //       quantity,
                                            //       stateCart.cartResponse!.carts!
                                            //           .firstWhere((element) =>
                                            //               element.product.id ==
                                            //               widget.product.id));
                                            // }
                                          },
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                          icon: const Icon(
                                            Icons.remove,
                                            color: Color(0xff707070),
                                            size: 20,
                                          )),
                                      Texts(
                                        title: "${stateCart.quantity}",
                                        family: AppFonts.caR,
                                        size: 15,
                                        textColor: Color(0xff707070),
                                        height: 2,
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            CartCubit.get(context)
                                                .addQuantityProductDetails(
                                                    quantity: stateCart
                                                        .quantity,
                                                    cartId: CartCubit.get(
                                                                context)
                                                            .cartsFound
                                                            .containsValue(
                                                                widget
                                                                    .product.id)
                                                        ? stateCart
                                                            .cartResponse!
                                                            .carts!
                                                            .firstWhere(
                                                                (element) =>
                                                                    element
                                                                        .product
                                                                        .id ==
                                                                    widget
                                                                        .product
                                                                        .id)
                                                            .cart
                                                            .id
                                                        : 0);

                                            // setState(() {
                                            //   quantity++;
                                            // });
                                            // // ** update cart

                                            // print("update");
                                            // CartCubit.get(context).updateCart(
                                            //   quantity,
                                            //   stateCart.cartResponse!.carts!
                                            //       .firstWhere((element) =>
                                            //           element.product.id ==
                                            //           widget.product.id),
                                            //   context: context,
                                            // );
                                          },
                                          padding: EdgeInsets.zero,
                                          constraints: const BoxConstraints(),
                                          icon: const Icon(
                                            Icons.add,
                                            size: 20,
                                            color: Color(0xff707070),
                                          )),
                                    ],
                                  ),
                                );
                              },
                            )
                          ],
                        )

                  //** ===== */
                  ,
                  currentUser.role == AppModel.providerRole
                      ? const SizedBox()
                      : const SizedBox(
                          height: 22,
                        ),
                  // *** product details
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 18),
                    decoration: BoxDecoration(
                      color: const Color(0xfffafbfb),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Texts(
                                title: widget.product.name,
                                family: AppFonts.taB,
                                size: 14),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          width: widthScreen(context),
                          child: Text(
                            widget.product.description,
                            style: TextStyle(
                              fontFamily: AppFonts.caR,
                              fontSize: 10,
                              color: const Color(0xff707070),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0xfffafbfb),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        tilePadding: EdgeInsets.zero,
                        title: Texts(
                            title: "مزيد من التفاصيل".tr(),
                            family: AppFonts.taB,
                            size: 14),
                        children: [
                          widget.product.calories == "not"
                              ? SizedBox()
                              : SizedBox(
                                  height: 60,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Texts(
                                            title: "الماركة".tr(),
                                            family: AppFonts.caR,
                                            textColor: Color(0xff707070),
                                            size: 14),
                                        Texts(
                                            title: widget.product.brandId,
                                            family: AppFonts.caR,
                                            textColor: Color(0xff707070),
                                            size: 14),
                                      ],
                                    ),
                                  ),
                                ),
                          widget.product.calories == "not"
                              ? SizedBox()
                              : Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          top: BorderSide(
                                              width: .8,
                                              color: Color(0xffD6DCE0)))),
                                  height: 60,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Texts(
                                            title: "اللون".tr(),
                                            family: AppFonts.caR,
                                            textColor: Color(0xff707070),
                                            size: 14),
                                        Texts(
                                            title: widget.product.calories,
                                            family: AppFonts.caR,
                                            textColor: const Color(0xff707070),
                                            size: 14),
                                      ],
                                    ),
                                  ),
                                ),
                          widget.product.sizes == "not"
                              ? SizedBox()
                              : Container(
                                  decoration: const BoxDecoration(
                                      border: Border(
                                          top: BorderSide(
                                              width: .8,
                                              color: Color(0xffD6DCE0)))),
                                  height: 60,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Texts(
                                            title: "المقاسات المتوفرة".tr(),
                                            family: AppFonts.caR,
                                            textColor: Color(0xff707070),
                                            size: 14),
                                        Texts(
                                            title: widget.product.sizes,
                                            family: AppFonts.caR,
                                            textColor: const Color(0xff707070),
                                            size: 14),
                                      ],
                                    ),
                                  ),
                                ),
                          Container(
                            decoration: const BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        width: .8, color: Color(0xffD6DCE0)))),
                            height: 60,
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Texts(
                                      title: "رمز المنتج".tr(),
                                      family: AppFonts.caR,
                                      textColor: Color(0xff707070),
                                      size: 14),
                                  Texts(
                                      title: "# ${widget.product.id}",
                                      family: AppFonts.caR,
                                      textColor: const Color(0xff707070),
                                      size: 14),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        width: .8, color: Color(0xffD6DCE0)))),
                            height: 60,
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Texts(
                                      title: "التصنيفات".tr(),
                                      family: AppFonts.caR,
                                      textColor: Color(0xff707070),
                                      size: 14),
                                  Texts(
                                      title: categories
                                          .firstWhere((element) =>
                                              element.id ==
                                              widget.product.categoryId)
                                          .name,
                                      family: AppFonts.caR,
                                      textColor: const Color(0xff707070),
                                      size: 14),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 15,
                  ),
                  Divider(),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Texts(
                          title: "تقييم المنتج ".tr(),
                          family: AppFonts.caB,
                          size: 16,
                          textColor: Colors.black,
                          widget: FontWeight.normal),
                      RatingBarWidget(
                        rate: widget.product.rate,
                        size: 15,
                      ),
                    ],
                  ),
                  // ** rate
                  SizedBox(
                    height: 20,
                  ),
                  state.getRateProductState == RequestState.loaded
                      ? ListView.builder(
                          itemCount: state.rates.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            RateResponse rateResponse = state.rates[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              padding: const EdgeInsets.all(14),
                              // height: 80,
                              decoration: BoxDecoration(
                                color: const Color(0xffffffff),
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0x29b6b6b6),
                                    offset: Offset(0, 0),
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Palette.mainColor,
                                          width: 1,
                                        )),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: CachedNetworkImage(
                                        imageUrl: ApiConstants.imageUrl(
                                            rateResponse.user.profileImage),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                                "assets/images/person.png"),
                                        height: 26,
                                        width: 26,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Texts(
                                          title: rateResponse.user.fullName,
                                          family: AppFonts.caR,
                                          size: 12),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Texts(
                                        title: rateResponse.rate.comment,
                                        family: AppFonts.moL,
                                        size: 10,
                                        line: 20,
                                        textColor: Color(0xffA9A9AA),
                                      )
                                    ],
                                  )),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RatingBarWidget(
                                        rate:
                                            rateResponse.rate.stare.toDouble(),
                                      ),
                                      Texts(
                                        title: rateResponse.rate.createAte
                                            .split("T")[0],
                                        family: AppFonts.moL,
                                        size: 10,
                                        textColor: Color(0xffA9A9AA),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                          })
                      : CustomCircularProgress(),

                  Row(
                    children: [],
                  ),

                  currentUser.role == AppModel.userRole
                      ? GestureDetector(
                          onTap: () {
                            rateProduct(context, widget.product.id);
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Texts(
                                    title: "أضف تقييم".tr(),
                                    family: AppFonts.caB,
                                    size: 15,
                                    textColor: Palette.mainColor,
                                    widget: FontWeight.normal),
                                SizedBox(
                                  width: 15,
                                ),
                                // RatingBarWidget(rate: 5),
                                SvgPicture.asset(
                                  "assets/icons/star.svg",
                                  width: 30,
                                  height: 30,
                                )
                              ],
                            ),
                          ),
                        )
                      : SizedBox(),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> rateProduct(BuildContext context, productId) {
    double stars = 3;
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return BlocBuilder<ProductCubit, ProductState>(
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

                      Texts(
                        title: "اترك تقييما".tr(),
                        textColor: Colors.black,
                        size: 30,
                        widget: FontWeight.bold,
                        family: AppFonts.caB,
                      ),

                      sizedHeight(10),
                      SizedBox(
                        child: RatingBar.builder(
                          initialRating: stars,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Palette.mainColor,
                          ),
                          onRatingUpdate: (rating) {
                            stars = rating;
                          },
                        ),
                      ),
                      sizedHeight(10),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.black38, width: .8)),
                        child: TextField(
                          controller: _controller,
                          keyboardType: TextInputType.multiline,
                          maxLines: 4,
                          decoration: InputDecoration(
                              hintText: "اكنب تعليقك".tr(),
                              hintStyle:
                                  TextStyle(fontSize: 16, color: Colors.black),
                              border: InputBorder.none),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      state.addRateProductState == RequestState.loading
                          ? CustomCircularProgress(
                              size: Size(30, 30),
                              strokeWidth: 4,
                            )
                          : CustomButton(
                              onPressed: () {
                                print(stars);
                                ProductCubit.get(context)
                                    .addRateProduct(
                                        context: context,
                                        comment: _controller.text,
                                        productId: productId,
                                        stare: stars.toInt())
                                    .then((value) {
                                  pop(context);
                                  _controller.clear();
                                });
                              },
                              title: 'ارسال',
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

class IndicatorWidget extends StatelessWidget {
  final int index;
  final int count;
  const IndicatorWidget(this.index, this.count, {super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              count,
              (indexNew) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    height: 7,
                    width: 7,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: index == indexNew
                            ? Colors.black
                            : Colors.transparent,
                        border: Border.all(color: Colors.grey, width: .8)),
                  )).toList(),
        ));
  }
}
