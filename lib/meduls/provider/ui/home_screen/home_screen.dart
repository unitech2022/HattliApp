
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatlli/core/widgets/icon_alert_widget.dart';
import 'package:hatlli/meduls/common/bloc/home_cubit/home_cubit.dart';
import 'package:hatlli/meduls/common/models/product.dart';
import 'package:quiver/iterables.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/layout/app_fonts.dart';
import '../../../../core/widgets/texts.dart';
import '../../../user/ui/components/search_container_widget.dart';
import '../../../user/ui/product_details_screen/product_details_screen.dart';
import '../../../user/ui/search_products_screen/search_products_screen.dart';
import 'components/list_orders_provider.dart';
import 'components/list_product_provider.dart';

class HomeProviderScreen extends StatefulWidget {
  const HomeProviderScreen({super.key});

  @override
  State<HomeProviderScreen> createState() => _HomeProviderScreenState();
}

class _HomeProviderScreenState extends State<HomeProviderScreen> {

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          List<List<Product>> lists = [];
          if (state.homeResponseProvider!.products!.isNotEmpty) {
            lists =
                partition(state.homeResponseProvider!.products!, 2).toList();
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                 ContainerSearchWidget(text:"" ,onTap: (value) {
                 FocusManager.instance.primaryFocus?.unfocus();
                            pushPage(context,
                                SearchProductsScreen(textSearch: value,type: 1,));
                 },),
                const SizedBox(
                  height: 30,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // ** status Account
                      StatusAccountText(
                        image: state.homeResponseProvider!.provider!.status == 0
                            ? "assets/icons/review.svg"
                            : "assets/icons/success.svg",
                        title: state.homeResponseProvider!.provider!.status == 0
                            ? "حسابك قيد المراجعة"
                            : "تم تفعيل الحساب",
                        textColor:
                            state.homeResponseProvider!.provider!.status == 0
                                ? Colors.red
                                : Colors.green,
                      )
                      //** ====== */
                      ,
                      const SizedBox(
                        height: 45,
                      ),
                      // title
                      state.homeResponseProvider!.products!.isEmpty
                          ? const SizedBox()
                          : const RowTitleProducts(),
                      const SizedBox(
                        height: 18,
                      ),
                       ListProductsWidget(list:lists),
                      const SizedBox(
                        height: 10,
                      ),
                       IndicatorWidget(state.currentPageSlider, lists.length),
                      const SizedBox(
                        height: 23,
                      ),
                      state.homeResponseProvider!.orders!.isEmpty
                          ? const SizedBox()
                          : const Row(
                              children: [
                                Texts(
                                    title: "الطلبات",
                                    family: AppFonts.taB,
                                    size: 18),
                              ],
                            ),
                      const SizedBox(
                        height: 11,
                      ),

                      //*** list Orders */
                      ListOrdersProvider(orders: state.homeResponseProvider!.orders!.where((element) => element.order.status==0).toList())
                    ],
                  ),
                ))
              ],
            ),
          );
        },
      ),
    );
  }
}



class RowTitleProducts extends StatelessWidget {
  const RowTitleProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Texts(title: "منتجاتك", family: AppFonts.taB, size: 18),
        InkWell(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset("assets/icons/edit.svg"),
              const SizedBox(
                width: 10,
              ),
              const Texts(
                title: "تعديل التصنيفات",
                family: AppFonts.taM,
                size: 12,
                textColor: Color(0xffFFA827),
              )
            ],
          ),
        )
      ],
    );
  }
}

class StatusAccountText extends StatelessWidget {
  final String image, title;
  final Color textColor;
  const StatusAccountText({
    super.key,
    required this.image,
    required this.title,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          image,
        ),
        const SizedBox(
          width: 5,
        ),
        Texts(
            title: title, family: AppFonts.taB, size: 12, textColor: textColor)
      ],
    );
  }
}

//** app bar widget */
AppBar appBarWidget({scaffolded, title,context,countNoty=0}) => AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: GestureDetector(
          onTap: () {
            scaffolded.currentState!.openDrawer();
          },
          child: Padding(
              padding: const EdgeInsets.all(15),
              child: SvgPicture.asset(
                "assets/icons/menu.svg",
                height: 17,
                width: 26,
              ))),
      title: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Texts(
            title: title,
            family: AppFonts.taB,
            size: 18,
            widget: FontWeight.bold),
      ),
      actions: [
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 10),
              child: SvgPicture.asset("assets/icons/fillter2.svg"),
            ),
            const SizedBox(
              width: 10,
            ),
             IconAlertWidget()
          ],
        ),
      ],
    );
