import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatlli/core/extension/theme_extension.dart';
import 'package:hatlli/core/helpers/helper_functions.dart';
import 'package:hatlli/core/layout/app_fonts.dart';
import 'package:hatlli/core/layout/app_radius.dart';
import 'package:hatlli/core/layout/screen_size.dart';
import 'package:hatlli/core/utils/api_constatns.dart';
import 'package:hatlli/core/widgets/texts.dart';
import 'package:hatlli/meduls/common/bloc/home_cubit/home_cubit.dart';
import 'package:hatlli/meduls/provider/ui/account_provider_screen/edit_account_provider_screen.dart';
import '../../../../core/layout/palette.dart';
import '../../../../core/widgets/text_field_widget.dart';
import '../../../user/ui/home_user_screen/home_user_screen.dart';

class AccountProviderScreen extends StatefulWidget {
  const AccountProviderScreen({super.key});

  @override
  State<AccountProviderScreen> createState() => _AccountProviderScreenState();
}

class _AccountProviderScreenState extends State<AccountProviderScreen> {
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
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  MaterialButton(
                     onPressed: () {
                        pushPage(
                                  context,
                                  EditAccountProviderScreen(
                                      providerId: state
                                          .homeResponseProvider!.provider!.id));
                      },
                    child: Row(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset("assets/icons/edit.svg"),
                            const SizedBox(
                              width: 18,
                            ),
                             Texts(
                                title: "تعديل البيانات".tr(),
                                family: AppFonts.taM,
                                size: 12)
                          ],
                        ),
                      ],
                    ),
                  ),
                
                  const SizedBox(
                    height: 9,
                  ),
                  Container(
                     decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Palette.mainColor,
                  width: 2
                )
              ),
                    child: CircleImageNetwork(
                      imageError: "assets/images/person2.png",
                      image: ApiConstants.imageUrl(
                          state.homeResponseProvider!.provider!.logoCompany),
                      height: 66,
                      width: 66,
                      colorBackground: Palette.mainColor,
                    ),
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  Texts(
                      title: state.homeResponseProvider!.provider!.title,
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
                    hint: state.homeResponseProvider!.provider!.title,
                    icon: const SizedBox(),
                    enable: false,
                    type: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TitleAccountWidget(title: "ايميل الشؤكة".tr(),),
                  TextFieldWidget(
                    controller: _controllerEmail,
                    hint: state.homeResponseProvider!.provider!.email,
                    icon: const SizedBox(),
                    enable: false,
                    type: TextInputType.text,
                  ),
                  const SizedBox(
                    height:25,
                  ),

                  TitleAccountWidget(title: "الشخص المسئول".tr(),),
                  TextFieldWidget(
                    controller: _controllerAdminName,
                    hint: state.homeResponseProvider!.provider!
                        .nameAdministratorCompany,
                    icon: const SizedBox(),
                    enable: false,
                    type: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TitleAccountWidget(title: "صورة الاثبات".tr(),),
                  Container(
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
                            title: "إرفاق الاثبات".tr(),
                            family: AppFonts.taM,
                            size: 14,
                            textColor: Colors.black,
                            widget: FontWeight.normal),
                        CircleImageNetwork(height: 30, width: 30,
                            image: ApiConstants.imageUrl( state.homeResponseProvider!.provider!.imagePassport),
                            imageError: "", colorBackground: Colors.white)
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  //** logo company  */
                  TitleAccountWidget(title: "شعار الشركة".tr(),),
                  Container(
                    height: 66,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
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
                           image: ApiConstants.imageUrl( state.homeResponseProvider!.provider!.logoCompany),
                           imageError: "", colorBackground: Colors.white)
                      ],
                    ),
                  ),
              
                  const SizedBox(
                    height: 25,
                  ),
                  TitleAccountWidget(title: "النطاق".tr(),),
                  TextFieldWidget(
                    controller: _controllerEmail,
                    hint:" النطاق الي  ".tr()+ " KM "+ state.homeResponseProvider!.provider!.area.toString() ,
                    icon: const SizedBox(),
                    enable: false,
                    type: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  // ** data bank

                    Texts(
                          title: "بيانات البنك".tr(),
                          family: AppFonts.taB,
                          size: 20,
                          textColor: Colors.black,
                          widget: FontWeight.w700),

                  const SizedBox(
                    height: 25,
                  ),
                  TitleAccountWidget(title: "اسم البنك".tr(),),
                  TextFieldWidget(
                    controller: _controllerEmail,
                    hint:state.homeResponseProvider!.provider!.nameBunk,
                    icon: const SizedBox(),
                    enable: false,
                    type: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                    const SizedBox(
                    height: 25,
                  ),
                  TitleAccountWidget(title:"IBan".tr(),),
                  TextFieldWidget(
                    controller: _controllerEmail,
                    hint:state.homeResponseProvider!.provider!.iBan,
                    icon: const SizedBox(),
                    enable: false,
                    type: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // Container(
                  //   height: 62,
                  //   padding:
                  //       const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                  //   decoration: BoxDecoration(
                  //     color: const Color(0xfffefefe),
                  //     borderRadius: BorderRadius.circular(10.0),
                  //     border: Border.all(
                  //         width: 1.0, color: const Color(0xfff6f6f7)),
                  //     boxShadow: const [
                  //       BoxShadow(
                  //         color: Color(0x0f000000),
                  //         offset: Offset(1, 1),
                  //         blurRadius: 6,
                  //       ),
                  //     ],
                  //   ),
                  //   child: CustomDropDownWidget(
                  //       currentValue: const CategoryModel(
                  //           createdAt: "gdfg",
                  //           name: "gfdg",
                  //           id: 4,
                  //           status: 3,
                  //           imageUrl: "ff"),
                  //       selectCar: false,
                  //       textColor: const Color(0xff28436C),
                  //       isTwoIcons: false,
                  //       iconColor: const Color(0xff515151),
                  //       list: categories,
                  //       onSelect: (value) {
                  //         print(value);
                  //       },
                  //       hint: "اختيار الخدمة التي تقدمها"),
                  // ),

                  const SizedBox(
                    height: 50,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 10),
                  //   child: CustomButton(title: Strings.next, onPressed: () {}),
                  // ),
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          width: context.wSize,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              signOut(ctx: context);
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                // onPressed == null ? Palette.kGreyColor : Palette.mainColor,
                                const Color(0xffD13A3A),
                              ),
                              elevation: MaterialStateProperty.all(12),
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
                                SvgPicture.asset("assets/icons/delete.svg",color: Colors.white,width: 25,height: 25,),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                 "حذف الحساب".tr(),
                                  style: context.titleM.copyWith(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: AppFonts.caSi,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
