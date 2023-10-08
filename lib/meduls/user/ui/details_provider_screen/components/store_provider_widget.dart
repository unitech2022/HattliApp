import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatlli/core/animations/slide_transtion.dart';
import 'package:hatlli/core/enums/loading_status.dart';
import 'package:hatlli/core/extension/theme_extension.dart';
import 'package:hatlli/core/helpers/helper_functions.dart';
import 'package:hatlli/core/layout/palette.dart';
import 'package:hatlli/core/layout/screen_size.dart';
import 'package:hatlli/core/router/routes.dart';
import 'package:hatlli/core/utils/api_constatns.dart';
import 'package:hatlli/core/utils/app_model.dart';
import 'package:hatlli/core/utils/app_sittings.dart';
import 'package:hatlli/core/widgets/circular_progress.dart';
import 'package:hatlli/core/widgets/empty_list_widget.dart';
import 'package:hatlli/meduls/common/models/category.dart';

import 'package:hatlli/meduls/common/models/product.dart';
import 'package:hatlli/meduls/provider/bloc/provider_cubit/provider_cubit.dart';
import 'package:hatlli/meduls/provider/models/details_provider_response.dart';
import 'package:hatlli/meduls/user/bloc/cart_cubit/cart_cubit.dart';
import 'package:hatlli/meduls/user/models/cart_model.dart';
import 'package:hatlli/meduls/user/ui/manual_order_screen/manual_order_screen.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

import '../../../../../core/layout/app_fonts.dart';
import '../../../../../core/layout/app_radius.dart';
import '../../../../../core/widgets/texts.dart';
import '../../product_details_screen/product_details_screen.dart';
import 'fav_icon_widget.dart';

class StoreProviderWidget extends StatefulWidget {
  final DetailsProviderResponse providerDetails;
  const StoreProviderWidget({super.key, required this.providerDetails});

  @override
  State<StoreProviderWidget> createState() => _StoreProviderWidgetState();
}

class _StoreProviderWidgetState extends State<StoreProviderWidget> {
  final ScrollController _scrollController = ScrollController();
  int currentPage = 1;
  @override
  void initState() {
    fetchData();
    super.initState();
    //
  }

