import 'package:easy_localization/easy_localization.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/layout/palette.dart';

class StepperOrderWidget extends StatelessWidget {
  final int statuse;
  const StepperOrderWidget({
    super.key, required this.statuse,
  });

  @override
  Widget build(BuildContext context) {
    return  EasyStepper(
      activeStep: statuse,
      lineLength: 65,
      unreachedLineColor: const Color(0xffD1CDCD),
      lineSpace: 0,
      finishedStepBackgroundColor: Palette.mainColor,
      finishedStepIconColor: Palette.mainColor,
      activeLineColor: Palette.mainColor,
      activeStepIconColor: Palette.mainColor,
      activeStepBackgroundColor: Palette.mainColor,
      lineType: LineType.normal,
      defaultLineColor: const Color(0xffD1CDCD),
      finishedLineColor: Colors.orange,
      activeStepTextColor: Colors.orange,
      finishedStepTextColor: Colors.orange,
      internalPadding: 0,
      showLoadingAnimation: false,
      stepRadius: 10,
      showStepBorder: false,
      steps:  [
        EasyStep(
          customStep: CircleAvatar(
            radius: 15,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 15,
               backgroundColor:statuse >=0 ? Colors.orange:Colors.grey,
            ),
          ),
          title: "جديد".tr(),
        ),
        EasyStep(
          
          customStep: CircleAvatar(
            radius: 15,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 15,
             backgroundColor:statuse >=1 ? Colors.orange:Colors.grey,
            ),
          ),
          title: "قيد التجهيز".tr(),
        ),
        EasyStep(
          customStep: CircleAvatar(
            radius: 15,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 15,
          backgroundColor:statuse >=2 ? Colors.orange:Colors.grey,
            ),
          ),
          title:"قيد التوصيل".tr(),
        ),
        EasyStep(
          customStep: CircleAvatar(
            radius: 15,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 15,
            backgroundColor: statuse >=3 ? Colors.orange:Colors.grey,
            ),
          ),
          title: "مستلم".tr(),
        ),
      ],
    );
  }
}
