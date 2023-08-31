import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hatlli/core/extension/theme_extension.dart';
import 'package:hatlli/core/helpers/helper_functions.dart';
import 'package:hatlli/core/layout/screen_size.dart';
import 'package:hatlli/core/utils/api_constatns.dart';
import 'package:hatlli/meduls/common/bloc/home_cubit/home_cubit.dart';
import 'package:hatlli/meduls/common/models/product.dart';
import 'package:hatlli/meduls/provider/ui/add_product_screen/add_product_screen.dart';
import 'package:hatlli/meduls/user/ui/product_details_screen/product_details_screen.dart';

import '../../../../../core/layout/app_fonts.dart';
import '../../../../../core/layout/app_radius.dart';
import '../../../../../core/widgets/texts.dart';

class ListProductsWidget extends StatelessWidget {
  final List<List<Product>> list;
  const ListProductsWidget({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: list.length,
        itemBuilder: (ctx, index, page) {
          List<Product> products = list[index];
          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 245,
                childAspectRatio: 2.4 / 4,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5),
            itemCount: products.length,
            itemBuilder: (BuildContext context, int indexx) {
              Product product = products[indexx];
              return ItemProductProvider(product: product);
            },
          );
        },
        options: CarouselOptions(
            onPageChanged: (index, reason) {
              HomeCubit.get(context).changeCurrentPageSlider(index);
            },
            height: 280,
            enableInfiniteScroll: false,
            viewportFraction: 1,
            scrollDirection: Axis.horizontal));
  }
}

class ItemProductProvider extends StatelessWidget {
  final Product product;
  const ItemProductProvider({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushPage(context, ProductDetailsScreen(product: product));
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xffffffff),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(width: 0.5, color: const Color(0xffebebeb)),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 137,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15)),
                child: CachedNetworkImage(
                  imageUrl: ApiConstants.imageUrl(product.images.split("#")[0]),
                  errorWidget: (context, url, error) => Image.asset("assets/images/logo_black.png"),
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
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
                      family: AppFonts.caB,
                      size: 14,
                      textColor:  Colors.black,
                      widget: FontWeight.bold),
                  Texts(
                      line: 2,
                      title: product.description,
                      family: AppFonts.caR,
                      size: 10,
                      textColor: const Color(0xff707070),
                      widget: FontWeight.normal),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              title: "${product.price.toString()}  SAR",
                              family: AppFonts.caM,
                              size: 14,
                              textColor: Colors.black,
                              widget: FontWeight.normal),
                          product.discount>0?   Text(
                             "${(product.discount + product.price).toString()}  SAR",
                              style: TextStyle(
                                fontFamily: AppFonts.caR,
                                color: Colors.black54,
                                height: 1.2,
                                fontSize: 12,
                                decoration: TextDecoration.lineThrough,
                              ),):SizedBox(),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: context.wSize,
                    height: 28,
                    child: ElevatedButton(
                      onPressed: () {
                        pushPage(context, AddProductScreen(type: 1, product: product,));
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          // onPressed == null ? Palette.kGreyColor : Palette.mainColor,
                          const Color(0xff000000),
                        ),
                        elevation: MaterialStateProperty.all(0),
                        shape: MaterialStateProperty.resolveWith((states) {
                          if (!states.contains(MaterialState.pressed)) {
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
                        child: Text(
                          "تعديل المنتج".tr(),
                          
                          style: context.titleM.copyWith(
                            height: .8,
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontFamily: AppFonts.caSi,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
