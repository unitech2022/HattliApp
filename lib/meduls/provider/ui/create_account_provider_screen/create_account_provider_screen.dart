import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatlli/core/enums/loading_status.dart';
import 'package:hatlli/core/utils/api_constatns.dart';
import 'package:hatlli/core/utils/app_model.dart';
import 'package:hatlli/core/widgets/circular_progress.dart';
import 'package:hatlli/meduls/common/models/provider.dart';

import 'package:hatlli/meduls/provider/bloc/provider_cubit/provider_cubit.dart';
import 'package:hatlli/meduls/user/ui/home_user_screen/home_user_screen.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

import '../../../../core/helpers/helper_functions.dart';
import '../../../../core/layout/app_assets.dart';
import '../../../../core/layout/app_fonts.dart';
import '../../../../core/utils/strings.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/drop_dwon_widget.dart';
import '../../../../core/widgets/text_field_widget.dart';
import '../../../../core/widgets/texts.dart';
import '../../../common/models/address_model.dart';
import '../../../common/ui/map_screen/map_screen.dart';
import '../add_product_screen/add_product_screen.dart';

class CreateAccountProviderScreen extends StatefulWidget {
  const CreateAccountProviderScreen({super.key});

  @override
  State<CreateAccountProviderScreen> createState() =>
      _CreateAccountProviderScreenState();
}

