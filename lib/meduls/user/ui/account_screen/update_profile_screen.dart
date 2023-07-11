import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatlli/core/extension/theme_extension.dart';
import 'package:hatlli/core/layout/screen_size.dart';

import '../../../../core/layout/app_fonts.dart';
import '../../../../core/layout/app_radius.dart';
import '../../../../core/widgets/text_field_widget.dart';
import '../../../../core/widgets/texts.dart';
import '../../../common/bloc/home_cubit/home_cubit.dart';

class UpdateProfileScreen extends StatefulWidget {
  final String value;
  final int type;
  const UpdateProfileScreen(
      {super.key, required this.value, required this.type});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.text = widget.value;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xffFEFEFE),
          elevation: 0,
          title: const Texts(
              title: "تعديل الملف الشخصى",
              family: AppFonts.taB,
              size: 18,
              widget: FontWeight.bold),
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        color: const Color(0xfffcfcfd),
                        borderRadius: BorderRadius.circular(15),
                        // border: Border.all(width: .6,color: Colors.grey),
                        
                      ),
                      
                      child: Column(
                        children: [
                          const SizedBox(height: 30,),
                            Row(
                              children: [
                                Texts(
                title:widget.type==1?"تعديل المدينة ": "تعديل الاسم ",
                family: AppFonts.taB,
                size: 16,
                widget: FontWeight.bold),
                              ],
                            ),
                const SizedBox(
                  height: 10,
                ),
                          TextFieldWidget(
                            controller: _controller,
                            hint: "",
                            maxLength: 30,
                            icon: const SizedBox(),
                            type: TextInputType.text,
                          ),
                        ],
                      ),
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
                          if (widget.type == 0) {
                            HomeCubit.get(context).updateUserProfile(widget.type,
                                context: context, value: _controller.text);
                          }else{
                             HomeCubit.get(context).updateUserProfile(widget.type,
                                context: context, value: _controller.text);
                          }
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
                          "حفظ",
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
