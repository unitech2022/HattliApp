import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatlli/core/extension/theme_extension.dart';
import 'package:hatlli/core/helpers/helper_functions.dart';
import 'package:hatlli/core/layout/screen_size.dart';
import 'package:hatlli/core/router/routes.dart';
import 'package:hatlli/core/utils/api_constatns.dart';
import 'package:hatlli/core/utils/app_model.dart';
import 'package:hatlli/meduls/common/models/product.dart';
import 'package:hatlli/meduls/provider/models/details_provider_response.dart';
import 'package:hatlli/meduls/user/bloc/cart_cubit/cart_cubit.dart';
import 'package:hatlli/meduls/user/models/cart_model.dart';
import '../../../../../core/layout/app_fonts.dart';
import '../../../../../core/layout/app_radius.dart';
import '../../../../../core/widgets/texts.dart';
import '../../product_details_screen/product_details_screen.dart';
import 'fav_icon_widget.dart';
import 'list_categories.dart';

class StoreProviderWidget extends StatelessWidget {
  final DetailsProviderResponse providerDetails;
  const StoreProviderWidget({super.key, required this.providerDetails});

  get itemBuilder => null;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          //** list Categories */
          
          ListCategories(list: providerDetails.categories!),
          const SizedBox(
            height: 38,
          )

          //** =========== */
          ,
          const Row(
            children: [
              Texts(
                  title: "أحدث المنتجات : ",
                  family: AppFonts.taB,
                  size: 14,
                  widget: FontWeight.bold),
            ],
          ),
          const SizedBox(
            height: 18,
          ),

          //** list products */

          GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 266,
                  childAspectRatio: 1.2 / 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemCount: providerDetails.products!.length,
              itemBuilder: ((context, index) {
                Product product = providerDetails.products![index];
                return GestureDetector(
                  onTap: () {
                     pushPage(context, ProductDetailsScreen(product: product,));
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Texts(
                                  title: product.name,
                                  family: AppFonts.caR,
                                  size: 12,
                                  textColor: const Color(0xff707070),
                                  widget: FontWeight.normal),
                              Texts(
                                  title: product.description,
                                  family: AppFonts.caR,
                                  size: 10,
                                  textColor: const Color(0xff707070),
                                  widget: FontWeight.normal),
                              const Spacer(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Texts(
                                      title: "السعر  : ",
                                      family: AppFonts.caR,
                                      size: 12,
                                      textColor: Color(0xff707070),
                                      widget: FontWeight.normal),
                                  Texts(
                                      title: product.price.toString(),
                                      family: AppFonts.caM,
                                      size: 14,
                                      textColor: Colors.black,
                                      widget: FontWeight.normal),
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
                                        if (CartCubit.get(context)
                                            .cartsFound
                                            .containsValue(product.id)) {
                                          pushPageRoutName(context, cart);
                                        } else {
                                          CartModel cartModel = CartModel(
                                              id: 0,
                                              userId: currentUser.id!,
                                              productId: product.id,
                                              providerId: product.providerId,
                                              quantity: 1,
                                              status: 0,
                                              orderId: 0,
                                              cost: 0,
                                              createdAt: "createdAt");
                                          CartCubit.get(context)
                                              .addCart(cartModel);
                                        }
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                          // onPressed == null ? Palette.kGreyColor : Palette.mainColor,
                                          const Color(0xff000000),
                                        ),
                                        elevation:
                                            MaterialStateProperty.all(10),
                                        shape:
                                            MaterialStateProperty.resolveWith(
                                                (states) {
                                          if (!states.contains(
                                              MaterialState.pressed)) {
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
                                      child: Center(
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CartCubit.get(context)
                                                    .cartsFound
                                                    .containsValue(product.id)
                                                ? const SizedBox()
                                                : SvgPicture.asset(
                                                    "assets/icons/cart_item.svg"),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              CartCubit.get(context)
                                                      .cartsFound
                                                      .containsValue(product.id)
                                                  ? "أكمل الطلب"
                                                  : "اضف للسلة",
                                              style: context.titleM.copyWith(
                                                fontSize: 12,
                                                // height: .8,
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal,
                                                fontFamily: AppFonts.caSi,
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
              }))

          //** =========== */
        ],
      ),
    );
  }
}

