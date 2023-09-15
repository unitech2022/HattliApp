import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hatlli/core/enums/loading_status.dart';
import 'package:hatlli/core/layout/app_sizes.dart';
import 'package:hatlli/core/layout/palette.dart';
import 'package:hatlli/core/widgets/circular_progress.dart';
import 'package:hatlli/meduls/common/models/provider.dart';
import 'package:hatlli/meduls/provider/bloc/provider_cubit/provider_cubit.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/layout/app_fonts.dart';
import '../../../../core/utils/api_constatns.dart';
import '../../../../core/utils/app_model.dart';
import '../../../../core/utils/strings.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/drop_dwon_widget.dart';
import '../../../../core/widgets/text_field_widget.dart';
import '../../../../core/widgets/texts.dart';

import '../../../user/ui/home_user_screen/home_user_screen.dart';
import '../add_product_screen/add_product_screen.dart';

class EditAccountProviderScreen extends StatefulWidget {
  final int providerId;
  const EditAccountProviderScreen({super.key, required this.providerId});

  @override
  State<EditAccountProviderScreen> createState() =>
      _EditAccountProviderScreenState();
}

class _EditAccountProviderScreenState extends State<EditAccountProviderScreen> {
  final _controllerAdminName = TextEditingController();

  final _controllerNameCompany = TextEditingController();

  final _controllerEmail = TextEditingController();

   final _controllerNameBank = TextEditingController();
  final _controllerIBanBank = TextEditingController();

