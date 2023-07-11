import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatlli/core/enums/loading_status.dart';
import 'package:hatlli/core/layout/palette.dart';
import 'package:hatlli/core/utils/app_model.dart';
import 'package:hatlli/core/widgets/empty_list_widget.dart';
import 'package:hatlli/meduls/common/models/category.dart';
import 'package:hatlli/meduls/common/models/provider.dart';
import 'package:hatlli/meduls/provider/bloc/provider_cubit/provider_cubit.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/layout/app_fonts.dart';
import '../../../../core/utils/api_constatns.dart';
import '../../../../core/widgets/circular_progress.dart';
import '../../../../core/widgets/texts.dart';
import '../details_provider_screen/details_provider_screen.dart';

class ProvidersByCategoryScreen extends StatefulWidget {
  final List<CategoryModel> categories;
  final int id;
  const ProvidersByCategoryScreen({
    super.key,
    required this.categories,
    required this.id,
  });

  @override
  State<ProvidersByCategoryScreen> createState() =>
      _ProvidersByCategoryScreenState();
}

class _ProvidersByCategoryScreenState extends State<ProvidersByCategoryScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ProviderCubit.get(context)
        .getProvidersByCtId(catId: widget.id, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProviderCubit, ProviderState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xffFEFEFE),
              elevation: 0,
              leading: GestureDetector(
                  onTap: () {
                    pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  )),
              title: const Texts(
                  title: "السجاد",
                  family: AppFonts.taB,
                  size: 18,
                  widget: FontWeight.bold),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 20),
                  child: badges.Badge(
                    badgeContent: const Text(
                      '3',
                      style: TextStyle(color: Colors.white, height: 1.8),
                    ),
                    position: badges.BadgePosition.topStart(top: -12),
                    badgeStyle:
                        const badges.BadgeStyle(badgeColor: Palette.mainColor),
                    child: SvgPicture.asset("assets/icons/noty.svg"),
                  ),
                ),
              ],
            ),
            body: Column(children: [
              const SizedBox(
                height: 10,
              ),
              //* container search
              Container(
                  height: 45,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(82, 201, 199, 199),
                          offset: Offset(2, 2),
                          blurRadius: 5,
                        ),
                      ]),
                  child: Row(children: [
                    const Expanded(
                      child: TextField(
                          style: TextStyle(
                            fontFamily: AppFonts.taM,
                            fontSize: 14,
                            color: Color(0xff343434),
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "البحث",
                            hintStyle: TextStyle(
                              fontFamily: AppFonts.taM,
                              fontSize: 14,
                              color: Color(0xff343434),
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          color: Palette.mainColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: SvgPicture.asset("assets/icons/search.svg"),
                        ),
                      ),
                    )
                  ])),
              // * ============
              const SizedBox(
                height: 25,
              ),
              ListCategoryProvider(categories: categories),

              const SizedBox(
                height: 24,
              ),

              TitleListProviders(
                onTap: () {},
              ),
              const SizedBox(
                height: 20,
              ),

              //** list providers */
              Expanded(
                child: state.getProvidersByCatIdState == RequestState.loaded
                    ? state.providers.isEmpty
                        ? const EmptyListWidget(message: "لا يوجد مزودين")
                        : ListView.builder(
                            itemCount: state.providers.length,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            itemBuilder: (context, index) {
                              Provider provider = state.providers[index];
                              return Container(
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
                                                
                                              )
                                            ),
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
                                                  title: provider
                                                      .nameAdministratorCompany,
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
                                                          .toString(),
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
                                                    .split(",")[0],
                                                family: AppFonts.moL,
                                                size: 10,
                                                textColor: Color(0xffA9A9AA),
                                              )
                                            ],
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            pushPage(
                                                context,
                                                DetailsProviderScreen(
                                                  providerId: provider.id,
                                                ));
                                          },
                                          child: Container(
                                            width: 61,
                                            height: 22,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                                color: Palette.mainColor),
                                            child: const Center(
                                                child: Texts(
                                              title: "المزيد",
                                              family: AppFonts.moL,
                                              size: 10,
                                              textColor: Colors.white,
                                            )),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              );
                            })
                    : const CustomCircularProgress(
                        fullScreen: true, strokeWidth: 4, size: Size(50, 50)),
              )
            ]));
      },
    );
  }
}

class TitleListProviders extends StatelessWidget {
  final void Function() onTap;
  const TitleListProviders({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Texts(
            title: "المزودين",
            family: AppFonts.moM,
            size: 14,
            textColor: Color(0xff4A4A4A),
          ),
          GestureDetector(
            onTap: onTap,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset("assets/icons/fillter.svg"),
                const SizedBox(
                  width: 7,
                ),
                const Texts(
                  title: "فرز",
                  family: AppFonts.caR,
                  size: 12,
                  textColor: Palette.mainColor,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ListCategoryProvider extends StatelessWidget {
  final List<CategoryModel> categories;

  const ListCategoryProvider({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 78,
      child: ListView.builder(
          padding: const EdgeInsets.only(right: 20),
          itemCount: 1 + categories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: ((context, index) {
            return index == 0
                ? GestureDetector(
                    onTap: () {
                      ProviderCubit.get(context)
                          .getProvidersByCtId(catId: 0, context: context);
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 53,
                          width: 53,
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: const BoxDecoration(
                              color: Color(0xffffa827), shape: BoxShape.circle),
                          child: Center(
                            child:
                                SvgPicture.asset("assets/icons/logo_whit.svg"),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        const Texts(
                            title: "الكل",
                            family: AppFonts.taM,
                            size: 10,
                            widget: FontWeight.bold),
                      ],
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      ProviderCubit.get(context).getProvidersByCtId(
                          catId: categories[index - 1].id, context: context);
                    },
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          height: 55,
                          width: 55,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromARGB(255, 240, 238, 238)),
                          child: Center(
                            child: CachedNetworkImage(
                                height: 45,
                                width: 45,
                                imageUrl: ApiConstants.imageUrl(
                                    categories[index - 1].imageUrl)),
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Texts(
                            title: categories[index - 1].name,
                            family: AppFonts.taM,
                            size: 10,
                            widget: FontWeight.bold),
                      ],
                    ),
                  );
          })),
    );
  }
}
