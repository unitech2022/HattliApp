import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatlli/core/helpers/helper_functions.dart';
import 'package:hatlli/core/layout/app_fonts.dart';
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
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            pushPage(
                                context,
                                EditAccountProviderScreen(
                                    providerId: state
                                        .homeResponseProvider!.provider!.id));
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset("assets/icons/edit.svg"),
                              const SizedBox(
                                width: 18,
                              ),
                              const Texts(
                                  title: "تعديل البيانات",
                                  family: AppFonts.taM,
                                  size: 12)
                            ],
                          ),
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
                  TextFieldWidget(
                    controller: _controllerEmail,
                    hint: state.homeResponseProvider!.provider!.email,
                    icon: const SizedBox(),
                    enable: false,
                    type: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFieldWidget(
                    controller: _controllerAdminName,
                    hint: state.homeResponseProvider!.provider!
                        .nameAdministratorCompany,
                    icon: const SizedBox(),
                    enable: false,
                    type: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
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
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Texts(
                              title: "إرفاق الاثبات",
                              family: AppFonts.taM,
                              size: 14,
                              textColor: Colors.black,
                              widget: FontWeight.normal),
                          SvgPicture.asset("assets/icons/upload.svg")
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Texts(
                              title: state
                                  .homeResponseProvider!.provider!.imagePassport,
                              // "(الرخصة التجارية -الشهادة الضريبية - صورة الجواز - الهوية)",
                              family: AppFonts.taM,
                              size: 10,
                              textColor: Color(0xff292626),
                              widget: FontWeight.normal),
                        ],
                      ),
                    ]),
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
