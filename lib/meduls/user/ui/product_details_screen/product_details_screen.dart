import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:badges/badges.dart' as badges;
import 'package:hatlli/core/extension/theme_extension.dart';
import 'package:hatlli/core/layout/palette.dart';
import 'package:hatlli/core/layout/screen_size.dart';
import 'package:hatlli/core/utils/api_constatns.dart';
import 'package:hatlli/core/utils/app_model.dart';
import 'package:hatlli/meduls/common/bloc/home_cubit/home_cubit.dart';
import 'package:hatlli/meduls/common/bloc/product_cubit/product_cubit.dart';
import 'package:hatlli/meduls/common/models/product.dart';
import 'package:hatlli/meduls/user/bloc/cart_cubit/cart_cubit.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/layout/app_fonts.dart';
import '../../../../core/layout/app_radius.dart';
import '../../../../core/router/routes.dart';
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
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    images = widget.product.images.split("#");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: currentUser.role == AppModel.providerRole
          ? BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                return Container(
                  height: 80,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: context.wSize,
                          height: 50,
                          child: CustomButton(
                            title: "تعديل",
                            onPressed: () {
                               pushPage(context, AddProductScreen(type: 1, product: widget.product,));
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
                            title: "حذف",
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
                                            title:
                                                "هل أنت متأكد أنك تريد حذف  ${widget.product.name}",
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
                                                    title: "حذف",
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
                                                    title: "الغاء",
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
                );
              },
            )
          : BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
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
                                    quantity: quantity,
                                    status: 0,
                                    orderId: 0,
                                    cost: 0,
                                    createdAt: "createdAt");
                                CartCubit.get(context).addCart(cartModel);
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                // onPressed == null ? Palette.kGreyColor : Palette.mainColor,
                                const Color(0xff000000),
                              ),
                              elevation: MaterialStateProperty.all(10),
                              shape:
                                  MaterialStateProperty.resolveWith((states) {
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
                            child: CartCubit.get(context)
                                    .cartsFound
                                    .containsValue(widget.product.id)
                                ? Text(
                                    "أكمل الطلب",
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
                                        "اضف للسلة",
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
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                // onPressed == null ? Palette.kGreyColor : Palette.mainColor,
                                Palette.mainColor,
                              ),
                              elevation: MaterialStateProperty.all(10),
                              shape:
                                  MaterialStateProperty.resolveWith((states) {
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
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "شراء الآن",
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
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Texts(
            title: "تفاصيل المنتج",
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
              child: SvgPicture.asset("assets/icons/noty.svg"),
            ),
          ),
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
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          ApiConstants.imageUrl(images[index]),
                                      width: double.infinity,
                                      fit: BoxFit.fill,
                                      height: double.infinity,
                                    )),
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
                  Texts(
                      title: "${widget.product.price} SAr ",
                      family: AppFonts.taB,
                      size: 14),
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
                        const Texts(
                            title: "حدد الكمية",
                            family: AppFonts.taB,
                            size: 14),
                        Container(
                          width: 100,
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xffD6DCE0)),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    if (quantity > 1) {
                                      setState(() {
                                        quantity--;
                                      });
                                    }
                                  },
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  icon: const Icon(
                                    Icons.remove,
                                    color: Color(0xff707070),
                                    size: 20,
                                  )),
                              Texts(
                                title: "$quantity",
                                family: AppFonts.caR,
                                size: 15,
                                textColor: Color(0xff707070),
                                height: 2,
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      quantity++;
                                    });
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
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
                      child: Texts(
                        title: widget.product.description,
                        family: AppFonts.caR,
                        size: 10,
                        textColor: const Color(0xff707070),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 15,
              ),

              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xfffafbfb),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    title: const Texts(
                        title: "مزيد من التفاصيل",
                        family: AppFonts.taB,
                        size: 14),
                    children: [
                      const SizedBox(
                        height: 60,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Texts(
                                  title: "الماركة",
                                  family: AppFonts.caR,
                                  textColor: Color(0xff707070),
                                  size: 14),
                              Texts(
                                  title: "",
                                  family: AppFonts.caR,
                                  textColor: Color(0xff707070),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Texts(
                                  title: "اللون",
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
                      Container(
                        decoration: const BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    width: .8, color: Color(0xffD6DCE0)))),
                        height: 60,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Texts(
                                  title: "رمز المنتج",
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Texts(
                                  title: "التصنيفات",
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
                height: 100,
              ),
            ],
          ),
        ),
      ),
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
