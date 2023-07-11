import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
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

  String? currenValue;
  @override
  void dispose() {
    super.dispose();
    _controllerAdminName.dispose();
    _controllerEmail.dispose();
    _controllerNameCompany.dispose();
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
            title: const Texts(
                title: "تعديل البيانات",
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
                              : GestureDetector(
                                  onTap: () {
                                    ProviderCubit.get(context).uploadImage(0);
                                  },
                                  child: CircleImageNetwork(
                                    imageError: "assets/images/person2.png",
                                    image:
                                        ApiConstants.imageUrl(state.imageLogo),
                                    height: 66,
                                    width: 66,
                                    colorBackground: Palette.mainColor,
                                  ),
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
                          TextFieldWidget(
                            controller: _controllerNameCompany,
                            hint: "اسم الشركة",
                            icon: const SizedBox(),
                            type: TextInputType.text,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFieldWidget(
                            controller: _controllerEmail,
                            hint: "ايميل الشؤكة",
                            icon: const SizedBox(),
                            type: TextInputType.text,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFieldWidget(
                            controller: _controllerAdminName,
                            hint: "الشخص المسئول",
                            icon: const SizedBox(),
                            type: TextInputType.text,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          state.imagePassportState == RequestState.loading
                              ? const CustomCircularProgress(
                                  size: Size(AppSize.s50, AppSize.s50),
                                )
                              : GestureDetector(
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
                                          const Texts(
                                              title: "إرفاق الاثبات",
                                              family: AppFonts.taM,
                                              size: 14,
                                              textColor: Colors.black,
                                              widget: FontWeight.normal),
                                          SvgPicture.asset(
                                              "assets/icons/upload.svg")
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        children: [
                                          Texts(
                                              title: state.imagePassport!,
                                              // "(الرخصة التجارية -الشهادة الضريبية - صورة الجواز - الهوية)",
                                              family: AppFonts.taM,
                                              size: 10,
                                              textColor:
                                                  const Color(0xff292626),
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
                          Container(
                            height: 66,
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
                                const Texts(
                                    title: "إرفاق شعار الشركة",
                                    family: AppFonts.taM,
                                    size: 14,
                                    textColor: Colors.black,
                                    widget: FontWeight.normal),
                                SvgPicture.asset("assets/icons/upload.svg")
                              ],
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
                                  print(value.id.toString());
                                  ProviderCubit.get(context)
                                      .changeCurrentCategory(value);
                                },
                                hint:state.categoryModel!=null?state.categoryModel!.name:"اختيار الخدمة التي تقدمها"),
                          ),

                          const SizedBox(
                            height: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: CustomButton(
                                title: Strings.save,
                                onPressed: () {
                                  if (validate(context, state)) {
                                    Provider provider = Provider(
                                        id: widget.providerId,
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
                                        discount: 0,
                                        distance: 0,
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
          customBar: const CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: "اكتب اسم الشركة",
            textStyle: TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));
      return false;
    } else if (_controllerEmail.text.isEmpty || _controllerEmail.text == "") {
      showTopMessage(
          context: context,
          customBar: const CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: "اكتب ايميل الشركة",
            textStyle: TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));
      return false;
    } else if (_controllerAdminName.text.isEmpty ||
        _controllerAdminName.text == "") {
      showTopMessage(
          context: context,
          customBar: const CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: "اكتب اسم الشخص المسئول",
            textStyle: TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));
      return false;
    } else if (state.categoryModel == null) {
      showTopMessage(
          context: context,
          customBar: const CustomSnackBar.error(
            backgroundColor: Colors.red,
            message: "اختار نوع الخدمة ",
            textStyle: TextStyle(
                fontFamily: "font", fontSize: 16, color: Colors.white),
          ));
      return false;
    } else {
      return true;
    }
  }
}
