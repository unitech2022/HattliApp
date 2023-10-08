import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hatlli/core/helpers/helper_functions.dart';
import 'package:hatlli/core/layout/app_fonts.dart';
import 'package:hatlli/core/layout/palette.dart';
import 'package:hatlli/core/utils/app_model.dart';
import 'package:hatlli/core/utils/strings.dart';
import 'package:hatlli/core/widgets/custom_button.dart';
import 'package:hatlli/meduls/common/bloc/order_cubit/order_cubit.dart';
import 'package:hatlli/meduls/common/models/manual_order.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

import '../../../../core/widgets/texts.dart';

class ManualOrderScreen extends StatefulWidget {
  final int providerId;
  const ManualOrderScreen({super.key, required this.providerId});

  @override
  State<ManualOrderScreen> createState() => _ManualOrderScreenState();
}

class _ManualOrderScreenState extends State<ManualOrderScreen> {
  final _controllerDesc = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controllerDesc.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        title: Texts(
            title: "طلب يدوى".tr(),
            family: AppFonts.taB,
            size: 18,
            height: 2,
            widget: FontWeight.bold),
        // actions: [
        //  IconAlertWidget()
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 30,
              ),
              Texts(
                  title: "أدخل تفاصيل الطلب".tr(),
                  family: AppFonts.taB,
                  size: 18,
                  height: 2,
                  textColor: Palette.mainColor,
                  widget: FontWeight.bold),
              SizedBox(
                height: 3,
              ),
              Row(
                children: [
                  Expanded(
                    child: Texts(
                        title: "سيتم اضافة ٣ ريال علي سعر الطلب قيمة التوصيل "
                            .tr(),
                        family: AppFonts.taM,
                        size: 15,
                        height: 2,
                        line: 2,
                        textColor: Palette.fontGreyColor,
                        widget: FontWeight.normal),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.only(
                    right: 25, left: 18, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: const Color(0xfffefefe),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(width: .5, color: Colors.grey),
                ),
                child: TextField(
                  controller: _controllerDesc,
                  keyboardType: TextInputType.multiline,
                  style: const TextStyle(
                      fontFamily: AppFonts.taM,
                      fontSize: 14,
                      color: Colors.black),
                  maxLines: 15,
                  decoration: InputDecoration(
                    hintText: "تفاصيل الطلب".tr(),
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      fontFamily: AppFonts.taM,
                    ),
                  ),
                ),
              ),
            SizedBox(
                height: 30,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CustomButton(
                      title: Strings.send.tr(),
                      onPressed: () {
                        if (_controllerDesc.text.isEmpty ||
                            _controllerDesc.text == "") {
                          showTopMessage(
                              context: context,
                              customBar: CustomSnackBar.error(
                                  backgroundColor: Colors.red,
                                  message: "من فضلك أدخل تفاصيل الطلب".tr(),
                                  textStyle: TextStyle(
                                      fontFamily: "font",
                                      fontSize: 16,
                                      color: Colors.white)));
                        } else {
                          OrderCubit.get(context).addManualOrder(
                            context:context,
                            ManualOrder(
                              id: 0,
                              providerId: widget.providerId,
                              status: 0,
                              userId: currentUser.id!,
                              totalCost: 0,
                              desc: _controllerDesc.text,
                              createdAt: "createdAt"));
                        }
                      })),
            ]),
          ),
        ),
      ),
    );
  }
}
