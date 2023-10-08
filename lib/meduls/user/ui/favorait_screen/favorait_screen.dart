import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hatlli/core/helpers/helper_functions.dart';
import 'package:hatlli/core/widgets/icon_alert_widget.dart';
import 'package:hatlli/meduls/user/bloc/favoraite_cubit/favoraite_cubit.dart';
import 'package:hatlli/meduls/user/models/favoraite.dart';

import '../../../../core/enums/loading_status.dart';
import '../../../../core/layout/app_fonts.dart';
import '../../../../core/layout/palette.dart';
import '../../../../core/utils/api_constatns.dart';
import '../../../../core/widgets/back_button.dart';
import '../../../../core/widgets/circular_progress.dart';
import '../../../../core/widgets/empty_list_widget.dart';
import '../../../../core/widgets/texts.dart';
import '../product_details_screen/product_details_screen.dart';

class FavoriteScreen extends StatefulWidget {
  FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  // final scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FavoriteCubit.get(context).getFavorites(isState: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: scaffoldkey,
      // drawer: const DrawerWidget(),
      appBar: AppBar(
        backgroundColor: const Color(0xffFEFEFE),
        elevation: 0,
        leading:BackButtonWidget(),
        title: const Texts(
            title: "المفضلة",
            family: AppFonts.taB,
            size: 18,
            widget: FontWeight.bold),
        actions: [
         IconAlertWidget()
        ],
      ),
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          return state.getFavState == RequestState.loaded
              ? state.favorites.isEmpty
                  ? const EmptyListWidget(
                      message: "لا توجد عناصر في المفضلة ",
                    )
                  : ListView.builder(
                      itemCount: state.favorites.length,
                      padding: const EdgeInsets.all(20),
                      itemBuilder: (ctx, index) {
                        FavoriteResponse favoriteResponse =
                            state.favorites[index];
                        return GestureDetector(
                          onTap: () {
                            pushPage(
                                context,
                                ProductDetailsScreen(
                                  product: favoriteResponse.product,
                                ));
                          },
                          child: Container(
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
                                      borderRadius: BorderRadius.circular(15)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      height: 60,
                                      width: 60,
                                      placeholder: (context, url) => Image.asset("assets/images/logo_black.png"),
                                      errorWidget: (context, url, error) => Image.asset("assets/images/logo_black.png"),
                                        imageUrl: ApiConstants.imageUrl(
                                            favoriteResponse.product.images
                                                .split("#")[0])),
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
                                        title: favoriteResponse.product.name,
                                        family: AppFonts.taB,
                                        size: 14),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                              "${favoriteResponse.product.price} SAR",
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
                                      title:
                                          favoriteResponse.product.description,
                                      family: AppFonts.caSi,
                                      size: 11,
                                      textColor: const Color(0xff2B2A2A),
                                    )
                                  ],
                                )),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        FavoriteCubit.get(context).deleteFav(
                                            favId: favoriteResponse.favorite.id,
                                            context: context);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: const Icon(
                                          Icons.close,
                                          size: 15.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    // Row(
                                    //   children: [
                                    //     Container(
                                    //       height: 22,
                                    //       width: 22,
                                    //       decoration: const BoxDecoration(
                                    //         shape: BoxShape.circle,
                                    //         color: Palette.mainColor,
                                    //       ),
                                    //       child: const Center(
                                    //         child: Icon(
                                    //           Icons.add,
                                    //           size: 15,
                                    //           color: Colors.white,
                                    //         ),
                                    //       ),
                                    //     ),
                                    //     const SizedBox(
                                    //       width: 12,
                                    //     ),
                                    //     const Texts(
                                    //         title: "1", family: AppFonts.moM, size: 15),
                                    //     const SizedBox(
                                    //       width: 12,
                                    //     ),
                                    //     Container(
                                    //       height: 22,
                                    //       width: 22,
                                    //       decoration: const BoxDecoration(
                                    //         shape: BoxShape.circle,
                                    //         color: Palette.mainColor,
                                    //       ),
                                    //       child: const Center(
                                    //         child: Icon(
                                    //           Icons.remove,
                                    //           size: 15,
                                    //           color: Colors.white,
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      })
              : const Center(
                  child: CustomCircularProgress(
                    fullScreen: false,
                    strokeWidth: 4,
                    size: Size(50, 50),
                  ),
                );
        },
      ),
    );
  }
}
