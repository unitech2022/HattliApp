import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatlli/core/extension/theme_extension.dart';
import 'package:hatlli/core/layout/screen_size.dart';
import 'package:hatlli/meduls/common/models/user_response.dart';

import '../../../../core/enums/loading_status.dart';
import '../../../../core/layout/app_fonts.dart';
import '../../../../core/layout/app_radius.dart';
import '../../../../core/layout/app_sizes.dart';
import '../../../../core/layout/palette.dart';
import '../../../../core/utils/api_constatns.dart';
import '../../../../core/widgets/circular_progress.dart';
import '../../../../core/widgets/text_field_widget.dart';
import '../../../../core/widgets/texts.dart';
import '../../../common/bloc/home_cubit/home_cubit.dart';
import '../home_user_screen/home_user_screen.dart';

class UpdateProfileScreen extends StatefulWidget {
  final UserModel user;
  final int type;
  const UpdateProfileScreen(
      {super.key, required this.user, required this.type});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _controllerName = TextEditingController();
  final _controllerCity = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controllerName.text = widget.user.fullName;
    _controllerCity.text = widget.user.city;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerName.dispose();
    _controllerCity.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffFEFEFE),
          elevation: 0,
          title:  Texts(
              title: "تعديل الملف الشخصى".tr(),
              family: AppFonts.taB,
              size: 18,
              widget: FontWeight.bold),
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.only(top: 50, left: 26, right: 26),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
// ** image
                    state.imageProfileUserState == RequestState.loading
                        ? const CustomCircularProgress(
                            size: Size(AppSize.s50, AppSize.s50),
                          )
                        : GestureDetector(
                            onTap: () {
                              HomeCubit.get(context).uploadImage(0);
                            },
                            child: CircleImageNetwork(
                              imageError: "assets/images/person2.png",
                              image: ApiConstants.imageUrl(state.imageLogo??""),
                              height: 86,
                              width: 86,
                              colorBackground: Palette.mainColor,
                            ),
                          ),

                    const SizedBox(
                      height: 45,
                    ),
                    // *** NAME
                    Row(
                      children: [
                        Texts(
                            title: " الاسم ".tr(),
                            family: AppFonts.taB,
                            size: 16,
                            widget: FontWeight.bold),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      controller: _controllerName,
                      hint: "",
                      maxLength: 30,
                      icon: const SizedBox(),
                      type: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // ** CITY
                    Row(
                      children: [
                        Texts(
                            title: " المدينة ".tr(),
                            family: AppFonts.taB,
                            size: 16,
                            widget: FontWeight.bold),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFieldWidget(
                      controller: _controllerCity,
                      hint: "",
                      maxLength: 30,
                      icon: const SizedBox(),
                      type: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 70,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      width: context.wSize,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          // if (widget.type == 0) {
                            HomeCubit.get(context).updateUserProfile(
                                widget.type,
                                context: context,
                                name: _controllerName.text,
                                city: _controllerCity.text,
                                image: state.imageLogo??""
                                );
                          // } else {
                          //   HomeCubit.get(context).updateUserProfile(
                          //       widget.type,
                          //       context: context,
                          //       value: _controller.text);
                          // }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            // onPressed == null ? Palette.kGreyColor : Palette.mainColor,
                            const Color(0xffD13A3A),
                          ),
                          elevation: MaterialStateProperty.all(12),
                          shape: MaterialStateProperty.resolveWith((states) {
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
                        child: Text(
                          "حفظ".tr(),
                          style: context.titleM.copyWith(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontFamily: AppFonts.caSi,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }
}
