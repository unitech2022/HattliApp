import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatlli/core/helpers/helper_functions.dart';
import 'package:hatlli/core/layout/app_radius.dart';
import 'package:hatlli/core/layout/app_sizes.dart';
import 'package:hatlli/core/utils/api_constatns.dart';
import 'package:hatlli/core/utils/app_model.dart';
import 'package:hatlli/core/widgets/drop_dwon_widget.dart';
import 'package:hatlli/meduls/common/bloc/home_cubit/home_cubit.dart';
import 'package:hatlli/meduls/common/models/provider.dart';
import 'package:hatlli/meduls/user/ui/components/search_container_widget.dart';
import 'package:hatlli/meduls/user/ui/details_provider_screen/details_provider_screen.dart';
import 'package:hatlli/meduls/user/ui/providers_by_category_screen/providers_by_category_screen.dart';
import 'package:hatlli/meduls/user/ui/search_products_screen/search_products_screen.dart';
import '../../../../core/layout/app_fonts.dart';
import '../../../../core/layout/palette.dart';

import '../../../../core/widgets/texts.dart';

class ProvidersScreen extends StatefulWidget {
  ProvidersScreen({super.key});

  @override
  State<ProvidersScreen> createState() => _ProvidersScreenState();
}

class _ProvidersScreenState extends State<ProvidersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(
              left: 22,
              right: 22,
              top: 100,
            ),
            child: Column(children: [
              //* container search
              ContainerSearchWidget(
                  text: "",
                  onTap: (value) {
                    FocusManager.instance.primaryFocus?.unfocus();

                    pushPage(context, SearchProductsScreen(textSearch: value));
                  }),
              // * ============
              const SizedBox(
                height: 25,
              ),
              ListCategoryProvider(
                categories: categories,
                padding: 0,
                providers: state.homeUserResponse!.providers!,
              ),

              SizedBox(
                height: 15,
              ),
              Divider(),

              SizedBox(
                height: 15,
              ),
              TitleListProviders(
                onTap: () {
                  showBottomSheetWidget(
                      context,
                      SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Container(
                              padding: const EdgeInsets.only(
                                  top: 32, left: 18, right: 18),
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(25),
                                      topRight: Radius.circular(25)),
                                  color: Colors.white),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(),
                                      Texts(
                                          title: "فرز المزودين".tr(),
                                          family: AppFonts.taB,
                                          size: 16,
                                          textColor: Colors.black,
                                          widget: FontWeight.normal),
                                      IconButton(
                                          onPressed: () {
                                            pop(context);
                                          },
                                          icon: Icon(
                                            Icons.close,
                                            color: Colors.black,
                                          ))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffffffff),
                                      borderRadius: BorderRadius.circular(6.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0x0d000000),
                                          offset: Offset(0, 0),
                                          blurRadius: 3,
                                        ),
                                      ],
                                    ),
                                    child: CustomDropDownWidget(
                                        currentValue: HomeCubit.get(context).sortModel,
                                        selectCar: false,
                                        textColor: const Color(0xff28436C),
                                        isTwoIcons: false,
                                        iconColor: const Color(0xff515151),
                                        list: sortRateList,
                                        onSelect: (value) {
                                          HomeCubit.get(context)
                                              .changeSortModel(value);
                                          print( HomeCubit.get(context).sortModel.id);
                                        },
                                        hint: "اختيار".tr()),
                                  ),
                                  const SizedBox(
                                    height: 21,
                                  ),
                                  const SizedBox(
                                    height: 31,
                                  ),
                                  SizedBox(
                                    width: 300,
                                    height: AppSize.s50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // 
                                        HomeCubit.get(context)
                                            .filleterProviders(
                                               HomeCubit.get(context).sortModel.id,
                                                state.homeUserResponse!
                                                    .providers!,0);
                                                    pop(context);
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                          // onPressed == null ? Palette.kGreyColor : Palette.mainColor,
                                          Colors.black,
                                        ),
                                        elevation:
                                            MaterialStateProperty.all(10),
                                        shape:
                                            MaterialStateProperty.resolveWith(
                                                (states) {
                                          if (!states.contains(
                                              MaterialState.pressed)) {
                                            return const RoundedRectangleBorder(
                                              borderRadius: AppRadius.r10,
                                              side: BorderSide.none,
                                            );
                                          }
                                          return const RoundedRectangleBorder(
                                            borderRadius: AppRadius.r10,
                                          );
                                        }),
                                      ),
                                      child: Text(
                                        "فرز".tr(),
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: AppFonts.taB,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 27,
                                  ),
                                ],
                              )),
                        ),
                      ));
                },
              ),
              SizedBox(
                height: 15,
              ),

              Expanded(
                  child: ListView.builder(
                      // physics: NeverScrollableScrollPhysics(),
                      // shrinkWrap: true,
                      itemCount: state.providers.length,
                      itemBuilder: (context, index) {
                        Provider provider = state.providers[index];
                        return GestureDetector(
                          onTap: () {
                            pushPage(
                                context,
                                DetailsProviderScreen(
                                  providerId: provider.id,
                                ));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 10),
                            padding: const EdgeInsets.all(14),
                            height: 100,
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
                            child: Column(
                              children: [
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Palette.mainColor,
                                              width: 1,
                                            )),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: CachedNetworkImage(
                                            imageUrl: ApiConstants.imageUrl(
                                                provider.logoCompany),
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
                                              title: provider.title,
                                              family: AppFonts.caR,
                                              size: 12),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Texts(
                                            title: provider.about,
                                            family: AppFonts.moL,
                                            size: 10,
                                            textColor: Color(0xffA9A9AA),
                                          )
                                        ],
                                      )),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Texts(
                                                  title: provider.rate
                                                      .toStringAsFixed(1),
                                                  family: AppFonts.moL,
                                                  size: 10),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              SvgPicture.asset(
                                                  "assets/icons/star.svg")
                                            ],
                                          ),
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
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SvgPicture.asset(
                                              "assets/icons/map2.svg"),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Texts(
                                            title: provider.addressName
                                                .split(",")[0] + "   , "+"يبعد عنك".tr() +  "${provider.distance.toStringAsFixed(1)} km",
                                            family: AppFonts.moL,
                                            size: 10,
                                            textColor: Color(0xffA9A9AA),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 61,
                                      height: 22,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          color: Palette.mainColor),
                                      child:  Center(
                                          child: Texts(
                                        title: "المزيد".tr(),
                                        family: AppFonts.moL,
                                        size: 10,
                                        textColor: Colors.white,
                                      )),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }))
            ]),
          );
        },
      ),
    );
  }
}
