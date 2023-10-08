import 'package:flutter/material.dart';

import 'package:hatlli/core/utils/app_model.dart';
import 'package:hatlli/core/widgets/icon_alert_widget.dart';
import '../../../../core/layout/app_assets.dart';
import '../../../../core/layout/app_fonts.dart';

import '../../../../core/widgets/back_button.dart';
import '../../../../core/widgets/texts.dart';

class AboutUsScreen extends StatelessWidget {
   AboutUsScreen({super.key});
  final scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: scaffoldkey,
      //   drawer: DrawerWidget(),
      appBar: AppBar(
        backgroundColor: const Color(0xffFEFEFE),
        elevation: 0,
        leading:BackButtonWidget(),
        title: const Texts(
            title: "من نحن",
            family: AppFonts.taB,
            size: 18,
            widget: FontWeight.bold),
        actions: [
          IconAlertWidget()
        ],
      ),
      body:Padding(padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 40),
      
      child: SingleChildScrollView(
        child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppAssets.logoBlack),
                  ],
                ),
       const SizedBox(height: 60,),
       const Texts(title: "من نحن", family: AppFonts.caR, size: 18),
       const SizedBox(height: 11,),
       const Divider(height: .8,),
       const SizedBox(height: 11,),
           Texts(title: aboutUs, family: AppFonts.caB,height: 2.1, size: 14,textColor: Colors.black,line: 2945,),
          const SizedBox(height: 25,),
      //   const Texts(title: "خدامتنا", family: AppFonts.caR, size: 12),
      //  const SizedBox(height: 11,),
      //  const Divider(height: .8,),
      //  const SizedBox(height: 11,),
      //      Texts(title: servicesText, family: AppFonts.caR,height: 1.8, size: 12,textColor: Color(0xffA9A9AA),),
      
        
        ]),
      ),
      
      ) ,
    );
  }
}
