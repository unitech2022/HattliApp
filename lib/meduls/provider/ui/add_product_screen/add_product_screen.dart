import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatlli/core/enums/loading_status.dart';
import 'package:hatlli/core/helpers/helper_functions.dart';
import 'package:hatlli/core/layout/app_fonts.dart';
import 'package:hatlli/core/utils/app_model.dart';
import 'package:hatlli/core/widgets/custom_button.dart';
import 'package:hatlli/core/widgets/texts.dart';
import 'package:hatlli/meduls/common/bloc/product_cubit/product_cubit.dart';
import 'package:hatlli/meduls/common/models/category.dart';
import 'package:hatlli/meduls/common/models/product.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import '../../../../core/widgets/circular_progress.dart';
import '../../../../core/widgets/text_field_widget.dart';

class AddProductScreen extends StatefulWidget {
  final int type;
  final Product? product;
  const AddProductScreen({super.key, this.type = 0, this.product});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _controllerName = TextEditingController();
  final _controllerPrice = TextEditingController();
  final _controllerDesc = TextEditingController();
  final _controllerDiscount = TextEditingController();

  final _controllerColors = TextEditingController();
  final _controllerSizes = TextEditingController();
  final _controllerMarka = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ProductCubit.get(context).emptyListImages();
    if (widget.type == 1) {
      ProductCubit.get(context).getDataProductForUpdate(
          widget.product!.categoryId,
          widget.product!.sizes,
          widget.product!.calories,
          widget.product!.images,
          widget.product!.discount == 0 ? false : true);
      _controllerDesc.text = widget.product!.description;

      _controllerName.text = widget.product!.name;
      _controllerPrice.text = widget.product!.price.toString();
      _controllerDiscount.text = widget.product!.discount.toString();

      _controllerColors.text = widget.product!.calories;
      _controllerSizes.text = widget.product!.sizes;
      _controllerMarka.text = widget.product!.brandId;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerName.dispose();
    _controllerPrice.dispose();
    _controllerDesc.dispose();

    _controllerDiscount.dispose();
    _controllerSizes.dispose();
    _controllerMarka.dispose();
    _controllerColors.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
                onPressed: () {
                  pop(context);
                },
                icon: const Icon(Icons.arrow_back)),
            title: Texts(
                title: widget.type == 0 ? "إضافة منتج جديد".tr() : "تعديل المنتج".tr(),
                family: AppFonts.taB,
                size: 20),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextFieldWidget(
                    controller: _controllerName,
                    hint: "اسم المنتج".tr(),
                    icon: const SizedBox(),
                    type: TextInputType.text,
                    family: AppFonts.moS,
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  FieldAddProduct(
                    title: "الفئة".tr(),
                    onTap: () {
                      showBottomSheetWidget(
                          context,
                          Container(
                            padding: const EdgeInsets.only(
                                top: 40, left: 30, right: 30, bottom: 20),
                            decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15))),
                            height: 350,
                            width: double.infinity,
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                   Texts(
                                      title: "الأقسام".tr(),
                                      family: AppFonts.taB,
                                      size: 18),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Expanded(
                                      child: ListView.builder(
                                          itemCount: categories.length,
                                          itemBuilder: (ctx, index) {
                                            CategoryModel categoryModel =
                                                categories[index];
                                            return GestureDetector(
                                              onTap: () {
                                                ProductCubit.get(context)
                                                    .changeCurrentCategory(
                                                        categoryModel);
                                                pop(context);
                                              },
                                              child: Container(
                                                height: 60,
                                                alignment: Alignment.center,
                                                decoration: const BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            color:
                                                                Colors.black45,
                                                            width: .8))),
                                                child: Row(
                                                  children: [
                                                    Texts(
                                                        title:
                                                            categoryModel.name,
                                                        family: AppFonts.taM,
                                                        size: 15),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }))
                                ]),
                          ));
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Texts(
                          title: state.categoryModel == null
                              ? categories[0].name
                              : state.categoryModel!.name,
                          family: AppFonts.taM,
                          size: 12,
                          textColor: const Color(0xff838383),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Icon(Icons.arrow_drop_down_rounded)
                      ],
                    ),
                  ),
                  
                  const SizedBox(
                    height: 11,
                  ),
                  state.categoryModel == null ||
                          state.categoryModel!.status == 0
                      ? SizedBox()
                      : TextFieldWidget(
                          controller: _controllerMarka,
                          hint: "الماركة التجارية".tr(),
                          icon: const SizedBox(),
                          type: TextInputType.text,
                          family: AppFonts.moS,
                        ),

                  // FieldAddProduct(
                  //     title: "الماركة التجارية",
                  //     onTap: () {
                  //       showBottomSheetWidget(
                  //           context,
                  //           Container(
                  //             padding: const EdgeInsets.only(
                  //                 top: 40, left: 30, right: 30, bottom: 20),
                  //             decoration: const BoxDecoration(
                  //                 color: Colors.white,
                  //                 borderRadius: BorderRadius.only(
                  //                     topLeft: Radius.circular(15),
                  //                     topRight: Radius.circular(15))),
                  //             height: 350,
                  //             width: double.infinity,
                  //             child: Column(
                  //                 mainAxisSize: MainAxisSize.min,
                  //                 children: [
                  //                   const Texts(
                  //                       title: "الماركة التجارية",
                  //                       family: AppFonts.taB,
                  //                       size: 18),
                  //                   const SizedBox(
                  //                     height: 20,
                  //                   ),
                  //                   Expanded(
                  //                       child: ListView.builder(
                  //                           itemCount: brands.length,
                  //                           itemBuilder: (ctx, index) {
                  //                             String brand = brands[index];
                  //                             return GestureDetector(
                  //                               onTap: () {
                  //                                 ProductCubit.get(context)
                  //                                     .selectOptionProduct(
                  //                                         brand, 0);
                  //                                 pop(context);
                  //                               },
                  //                               child: Container(
                  //                                 height: 60,
                  //                                 alignment: Alignment.center,
                  //                                 decoration: const BoxDecoration(
                  //                                     border: Border(
                  //                                         bottom: BorderSide(
                  //                                             color:
                  //                                                 Colors.black45,
                  //                                             width: .8))),
                  //                                 child: Row(
                  //                                   children: [
                  //                                     Texts(
                  //                                         title: brand,
                  //                                         family: AppFonts.taM,
                  //                                         size: 15),
                  //                                   ],
                  //                                 ),
                  //                               ),
                  //                             );
                  //                           }))
                  //                 ]),
                  //           ));
                  //     },
                  //     child: Row(
                  //       mainAxisSize: MainAxisSize.min,
                  //       children: [
                  //         Texts(
                  //             title:
                  //                 state.marka == null ? brands[0] : state.marka!,
                  //             family: AppFonts.taM,
                  //             size: 12,
                  //             textColor: const Color(0xff838383)),
                  //         const SizedBox(
                  //           width: 20,
                  //         ),
                  //         const Icon(Icons.arrow_drop_down_rounded)
                  //       ],
                  //     ),
                  //   ),

                  SizedBox(
                    height: state.categoryModel == null ||
                            state.categoryModel!.status == 0
                        ? 0
                        : 11,
                  ),

                  // ** select aColors
                  state.categoryModel == null ||
                          state.categoryModel!.status == 0
                      ? SizedBox()
                      : TextFieldWidget(
                          controller: _controllerColors,
                          hint: "الألوان المتوفرة".tr(),
                          icon: const SizedBox(),
                          type: TextInputType.text,
                          family: AppFonts.moS,
                        )

                  //  FieldAddProduct(
                  //   title: "الألوان المتوفرة",
                  //   onTap: () {
                  //     showBottomSheetWidget(context,
                  //         StatefulBuilder(builder: (context, statte) {
                  //       return Container(
                  //         padding: const EdgeInsets.only(
                  //             top: 40, left: 30, right: 30, bottom: 20),
                  //         decoration: const BoxDecoration(
                  //             color: Colors.white,
                  //             borderRadius: BorderRadius.only(
                  //                 topLeft: Radius.circular(15),
                  //                 topRight: Radius.circular(15))),
                  //         height: 500,
                  //         width: double.infinity,
                  //         child:
                  //             Column(mainAxisSize: MainAxisSize.min, children: [
                  //           const Texts(
                  //               title: "الألوان",
                  //               family: AppFonts.taB,
                  //               size: 18),
                  //           const SizedBox(
                  //             height: 20,
                  //           ),
                  //           Expanded(
                  //               child: ListView.builder(
                  //                   itemCount: colorsList.length,
                  //                   itemBuilder: (ctx, index) {
                  //                     ColorModel colorModel = colorsList[index];
                  //                     return ListTile(
                  //                       leading: Container(
                  //                         height: 25,
                  //                         width: 25,
                  //                         decoration: BoxDecoration(
                  //                             color: colorModel.color,
                  //                             shape: BoxShape.circle),
                  //                       ),
                  //                       title: Text(
                  //                         colorModel.name,
                  //                         style: const TextStyle(
                  //                           fontWeight: FontWeight.w500,
                  //                         ),
                  //                       ),
                  //                       trailing: colorModel.isSelector
                  //                           ? Icon(
                  //                               Icons.check_circle,
                  //                               color: Colors.green[700],
                  //                             )
                  //                           : const Icon(
                  //                               Icons.check_circle_outline,
                  //                               color: Colors.grey,
                  //                             ),
                  //                       onTap: () {
                  //                         //01287734357

                  //                         statte(() {
                  //                           ProductCubit.get(context)
                  //                               .selectColor(index);
                  //                         });
                  //                       },
                  //                     );
                  //                   })),
                  //           ProductCubit.get(context).selectedColors.isNotEmpty
                  //               ? Padding(
                  //                   padding: const EdgeInsets.symmetric(
                  //                     horizontal: 25,
                  //                     vertical: 10,
                  //                   ),
                  //                   child: SizedBox(
                  //                     width: double.infinity,
                  //                     child: MaterialButton(
                  //                       shape: RoundedRectangleBorder(
                  //                           borderRadius:
                  //                               BorderRadius.circular(8)),
                  //                       height: 45,
                  //                       color: Palette.mainColor,
                  //                       child: Center(
                  //                         child: Text(
                  //                           "تم اختيار (${ProductCubit.get(context).selectedColors.length})",
                  //                           style: const TextStyle(
                  //                             color: Colors.white,
                  //                             fontSize: 18,
                  //                           ),
                  //                         ),
                  //                       ),
                  //                       onPressed: () {
                  //                         pop(context);
                  //                         setState(() {});
                  //                       },
                  //                     ),
                  //                   ),
                  //                 )
                  //               : Container(),
                  //         ]),
                  //       );
                  //     }));
                  //   },
                  //   child: Row(
                  //     mainAxisSize: MainAxisSize.min,
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       // ContainerColor(
                  //       //   color: Color(0xff13E395),
                  //       // ),
                  //       // SizedBox(
                  //       //   width: 2,
                  //       // ),
                  //       Texts(
                  //           title: state.colors == null ? "" : state.colors!,
                  //           family: AppFonts.taM,
                  //           size: 12,
                  //           height: .8,
                  //           textColor: const Color(0xff838383)),
                  //       // SizedBox(
                  //       //   width: 7,
                  //       // ),
                  //       // ContainerColor(
                  //       //   color: Colors.blue,
                  //       // ),
                  //       // SizedBox(
                  //       //   width: 2,
                  //       // ),
                  //       // Texts(
                  //       //   title: "ازرق",
                  //       //   family: AppFonts.taM,
                  //       //   size: 12,
                  //       //   height: .8,
                  //       //   textColor: Color(0xff838383),
                  //       // ),
                  //       const SizedBox(
                  //         width: 10,
                  //       ),
                  //       const Icon(Icons.arrow_drop_down_rounded)
                  //     ],
                  //   ),
                  // )

                  //*** sizes
                  ,
                  SizedBox(
                    height: state.categoryModel == null ||
                            state.categoryModel!.status == 0
                        ? 0
                        : 11,
                  ),
                  state.categoryModel == null ||
                          state.categoryModel!.status == 0
                      ? SizedBox()
                      : TextFieldWidget(
                          controller: _controllerSizes,
                          hint: "المقاسات المتوفرة".tr(),
                          icon: const SizedBox(),
                          type: TextInputType.text,
                          family: AppFonts.moS,
                        ),

                  //  FieldAddProduct(
                  //     title: "المقاسات المتوفرة",
                  //     onTap: () {
                  //       showBottomSheetWidget(context,
                  //           StatefulBuilder(builder: (context, statte) {
                  //         return Container(
                  //           padding: const EdgeInsets.only(
                  //               top: 40, left: 30, right: 30, bottom: 20),
                  //           decoration: const BoxDecoration(
                  //               color: Colors.white,
                  //               borderRadius: BorderRadius.only(
                  //                   topLeft: Radius.circular(15),
                  //                   topRight: Radius.circular(15))),
                  //           height: 500,
                  //           width: double.infinity,
                  //           child:
                  //               Column(mainAxisSize: MainAxisSize.min, children: [
                  //             const Texts(
                  //                 title: "المقاسات المتوفرة",
                  //                 family: AppFonts.taB,
                  //                 size: 18),
                  //             const SizedBox(
                  //               height: 20,
                  //             ),
                  //             Expanded(
                  //                 child: ListView.builder(
                  //                     itemCount: sizesList.length,
                  //                     itemBuilder: (ctx, index) {
                  //                       return ListTile(
                  //                         title: Text(
                  //                           sizesList[index].name,
                  //                           style: const TextStyle(
                  //                             fontWeight: FontWeight.w500,
                  //                           ),
                  //                         ),
                  //                         trailing: sizesList[index].isSelector
                  //                             ? Icon(
                  //                                 Icons.check_circle,
                  //                                 color: Colors.green[700],
                  //                               )
                  //                             : const Icon(
                  //                                 Icons.check_circle_outline,
                  //                                 color: Colors.grey,
                  //                               ),
                  //                         onTap: () {
                  //                           //01287734357

                  //                           statte(() {
                  //                             ProductCubit.get(context)
                  //                                 .selectSizes(index);
                  //                           });
                  //                         },
                  //                       );
                  //                     })),
                  //             ProductCubit.get(context).selectedSizes.isNotEmpty
                  //                 ? Padding(
                  //                     padding: const EdgeInsets.symmetric(
                  //                       horizontal: 25,
                  //                       vertical: 10,
                  //                     ),
                  //                     child: SizedBox(
                  //                       width: double.infinity,
                  //                       child: MaterialButton(
                  //                         shape: RoundedRectangleBorder(
                  //                             borderRadius:
                  //                                 BorderRadius.circular(8)),
                  //                         height: 45,
                  //                         color: Palette.mainColor,
                  //                         child: Center(
                  //                           child: Text(
                  //                             "تم اختيار (${ProductCubit.get(context).selectedSizes.length})",
                  //                             style: const TextStyle(
                  //                               color: Colors.white,
                  //                               fontSize: 18,
                  //                             ),
                  //                           ),
                  //                         ),
                  //                         onPressed: () {
                  //                           pop(context);
                  //                           setState(() {});
                  //                         },
                  //                       ),
                  //                     ),
                  //                   )
                  //                 : Container(),
                  //           ]),
                  //         );
                  //       }));
                  //     },
                  //     child: Row(
                  //       mainAxisSize: MainAxisSize.min,
                  //       children: [
                  //         Texts(
                  //             title: state.sizes == null ? "" : state.sizes!,
                  //             family: AppFonts.taM,
                  //             size: 12,
                  //             textColor: const Color(0xff838383)),
                  //         const SizedBox(
                  //           width: 20,
                  //         ),
                  //         const Icon(Icons.arrow_drop_down_rounded)
                  //       ],
                  //     ),
                  //   ),
                  //   //*** price
                  const SizedBox(
                    height: 11,
                  ),
                  TextFieldWidget(
                    controller: _controllerPrice,
                    hint: "سعر المنتج بعد الخصم".tr(),
                    icon: const SizedBox(),
                    type: TextInputType.datetime,
                    family: AppFonts.moS,
                  ), //*** discount
                  const SizedBox(
                    height: 11,
                  ),
                  //*** discount
                  Padding(
                    padding: EdgeInsets.only(right: 18, left: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Texts(
                            title: "هل يوجد خصم؟".tr(),
                            family: AppFonts.moS,
                            size: 12),

                        //** SWICH */
                        Transform.scale(
                          scaleX: .60,
                          scaleY: .55,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CupertinoSwitch(
                              activeColor: const Color(0xff22A45D),
                              thumbColor: Colors.white,
                              trackColor:
                                  const Color.fromARGB(255, 148, 150, 149),
                              onChanged: (value) {
                                value = !state.discount;
                                ProductCubit.get(context)
                                    .isDiscountProduct(value);
                              },
                              value: state.discount,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  state.discount
                      ? TextFieldWidget(
                          controller: _controllerDiscount,
                          hint: "سعر الخصم".tr(),
                          icon: const SizedBox(),
                          type: TextInputType.numberWithOptions(
                            decimal: true,
                            signed: false,
                          ),
                          family: AppFonts.moS,
                        )
                      : SizedBox(),
                  const SizedBox(
                    height: 27,
                  ),

                  //*** desc
                  Container(
                    padding: const EdgeInsets.only(
                        right: 25, left: 18, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xfffefefe),
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(
                          width: 1.0, color: const Color(0xfff6f6f7)),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x0f000000),
                          offset: Offset(1, 1),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: _controllerDesc,
                      keyboardType: TextInputType.multiline,
                      style: const TextStyle(
                          fontFamily: AppFonts.taM,
                          fontSize: 14,
                          color: Colors.black),
                      maxLines: 8,
                      decoration:  InputDecoration(
                        hintText: "وصف المنتج".tr(),
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            fontFamily: AppFonts.moS,
                            fontSize: 14,
                            color: Color(0xff1D1D1D)),
                      ),
                    ),
                  ),
               
                  const SizedBox(
                    height: 11,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20, left: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         Texts(
                            title: "الرجاء قم بإرفاق صور المنتج".tr(),
                            family: AppFonts.moS,
                            size: 12),
                        state.uploadImageState == RequestState.loading
                            ? const CustomCircularProgress(
                                fullScreen: false,
                                strokeWidth: 4,
                                size: Size(20, 20))
                            : MaterialButton(
                                minWidth: 60,
                                onPressed: () {
                                  ProductCubit.get(context).uploadImage();
                                },
                                child: Row(
                                  children: [
                                     Texts(
                                        title: "ارفاق".tr(),
                                        family: AppFonts.moS,
                                        size: 12),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SvgPicture.asset(
                                        "assets/icons/upload2.svg"),
                                  ],
                                ),
                              )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  //*** images
                  ListView.builder(
                      itemCount: state.images.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, index) {
                        return Container(
                          margin: const EdgeInsets.all(5),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  ProductCubit.get(context)
                                      .removeImage(state.images[index]);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Texts(
                                  title: state.images[index],
                                  family: AppFonts.moM,
                                  size: 14)
                            ],
                          ),
                        );
                      }),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: CustomButton(
                        title: widget.type == 0 ? "اضافة".tr() : "تعديل".tr(),
                        onPressed: () {
                          if (isValidate(context, state)) {
                            if (widget.type == 0) {
                              Product product = Product(
                                  id: 4,
                                  providerId: currentProvider!.id,
                                  categoryId: state.categoryModel!.id,
                                  brandId: _controllerMarka.text.isEmpty
                                      ? "not"
                                      : _controllerMarka.text,
                                  sizes: _controllerSizes.text.isEmpty
                                      ? "not"
                                      : _controllerSizes.text,
                                  calories: _controllerColors.text.isEmpty
                                      ? "not"
                                      : _controllerColors.text,
                                  name: _controllerName.text,
                                  description: _controllerDesc.text,
                                  images: state.images.join("#"),
                                  price: state.discount
                                      ? double.parse(_controllerPrice.text) -
                                          double.parse(_controllerDiscount.text)
                                      : double.parse(_controllerPrice.text),
                                  discount: state.discount
                                      ? double.parse(_controllerDiscount.text)
                                      : 0.0,
                                  status: 0,
                                  rate: 0.0,
                                  createdAt: "");
                              ProductCubit.get(context)
                                  .addProduct(product, context);
                            } else {
                              Product product = Product(
                                  id: widget.product!.id,
                                  providerId: widget.product!.id,
                                  categoryId: state.categoryModel!.id,
                                  brandId: _controllerMarka.text.isEmpty
                                      ? "not"
                                      : _controllerMarka.text,
                                  sizes: _controllerSizes.text.isEmpty
                                      ? "not"
                                      : _controllerSizes.text,
                                  calories: _controllerColors.text.isEmpty
                                      ? "not"
                                      : _controllerColors.text,
                                  name: _controllerName.text,
                                  description: _controllerDesc.text,
                                  images: state.images.join("#"),
                                  price: state.discount
                                      ? double.parse(_controllerPrice.text) -
                                          double.parse(_controllerDiscount.text)
                                      : double.parse(_controllerPrice.text),
                                  discount: state.discount
                                      ? double.parse(_controllerDiscount.text)
                                      :0,
                                  status: widget.product!.status,
                                  rate: widget.product!.rate,
                                  createdAt: widget.product!.createdAt);
                              ProductCubit.get(context)
                                  .updateProduct(product, context);
                            }
                          }
                        }),
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bool isValidate(BuildContext context, ProductState state) {
    if (_controllerName.text.isEmpty || _controllerName.text == "") {
      showTopMessage(
          context: context,
          customBar:  CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: "اكتب اسم المنتج".tr(),
            textStyle: TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));
      return false;
    } else if (state.categoryModel == null) {
      showTopMessage(
          context: context,
          customBar:  CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: "اختار الفئة".tr(),
            textStyle: TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));
      return false;
    } 
    // else if (state.marka == null) {
    //   showTopMessage(
    //       context: context,
    //       customBar: const CustomSnackBar.error(
    //         backgroundColor: Colors.red,
    //         message: "اختار الماركة التجارية",
    //         textStyle: TextStyle(
    //             fontFamily: "font", fontSize: 16, color: Colors.white),
    //       ));
    //   return false;
    // } 
    
    else if (_controllerPrice.text.isEmpty || _controllerPrice.text == "") {
      showTopMessage(
          context: context,
          customBar:  CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: "اكتب سعر المنتج".tr(),
            textStyle: TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));
      return false;
    } else if (state.discount && _controllerDiscount.text.isEmpty) {
      showTopMessage(
          context: context,
          customBar:  CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: "اكتب سعر الخصم".tr(),
            textStyle: TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));
      return false;
    } else if (_controllerDesc.text.isEmpty || _controllerDesc.text == "") {
      showTopMessage(
          context: context,
          customBar:  CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: "اكتب وصف المنتج".tr(),
            textStyle: TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));
      return false;
    } else if (state.images.isEmpty) {
      showTopMessage(
          context: context,
          customBar:  CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: "اختار صورة للمنتج علي الاقل ".tr(),
            textStyle: TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));
      return false;
    } else {
      return true;
    }
  }
}

class ContainerColor extends StatelessWidget {
  final Color color;
  const ContainerColor({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15,
      width: 15,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class FieldAddProduct extends StatelessWidget {
  final String title;
  final Widget child;
  final void Function() onTap;
  const FieldAddProduct({
    super.key,
    required this.title,
    required this.child,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        padding: const EdgeInsets.only(right: 25, left: 18),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xfffefefe),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(width: 1.0, color: const Color(0xfff6f6f7)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0f000000),
              offset: Offset(1, 1),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Texts(title: title, family: AppFonts.moS, size: 12),
            child
          ],
        ),
      ),
    );
  }
}
