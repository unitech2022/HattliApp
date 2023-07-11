import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:badges/badges.dart' as badges;
import 'package:hatlli/meduls/user/ui/components/darwer_widget.dart';

import '../../../../core/layout/app_fonts.dart';
import '../../../../core/layout/palette.dart';
import '../../../../core/utils/app_model.dart';
import '../../../../core/widgets/texts.dart';
class PrivacyScreen extends StatefulWidget {
   PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  final scaffoldkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
      drawer: const DrawerWidget(),
      appBar: AppBar(
        backgroundColor: const Color(0xffFEFEFE),
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              scaffoldkey.currentState!.openDrawer();
            },
            child: Padding(
                padding: const EdgeInsets.all(15),
                child: SvgPicture.asset(
                  "assets/icons/menu.svg",
                  height: 17,
                  width: 26,
                ))),
        title: const Texts(
            title: "سياسة التطبيق",
            family: AppFonts.taB,
            size: 18,
            widget: FontWeight.bold),
        actions: [
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 20),
            child: badges.Badge(
              badgeContent: const Text(
                '3',
                style: TextStyle(color: Colors.white, height: 1.8),
              ),
              position: badges.BadgePosition.topStart(top: -12),
              badgeStyle:
                  const badges.BadgeStyle(badgeColor: Palette.mainColor),
              child: SvgPicture.asset("assets/icons/noty.svg"),
            ),
          ),
        ],
      ),
            body:Padding(padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 40),
      
      child: SingleChildScrollView(
        child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
          children: [
       const SizedBox(height: 60,),
       const Texts(title: "الشروط و الاحكام", family: AppFonts.caR, size: 12),
       const SizedBox(height: 11,),
       const Divider(height: .8,),
       const SizedBox(height: 11,),
           Texts(title: aboutUs, family: AppFonts.caR,height: 1.8, size: 12,textColor: const Color(0xffA9A9AA),),
          const SizedBox(height: 25,),
        const Texts(title: "سياسة الاستخدام", family: AppFonts.caR, size: 12),
       const SizedBox(height: 11,),
       const Divider(height: .8,),
       const SizedBox(height: 11,),
           Texts(title: servicesText, family: AppFonts.caR,height: 1.8, size: 12,textColor: const Color(0xffA9A9AA),),
      
        
        ]),
      ),
      
      ) ,
    );
  }
}