  Future<void> fetchData() async {
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        if (currentPage < ProviderCubit.get(context).totalPages &&
            ProviderCubit.get(context).newProducts.length ==
                AppSittings.pageSize) {
          currentPage++;
          ProviderCubit.get(context).getProductsByProviderId(
              page: currentPage,
              context: context,
              providerId: widget.providerDetails.provider!.id);
        } else {}
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProviderCubit, ProviderState>(
      builder: (context, state) {
        return state.getProvidersByProviderIdState == RequestState.loaded &&
                ProviderCubit.get(context).products.isEmpty
            ? EmptyListWidget(message: "لا توجد منتجات".tr())
            : SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Texts(
                            title: "أحدث المنتجات : ".tr(),
                            family: AppFonts.taB,
                            size: 14,
                            widget: FontWeight.bold),
                        categories
                                    .firstWhere(
                                      (element) =>
                                          element.id ==
                                          widget.providerDetails.provider!
                                              .categoryId,
                                      orElse: () => CategoryModel(
                                          id: 0,
                                          name: "name",
                                          nameEng: "nameEng",
                                          imageUrl: "imageUrl",
                                          status: 0,
                                          createdAt: ""),
                                    )
                                    .status ==
                                1
                            ? TextButton(
                                onPressed: () {
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
                                    pushTranslationPage(
                                        context: context,
                                        transtion: FadTransition(
                                            page: ManualOrderScreen(
                                                providerId: widget
                                                    .providerDetails
                                                    .provider!
                                                    .id)));
                                  }
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      "assets/icons/orders.svg",
                                      color: Palette.mainColor,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Texts(
                                        title: "طلب يدوى".tr(),
                                        family: AppFonts.taB,
                                        textColor: Palette.mainColor,
                                        size: 14,
                                        widget: FontWeight.bold),
                                  ],
                                ),
                              )
                            : SizedBox(),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 266,
                                childAspectRatio: 1.2 / 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10),
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: ProviderCubit.get(context).products.length,
                        itemBuilder: (BuildContext context, int index) {
                          Product product =
                              ProviderCubit.get(context).products[index];
                          return GestureDetector(
                            onTap: () {
                              // pushPage(
                              //     context,
                              //     ProductDetailsScreen(
                              //       product: product,
                              //     ));

                              pushTranslationPage(
                                  context: context,
                                  transtion: FadTransition(
                                      page: ProductDetailsScreen(
                                    product: product,
                                  )));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xffffffff),
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                    width: 0.5, color: const Color(0xffebebeb)),
                              ),
                              child: Column(
                                children: [
                                  Expanded(
                                      child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      Positioned.fill(
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(15),
                                              topRight: Radius.circular(15)),
                                          child: CachedNetworkImage(
                                            imageUrl: ApiConstants.imageUrl(
                                                product.images.split("#")[0]),
                                            errorWidget: (context, url,
                                                    error) =>
                                                Image.asset(
                                                    "assets/images/logo_black.png"),
                                            height: double.infinity,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: IconFavorite(product: product),
                                      )
                                    ],
                                  )),
                                  Expanded(
                                      child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(5),
                                    color: Colors.white,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Texts(
                                            title: product.name,
                                            family: AppFonts.caB,
                                            size: 12,
                                            textColor: Colors.black,
                                            widget: FontWeight.normal),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Texts(
                                            title: product.description,
                                            family: AppFonts.caR,
                                            size: 10,
                                            line: 2,
                                            textColor: const Color(0xff707070),
                                            widget: FontWeight.normal),
                                        const Spacer(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Texts(
                                                title: "السعر  : ".tr(),
                                                family: AppFonts.caR,
                                                size: 12,
                                                textColor: Color(0xff707070),
                                                widget: FontWeight.normal),
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Texts(
                                                    title: product.price
                                                            .toString() +
                                                        " SAR",
                                                    family: AppFonts.caM,
                                                    size: 14,
                                                    textColor: Colors.black,
                                                    widget: FontWeight.normal),
                                                product.discount > 0
                                                    ? Text(
                                                        "${(product.discount + product.price).toString()}  SAR",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              AppFonts.caR,
                                                          color: Colors.black54,
                                                          height: 1.2,
                                                          fontSize: 12,
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                        ),
                                                      )
                                                    : SizedBox(),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        BlocBuilder<CartCubit, CartState>(
                                          builder: (context, state) {
                                            return SizedBox(
                                              width: context.wSize,
                                              height: 30,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  if (isLogin()) {
                                                    if (CartCubit.get(context)
                                                        .cartsFound
                                                        .containsValue(
                                                            product.id)) {
                                                      pushPageRoutName(
                                                          context, cart);
                                                    } else {
                                                      CartModel cartModel =
                                                          CartModel(
                                                              id: 0,
                                                              userId:
                                                                  currentUser
                                                                      .id!,
                                                              productId:
                                                                  product.id,
                                                              providerId: product
                                                                  .providerId,
                                                              quantity: 1,
                                                              status: 0,
                                                              orderId: 0,
                                                              cost: 0,
                                                              createdAt:
                                                                  "createdAt");
                                                      CartCubit.get(context)
                                                          .addCart(cartModel,
                                                              context: context);
                                                    }
                                                  } else {
                                                    showDialogLogin(
                                                        context: context);
                                                  }
                                                },
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all<
                                                          Color>(
                                                    // onPressed == null ? Palette.kGreyColor : Palette.mainColor,
                                                    const Color(0xff000000),
                                                  ),
                                                  elevation:
                                                      MaterialStateProperty.all(
                                                          10),
                                                  shape: MaterialStateProperty
                                                      .resolveWith((states) {
                                                    if (!states.contains(
                                                        MaterialState
                                                            .pressed)) {
                                                      return const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(5),
                                                        ),
                                                        side: BorderSide.none,
                                                      );
                                                    }
                                                    return const RoundedRectangleBorder(
                                                      borderRadius:
                                                          AppRadius.r10,
                                                    );
                                                  }),
                                                ),
                                                child: Center(
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      CartCubit.get(context)
                                                              .cartsFound
                                                              .containsValue(
                                                                  product.id)
                                                          ? const SizedBox()
                                                          : SvgPicture.asset(
                                                              "assets/icons/cart_item.svg"),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        CartCubit.get(context)
                                                                .cartsFound
                                                                .containsValue(
                                                                    product.id)
                                                            ? "أكمل الطلب".tr()
                                                            : "اضف للسلة".tr(),
                                                        style: context.titleM
                                                            .copyWith(
                                                          fontSize: 12,
                                                          // height: .8,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontFamily:
                                                              AppFonts.caSi,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            ),
                          );
                        }),
                    SizedBox(
                      height: 60,
                    ),
                    state.getProvidersByProviderIdState == RequestState.loading
                        ? CustomCircularProgress(
                            strokeWidth: 3,
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              );
      },
      listener: (BuildContext context, ProviderState state) {
        // fetchData();
      },
    );
  }
}

//     //** list Categories */

            // ListCategories(list: providerDetails.categories!),
            // const SizedBox(
            //   height: 38,
            // )

            // //** =========== */

           
