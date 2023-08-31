import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';


import 'package:hatlli/core/widgets/icon_alert_widget.dart';


import '../../../../core/layout/app_fonts.dart';

import '../../../../core/utils/app_model.dart';
import '../../../../core/widgets/back_button.dart';
import '../../../../core/widgets/texts.dart';
class QuizScreen extends StatefulWidget {
   QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // final scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: scaffoldkey,
      // drawer: const DrawerWidget(),
      appBar: AppBar(
        backgroundColor: const Color(0xffFEFEFE),
        elevation: 0,
        leading:BackButtonWidget(),
        title: const Texts(
            title: "الأسئلة الشائعة",
            family: AppFonts.taB,
            size: 18,
            widget: FontWeight.bold),
        actions: [
         IconAlertWidget(),
        ],
      ),
            body:Padding(padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
      
      child:SingleChildScrollView(
        child: Html(
        data: quiz,
      ),
      ),
      
      //  SingleChildScrollView(
      //   child: Column(
      //    crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //  const SizedBox(height: 60,),
      //  const Texts(title: "الشروط و الاحكام", family: AppFonts.caR, size: 12),
      //  const SizedBox(height: 11,),
      //  const Divider(height: .8,),
      //  const SizedBox(height: 11,),
      //      Texts(title: aboutUs, family: AppFonts.caR,height: 1.8, size: 12,textColor: const Color(0xffA9A9AA),),
      //     const SizedBox(height: 25,),
      //   const Texts(title: "سياسة الاستخدام", family: AppFonts.caR, size: 12),
      //  const SizedBox(height: 11,),
      //  const Divider(height: .8,),
      //  const SizedBox(height: 11,),
      //      Texts(title: servicesText, family: AppFonts.caR,height: 1.8, size: 12,textColor: const Color(0xffA9A9AA),),
      
        
      //   ]),
      // ),
      
      ) ,
    );
  }
}
