import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:hatlli/core/helpers/helper_functions.dart';
import 'package:hatlli/core/utils/api_constatns.dart';
import 'package:hatlli/meduls/common/bloc/home_cubit/home_cubit.dart';


import 'package:hatlli/meduls/user/ui/providers_by_category_screen/providers_by_category_screen.dart';
import '../../../../core/layout/app_fonts.dart';
import '../../../../core/layout/palette.dart';
import '../../../../core/widgets/icon_alert_widget.dart';
import '../../../../core/widgets/texts.dart';
import '../components/darwer_widget.dart';

class ProvidersScreen extends StatelessWidget {
  ProvidersScreen({super.key});
  final scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      drawer: const DrawerWidget(),
      appBar: AppBar(
        backgroundColor: const Color(0xffFEFEFE),
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              scaffoldkey.currentState!.openDrawer();
            },
            child: Padding(
                padding: const EdgeInsets.all(15),
                child: SvgPicture.asset(
                  "assets/icons/menu.svg",
                  height: 17,
                  width: 26,
                ))),
        title: const Texts(
            title: "قائمة المنتجات",
            family: AppFonts.taB,
            size: 18,
            widget: FontWeight.bold),
        actions:  [
          IconAlertWidget(),
        ],
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(22),
            child: Column(children: [
              //* container search
              Container(
                  height: 45,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
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
              Expanded(
                child: GridView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 80,
                            childAspectRatio: 1.5 / 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 8),
                    itemCount: 1 + state.homeUserResponse!.categories!.length,
                    itemBuilder: (ctx, index) {
                      return index == 0
                          ? GestureDetector(
                              onTap: () {
                                pushPage(
                                    context,
                                    ProvidersByCategoryScreen(
                                        categories:
                                            state.homeUserResponse!.categories!,
                                        id: 0));
                              },
                              child: Column(
                                children: [
                                  Container(
                                    height: 53,
                                    width: 53,
                                    decoration: const BoxDecoration(
                                        color: Color(0xffffa827),
                                        shape: BoxShape.circle),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Image.asset(
                                            "assets/images/logo_white.png"),
                                      ),
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
                                pushPage(
                                    context,
                                    ProvidersByCategoryScreen(
                                        categories:
                                            state.homeUserResponse!.categories!,
                                        id: state.homeUserResponse!
                                            .categories![index - 1].id));
                              },
                              child: Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    height: 55,
                                    width: 55,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            Color.fromARGB(255, 240, 238, 238)),
                                    child: Center(
                                      child: CachedNetworkImage(
                                          height: 45,
                                          width: 45,
                                          imageUrl: ApiConstants.imageUrl(state
                                              .homeUserResponse!
                                              .categories![index - 1]
                                              .imageUrl)),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Texts(
                                      title: state.homeUserResponse!
                                          .categories![index - 1].name,
                                      family: AppFonts.taM,
                                      size: 10,
                                      widget: FontWeight.bold),
                                ],
                              ),
                            );
                    }),
              )
            ]),
          );
        },
      ),
    );
  }
}

