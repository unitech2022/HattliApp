import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatlli/core/enums/loading_status.dart';
import 'package:hatlli/core/helpers/helper_functions.dart';
import 'package:hatlli/core/utils/app_model.dart';
import 'package:hatlli/core/widgets/circular_progress.dart';
import 'package:hatlli/core/widgets/empty_list_widget.dart';
import 'package:hatlli/meduls/common/bloc/product_cubit/product_cubit.dart';
import 'package:hatlli/meduls/common/models/search_product_response.dart';
import 'package:hatlli/meduls/provider/ui/home_screen/components/list_product_provider.dart';
import 'package:hatlli/meduls/user/ui/product_details_screen/product_details_screen.dart';

import '../../../../core/layout/app_fonts.dart';
import '../../../../core/layout/palette.dart';
import '../../../../core/utils/api_constatns.dart';
import '../../../../core/widgets/texts.dart';
import '../../../common/models/product.dart';
import '../components/search_container_widget.dart';

class SearchProductsScreen extends StatefulWidget {
  final String textSearch;
  final int type;
  const SearchProductsScreen(
      {super.key, required this.textSearch, this.type = 0});

  @override
  State<SearchProductsScreen> createState() => _SearchProductsScreenState();
}

class _SearchProductsScreenState extends State<SearchProductsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print(widget.textSearch + "ddd");
    ProductCubit.get(context).searchProducts(
        context: context, textSearch: widget.textSearch, type: widget.type);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFEFEFE),
        elevation: 0,
        title:  Texts(
            title: "صفحة البحث".tr(),
            family: AppFonts.taB,
            size: 18,
            widget: FontWeight.bold),
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        builder: (context, state) {
          return Padding(
            padding:
                const EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 30),
            child: Column(children: [
              ContainerSearchWidget(
                text: widget.textSearch,
                onTap: (value) {
                  if (kDebugMode) {
                    print(value);
                  }
                  FocusManager.instance.primaryFocus?.unfocus();
                  ProductCubit.get(context)
                      .searchProducts(context: context, textSearch: value,type: widget.type);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: state.searchProductsState == RequestState.loaded
                    ? state.searchProducts.isEmpty
                        ?  EmptyListWidget(
                            message: "لا توجد نتائج لبحثك".tr())
                        : currentUser.role == AppModel.userRole
                            ? ListView.builder(
                                itemCount: state.searchProducts.length,
                                itemBuilder: (ctx, index) {
                                  SearchProductResponse
                                      searchProductResponse =
                                      state.searchProducts[index];

                                  return GestureDetector(
                                    onTap: () {
                                      pushPage(
                                          context,
                                          ProductDetailsScreen(
                                              product: searchProductResponse
                                                  .product));
                                    },
                                    child: Container(
                                      margin:
                                          const EdgeInsets.only(bottom: 10),
                                      padding: const EdgeInsets.all(14),
                                      height: 100,
                                      decoration: BoxDecoration(
                                        color: const Color(0xffffffff),
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color(0x29b6b6b6),
                                            offset: Offset(0, 0),
                                            blurRadius: 10,
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50),
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        ApiConstants.imageUrl(
                                                            searchProductResponse
                                                                .product
                                                                .images
                                                                .split(
                                                                    "#")[0]),
                                                    height: 26,
                                                    width: 26,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Expanded(
                                                    child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    Texts(
                                                        title:
                                                            searchProductResponse
                                                                .product.name,
                                                        family: AppFonts.caR,
                                                        size: 12),
                                                    const SizedBox(
                                                      height: 4,
                                                    ),
                                                    Texts(
                                                      title:
                                                          searchProductResponse
                                                              .provider.title,
                                                      family: AppFonts.moL,
                                                      size: 10,
                                                      textColor:
                                                          Color(0xffA9A9AA),
                                                    )
                                                  ],
                                                )),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .center,
                                                  children: [
                                                    Texts(
                                                        title: searchProductResponse
                                                                .product.price
                                                                .toString() +
                                                            " SAR".toString(),
                                                        family: AppFonts.taB,
                                                        textColor:
                                                            Palette.mainColor,
                                                        size: 13),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          const Divider(
                                            height: .8,
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    SvgPicture.asset(
                                                        "assets/icons/map2.svg"),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Texts(
                                                      title:
                                                          searchProductResponse
                                                              .provider
                                                              .addressName
                                                              .split(",")[0],
                                                      family: AppFonts.moL,
                                                      size: 10,
                                                      textColor:
                                                          Color(0xffA9A9AA),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Texts(
                                                  title:
                                                     "يبعد عنك".tr() +"${searchProductResponse.provider.discount} km",
                                                  family: AppFonts.moM,
                                                  size: 12,
                                                  textColor: Color.fromARGB(
                                                      255, 95, 95, 95),
                                                  widget: FontWeight.normal)
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                })
                            : GridView.builder(
                                padding: const EdgeInsets.only(
                                    top: 30, bottom: 30),
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 240,
                                        childAspectRatio: 2.3 / 4,
                                        crossAxisSpacing: 5,
                                        mainAxisSpacing: 10),
                                itemCount: state.searchProducts.length,
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  Product product =
                                      state.searchProducts[index].product;
                                  return ItemProductProvider(
                                      product: product);
                                },
                              )
                    : const CustomCircularProgress(),
              )
            ]),
          );
        },
      ),
    );
  }
}
