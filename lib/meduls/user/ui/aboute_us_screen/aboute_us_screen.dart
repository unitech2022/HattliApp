import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_svg/svg.dart';
import 'package:hatlli/core/utils/app_model.dart';
import '../../../../core/layout/app_assets.dart';
import '../../../../core/layout/app_fonts.dart';
import '../../../../core/layout/palette.dart';
import '../../../../core/widgets/texts.dart';
import '../components/darwer_widget.dart';
class AboutUsScreen extends StatelessWidget {
   AboutUsScreen({super.key});
  final scaffoldkey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
        drawer: DrawerWidget(),
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
            title: "من نحن",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AppAssets.logoBlack),
                  ],
                ),
       const SizedBox(height: 60,),
       const Texts(title: "من نحن", family: AppFonts.caR, size: 12),
       const SizedBox(height: 11,),
       const Divider(height: .8,),
       const SizedBox(height: 11,),
           Texts(title: aboutUs, family: AppFonts.caR,height: 1.8, size: 12,textColor: Color(0xffA9A9AA),),
          const SizedBox(height: 25,),
        const Texts(title: "خدامتنا", family: AppFonts.caR, size: 12),
       const SizedBox(height: 11,),
       const Divider(height: .8,),
       const SizedBox(height: 11,),
           Texts(title: servicesText, family: AppFonts.caR,height: 1.8, size: 12,textColor: Color(0xffA9A9AA),),
      
        
        ]),
      ),
      
      ) ,
    );
  }
}