  String? currenValue;
  @override
  void dispose() {
    super.dispose();
    _controllerAdminName.dispose();
    _controllerEmail.dispose();
    _controllerNameCompany.dispose();
    _controllerNameBank.dispose();
    _controllerIBanBank.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ProviderCubit.get(context).getProviderDetails(
        providerId: widget.providerId, context: context, isEdit: true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProviderCubit, ProviderState>(
      listener: (context, state) {
        if (state.getDetailsProviderState == RequestState.loaded) {
          _controllerAdminName.text =
              state.detailsProviderResponse!.provider!.nameAdministratorCompany;
          _controllerNameCompany.text =
              state.detailsProviderResponse!.provider!.title;
          _controllerEmail.text =
              state.detailsProviderResponse!.provider!.email;

                _controllerNameBank.text =
              state.detailsProviderResponse!.provider!.nameBunk;
          _controllerIBanBank.text =
              state.detailsProviderResponse!.provider!.iBan;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: const Color(0xffFEFEFE),
            elevation: 0,
            automaticallyImplyLeading: true,
            // leading: GestureDetector(
            //     onTap: () {
            //       scaffoldkey.currentState!.openDrawer();
            //     },

            //     child: Padding(
            //         padding: const EdgeInsets.all(15),
            //         child: SvgPicture.asset(
            //           "assets/icons/menu.svg",
            //           height: 17,
            //           width: 26,
            //         ))),
            title:  Texts(
                title: "تعديل البيانات".tr(),
                family: AppFonts.taB,
                size: 18,
                widget: FontWeight.bold),
            // actions: [
            //  IconAlertWidget()
            // ],
          ),
          body: state.getDetailsProviderState == RequestState.loaded
              ? Scaffold(
                  body: Padding(
                    padding: const EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          state.imageLogoState == RequestState.loading
                              ? const CustomCircularProgress(
                                  size: Size(AppSize.s50, AppSize.s50),
                                )
                              : CircleImageNetwork(
                                imageError: "assets/images/person2.png",
                                image:
                                    ApiConstants.imageUrl(state.imageLogo),
                                height: 66,
                                width: 66,
                                colorBackground: Palette.mainColor,
                              ),

                          const SizedBox(
                            height: 9,
                          ),
                          Texts(
                              title: state
                                  .detailsProviderResponse!.provider!.title,
                              family: AppFonts.taB,
                              size: 20,
                              textColor: Colors.black,
                              widget: FontWeight.normal),
                          const SizedBox(
                            height: 20,
                          ),

                          TitleAccountWidget(title:  "اسم الشركة".tr(),),
                          TextFieldWidget(
                            controller: _controllerNameCompany,
                            hint: "اسم الشركة".tr(),
                            icon: const SizedBox(),
                            type: TextInputType.text,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          TitleAccountWidget(title: "ايميل الشؤكة".tr(),),
                          TextFieldWidget(
                            controller: _controllerEmail,
                            hint: "ايميل الشؤكة".tr(),
                            icon: const SizedBox(),
                            type: TextInputType.text,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TitleAccountWidget(title: "الشخص المسئول".tr(),),
                          TextFieldWidget(
                            controller: _controllerAdminName,
                            hint: "الشخص المسئول".tr(),
                            icon: const SizedBox(),
                            type: TextInputType.text,
                          ),
                          const SizedBox(
                            height: 25,
                          ),

                          TitleAccountWidget(title: "صورة الاثبات".tr(),),
                          GestureDetector(
                                  onTap: () {
                                    ProviderCubit.get(context).uploadImage(1);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: const Color(0xfffefefe),
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                          width: 1.0,
                                          color: const Color(0xfff6f6f7)),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color(0x0f000000),
                                          offset: Offset(1, 1),
                                          blurRadius: 6,
                                        ),
                                      ],
                                    ),
                                    child: Column(children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                           Texts(
                                              title: "إرفاق الاثبات".tr(),
                                              family: AppFonts.taM,
                                              size: 14,
                                              textColor: Colors.black,
                                              widget: FontWeight.normal),
                                           CircleImageNetwork(height: 30, width: 30,
                              image: ApiConstants.imageUrl(state.imagePassport),
                              imageError: "", colorBackground: Colors.white)
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      // Row(
                                      //   children: [
                                      //     Texts(
                                      //         title: state.imagePassport!,
                                      //         // "(الرخصة التجارية -الشهادة الضريبية - صورة الجواز - الهوية)",
                                      //         family: AppFonts.taM,
                                      //         size: 10,
                                      //         textColor:
                                      //             const Color(0xff292626),
                                      //         widget: FontWeight.normal),
                                      //   ],
                                      // ),
                                  
                                    ]),
                                  ),
                                ),
                          const SizedBox(
                            height: 25,
                          ),

                          //** logo company  */
                          GestureDetector(
                            onTap: (){
                            ProviderCubit.get(context).uploadImage(0);
                            },
                            child: Container(
                              height: 66,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                   Texts(
                                      title: "إرفاق شعار الشركة".tr(),
                                      family: AppFonts.taM,
                                      size: 14,
                                      textColor: Colors.black,
                                      widget: FontWeight.normal),
                                   CircleImageNetwork(height: 30, width: 30,
                              image: ApiConstants.imageUrl( state.imageLogo),
                              imageError: "", colorBackground: Colors.white)
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TitleAccountWidget(title: "التصنيف".tr(),),
                          Container(
                            height: 62,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 20),
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
                            child: CustomDropDownWidget(
                                currentValue: state.categoryModel,
                                selectCar: false,
                                textColor: const Color(0xff28436C),
                                isTwoIcons: false,
                                iconColor: const Color(0xff515151),
                                list: categories,
                                onSelect: (value) {
                                  print(value.id.toString());
                                  ProviderCubit.get(context)
                                      .changeCurrentCategory(value);
                                },
                                hint: state.categoryModel != null
                                    ? state.categoryModel!.name
                                    : "اختيار الخدمة التي تقدمها".tr()),
                          ),
                          const SizedBox(
                            height: 15,
                          ),

// ** area
                          TitleAccountWidget(title: "النطاق".tr(),),
                          FieldAddProduct(
                            title: state.area != null
                                ? state.area.toString() + " KG "
                                : "النطاق".tr(),
                            onTap: () {
                              showBottomSheetWidget(
                                  context,
                                  Container(
                                    padding: const EdgeInsets.only(
                                        top: 40,
                                        left: 30,
                                        right: 30,
                                        bottom: 20),
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(15))),
                                    height: 600,
                                    width: double.infinity,
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                           Texts(
                                              title:
                                                  "حدد النطاق الذى تريد البيع فيه".tr(),
                                              family: AppFonts.taB,
                                              size: 18),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          Expanded(
                                              child: ListView.builder(
                                                  itemCount: areas.length,
                                                  itemBuilder: (ctx, index) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        ProviderCubit.get(
                                                                context)
                                                            .changeArea(
                                                                areas[index]);
                                                        pop(context);
                                                        
                                                      },
                                                      child: Container(
                                                        height: 60,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration: const BoxDecoration(
                                                            border: Border(
                                                                bottom: BorderSide(
                                                                    color: Colors
                                                                        .black45,
                                                                    width:
                                                                        .8))),
                                                        child: Row(
                                                          children: [
                                                            Texts(
                                                                title: areas[
                                                                            index]
                                                                        .toString() +
                                                                    " KM",
                                                                family: AppFonts
                                                                    .taM,
                                                                size: 15),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  }))
                                        ]),
                                  ));
                            },
                            child: SizedBox(),
                          ),

   // ** data bank
                      const SizedBox(
                        height: 25,
                      ),

                      Texts(
                          title: "بيانات البنك".tr(),
                          family: AppFonts.taB,
                          size: 20,
                          textColor: Colors.black,
                          widget: FontWeight.w700),

                 //** */ name Bank
                      const SizedBox(
                        height: 15,
                      ),
                 TitleAccountWidget(title: "اسم البنك".tr(),),
                      TextFieldWidget(
                        controller: _controllerNameBank,
                        hint: "اسم البنك".tr(),
                        icon: const SizedBox(),
                        type: TextInputType.text,
                      ),
                  

                        const SizedBox(
                        height: 25,
                      ),
                 TitleAccountWidget(title: "IBan".tr(),),
                      TextFieldWidget(
                        controller: _controllerIBanBank,
                        hint: "اسم البنك".tr(),
                        icon: const SizedBox(),
                        type: TextInputType.text,
                      ),
                  
                  
                     
                          const SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: CustomButton(
                                title: Strings.save.tr(),
                                onPressed: () {
                                  if (validate(context, state)) {
                                    Provider provider = Provider(
                                        id: widget.providerId,
                                        area: state.area!,
                                        password: "",
                                        iBan: _controllerIBanBank.text,
                                        nameBunk: _controllerNameBank.text,
                                        categoryId: state.categoryModel!.id,
                                        title: _controllerNameCompany.text,
                                        email: _controllerEmail.text,
                                        userId: currentUser.id!,
                                        about: "about",
                                        logoCompany: state.imageLogo!,
                                        imagePassport: state.imagePassport!,
                                        nameAdministratorCompany:
                                            _controllerAdminName.text,
                                        addressName: "addressName",
                                        lat: 0,
                                        lng: 0,
                                        rate: 0,
                                        status: 0,
                                        manualOrder: state.detailsProviderResponse!
                                            .provider!.manualOrder,
                                        discount: 0,
                                        distance: 0,
                                        wallet: state.detailsProviderResponse!
                                            .provider!.wallet,
                                        createdAt: "");
                                    ProviderCubit.get(context).updateProvider(
                                        provider,
                                        context: context);
                                  }
                                }),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : const CustomCircularProgress(
                  fullScreen: true,
                  color: Palette.mainColor,
                ),
        );
      },
    );
  }

  bool validate(BuildContext context, ProviderState state) {
    if (_controllerNameCompany.text.isEmpty ||
        _controllerNameCompany.text == "") {
      showTopMessage(
          context: context,
          customBar:  CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: "اكتب اسم الشركة".tr(),
            textStyle: TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));
      return false;
    } else if (_controllerEmail.text.isEmpty || _controllerEmail.text == "") {
      showTopMessage(
          context: context,
          customBar:  CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: "اكتب ايميل الشركة".tr(),
            textStyle: TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));
      return false;
    } else if (_controllerAdminName.text.isEmpty ||
        _controllerAdminName.text == "") {
      showTopMessage(
          context: context,
          customBar:  CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: "اكتب اسم الشخص المسئول".tr(),
            textStyle: TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));
      return false;
    } else if (state.categoryModel == null) {
      showTopMessage(
          context: context,
          customBar:  CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: "اختار نوع الخدمة ".tr(),
            textStyle: TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));
      return false;
    }else if (_controllerNameBank.text.isEmpty || _controllerNameBank.text == "") {
      showTopMessage(
          context: context,
          customBar: CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: "اكتب اسم البنك".tr(),
            textStyle: TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));
      return false;
    } else if (_controllerIBanBank.text.isEmpty || _controllerIBanBank.text == "") {
      showTopMessage(
          context: context,
          customBar: CustomSnackBar.error(
            backgroundColor: Colors.red,
            message:"اكتب أيبان البنك".tr(),
            textStyle: TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));
      return false;
    }else {
      return true;
    }
  }
}

class TitleAccountWidget extends StatelessWidget {
  final String title;
  const TitleAccountWidget({
    super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3,left: 20,right: 20),
      child: Row(
        children: [
          Texts(
              title:title,
              family: AppFonts.taM,
              size: 14,
              textColor:Palette.mainColor,
              widget: FontWeight.normal),
        ],
      ),
    );
  }
}