class _CreateAccountProviderScreenState
    extends State<CreateAccountProviderScreen> {
  final _controllerAdminName = TextEditingController();
  final _controllerNameCompany = TextEditingController();
  final _controllerEmail = TextEditingController();
  final _controllerDesc = TextEditingController();

  final _controllerNameBank = TextEditingController();
  final _controllerIBanBank = TextEditingController();

  String? currenValue;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerAdminName.dispose();
    _controllerEmail.dispose();
    _controllerNameCompany.dispose();
    _controllerDesc.dispose();

    _controllerNameBank.dispose();
    _controllerIBanBank.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffFCFCFD),
        body: BlocBuilder<ProviderCubit, ProviderState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 43,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: IconButton(
                          onPressed: () {
                            pop(context);
                          },
                          icon: const Icon(Icons.arrow_back)),
                    ),
                  ],
                ),
                Image.asset(AppAssets.logoBlack),
                const SizedBox(
                  height: 58,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 35,
                      left: 30,
                      right: 30,
                    ),
                    width: double.infinity,
                    child: Column(children: [
                      Texts(
                          title: "بيانات الشركة".tr(),
                          family: AppFonts.taB,
                          size: 20,
                          textColor: Colors.black,
                          widget: FontWeight.w700),
                      const SizedBox(
                        height: 15,
                      ),
                      Texts(
                          title: "الرجاء ادخال بيانات الشركة الخاصة بك".tr(),
                          family: AppFonts.taM,
                          size: 14,
                          textColor: Color(0xff44494E),
                          widget: FontWeight.normal),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFieldWidget(
                        controller: _controllerNameCompany,
                        hint: 'اسم الشركة'.tr(),
                        icon: const SizedBox(),
                        type: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFieldWidget(
                        controller: _controllerEmail,
                        hint: "إيميل الشركة".tr(),
                        icon: const SizedBox(),
                        type: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 15,
                      ),

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
                          decoration: InputDecoration(
                            hintText: "وصف الشركة".tr(),
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                fontFamily: AppFonts.moS,
                                fontSize: 14,
                                color: Color(0xff1D1D1D)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      TextFieldWidget(
                        controller: _controllerAdminName,
                        hint: "الشخص المسؤول".tr(),
                        icon: const SizedBox(),
                        type: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      // ** photo id company
                      GestureDetector(
                        onTap: () {
                          ProviderCubit.get(context).uploadImage(1);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
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
                          child: Column(children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Texts(
                                    title: "إرفاق الاثبات".tr(),
                                    family: AppFonts.taM,
                                    size: 14,
                                    textColor: Colors.black,
                                    widget: FontWeight.normal),
                                state.imagePassport == null
                                    ? SvgPicture.asset(
                                        "assets/icons/upload.svg")
                                    : state.imagePassportState ==
                                            RequestState.loading
                                        ? CustomCircularProgress()
                                        : SizedBox(
                                            width: 40,
                                            height: 40,
                                            child: CircleImageNetwork(
                                              image: ApiConstants.imageUrl(
                                                  state.imagePassport),
                                              height: 40,
                                              width: 40,
                                              imageError: '',
                                              colorBackground: Colors.white,
                                            ))
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Texts(
                                    title: state.imageLogo == null
                                        ? "(الرخصة التجارية -الشهادة الضريبية - صورة الجواز - الهوية)"
                                            .tr()
                                        : "تم اضافة الصورة".tr(),
                                    family: AppFonts.taM,
                                    size: 10,
                                    textColor: Color(0xff292626),
                                    widget: FontWeight.normal),
                              ],
                            ),
                          ]),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      //** logo company  */
                      GestureDetector(
                        onTap: () {
                          ProviderCubit.get(context).uploadImage(0);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
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
                              state.imageLogo == null
                                  ? SvgPicture.asset("assets/icons/upload.svg")
                                  : state.imageLogoState == RequestState.loading
                                      ? CustomCircularProgress()
                                      : SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: CircleImageNetwork(
                                              image: ApiConstants.imageUrl(
                                                  state.imageLogo),
                                              height: 40,
                                              width: 40,
                                              imageError: '',
                                              colorBackground: Colors.white))
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      //** address company  */
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            // Create the SelectionScreen in the next step.
                            MaterialPageRoute(
                                builder: (context) => MapScreen(
                                      type: 0,
                                    )),
                          ).then((value) {
                            ProviderCubit.get(context).selectAddressModel(
                              value as AddressModel,
                            );
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
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
                                  title: "اختار الموقع".tr(),
                                  family: AppFonts.taM,
                                  size: 14,
                                  textColor: Colors.black,
                                  widget: FontWeight.normal),
                              state.addressProvider == null
                                  ? const Icon(
                                      Icons.add_location_outlined,
                                      color: Colors.black54,
                                    )
                                  : const Icon(
                                      Icons.done,
                                      color: Colors.green,
                                    )
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 15,
                      ),
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
                              ProviderCubit.get(context)
                                  .changeCurrentCategory(value);
                            },
                            hint: "اختيار الخدمة التي تقدمها".tr()),
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                 // ** area
                      FieldAddProduct(
                        title: state.area != null
                            ? state.area.toString() + " KG "
                            : "النطاق".tr(),
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
                                height: 600,
                                width: double.infinity,
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Texts(
                                          title:
                                              "حدد النطاق الذى تريد البيع فيه"
                                                  .tr(),
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
                                                    pop(context);
                                                    ProviderCubit.get(context)
                                                        .changeArea(
                                                            areas[index]);
                                                  },
                                                  child: Container(
                                                    height: 60,
                                                    alignment: Alignment.center,
                                                    decoration: const BoxDecoration(
                                                        border: Border(
                                                            bottom: BorderSide(
                                                                color: Colors
                                                                    .black45,
                                                                width: .8))),
                                                    child: Row(
                                                      children: [
                                                        Texts(
                                                            title: areas[index]
                                                                    .toString() +
                                                                " KM",
                                                            family:
                                                                AppFonts.taM,
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

                      TextFieldWidget(
                        controller: _controllerNameBank,
                        hint: "اسم البنك".tr(),
                        icon: const SizedBox(),
                        type: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 15,
                      ),

                      //** */ IBan Bank
                      const SizedBox(
                        height: 15,
                      ),

                      TextFieldWidget(
                        controller: _controllerIBanBank,
                        hint: "IBan".tr(),
                        icon: const SizedBox(),
                        type: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: CustomButton(
                            title: Strings.next,
                            onPressed: () {
                              if (isValidate(context, state)) {
                                Provider provider = Provider(
                                    id: 1,
                                    iBan: _controllerIBanBank.text,
                                    nameBunk: _controllerNameBank.text,
                                    area: state.area!,
                                    about: _controllerDesc.text,
                                    categoryId: state.categoryModel!.id,
                                    title: _controllerNameCompany.text,
                                    userId: "currentUser.id!",
                                    email: _controllerEmail.text,
                                    logoCompany: state.imageLogo!,
                                    imagePassport: state.imagePassport!,
                                    nameAdministratorCompany:
                                        _controllerAdminName.text,
                                    addressName:
                                        state.addressProvider!.description!,
                                    lat: state.addressProvider!.lat!,
                                    lng: state.addressProvider!.lng!,
                                    rate: 0.0,
                                    status: 0,
                                    discount: 0,
                                    distance: 0,
                                    wallet: 0.0,
                                    createdAt: "createdAt");
                                ProviderCubit.get(context)
                                    .addProvider(provider, context: context);
                              }
                            }),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ]),
                  ),
                ))
              ],
            );
          },
        ));
  }

  bool isValidate(BuildContext context, ProviderState state) {
    if (_controllerNameCompany.text.isEmpty ||
        _controllerNameCompany.text == "") {
      showTopMessage(
          context: context,
          customBar: CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: "اكتب اسم الشركة".tr(),
            textStyle: TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));
      return false;
    } else if (_controllerEmail.text.isEmpty || _controllerEmail.text == "") {
      showTopMessage(
          context: context,
          customBar: CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: "اكتب ايميل الشركة".tr(),
            textStyle: TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));
      return false;
    } else if (_controllerDesc.text.isEmpty || _controllerDesc.text == "") {
      showTopMessage(
          context: context,
          customBar: CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: "اكتب نبذة عن الشركة".tr(),
            textStyle: TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));
      return false;
    } else if (_controllerAdminName.text.isEmpty ||
        _controllerAdminName.text == "") {
      showTopMessage(
          context: context,
          customBar: CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: "اكتب اسم الشخص المسئول".tr(),
            textStyle: TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));
      return false;
    } else if (state.imagePassport == null) {
      showTopMessage(
          context: context,
          customBar: CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: "اختار صورة اثبات الشخصية".tr(),
            textStyle: TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));
      return false;
    } else if (state.imageLogo == null) {
      showTopMessage(
          context: context,
          customBar: CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: "اختار شعار الشركة".tr(),
            textStyle: TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));
      return false;
    } else if (state.addressProvider == null) {
      showTopMessage(
          context: context,
          customBar: CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: "اختار عنوان الشركة".tr(),
            textStyle: TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));
      return false;
    } else if (state.categoryModel == null) {
      showTopMessage(
          context: context,
          customBar: CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: "اختار نوع الخدمة".tr(),
            textStyle: TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));
      return false;
    } else if (state.area == null) {
      showTopMessage(
          context: context,
          customBar: CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: "اختار النطاق الذى تريد البيع فيه".tr(),
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
    }  else {
      return true;
    }
  }
}
