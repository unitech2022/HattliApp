import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hatlli/core/helpers/helper_functions.dart';

import '../../../../core/layout/app_assets.dart';
import '../../../../core/layout/app_fonts.dart';
import '../../../../core/utils/strings.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/texts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffFCFCFD),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 43,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:12),
                  child: IconButton(onPressed: (){
                    pop(context);
                  }, icon: const Icon(Icons.arrow_back)),
                ),
              ],
            ),
            Image.asset(AppAssets.logoBlack),
            const SizedBox(
              height: 58,
            ),
            Expanded(
                child: Card(
              elevation: 25,
              margin: const EdgeInsets.only(top: 15),
              shape: const RoundedRectangleBorder(
                side: BorderSide(color: Colors.white70, width: 1),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(44.0),
                  topRight: Radius.circular(44.0),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.only(
                  top: 31,
                  left: 22,
                  right: 22,
                ),
                width: double.infinity,
                child: Column(children: [
                  const Texts(
                      title: Strings.login,
                      family: AppFonts.taB,
                      size: 20,
                      textColor: Colors.black,
                      widget: FontWeight.w700),
                  const SizedBox(
                    height: 15,
                  ),
                  const Texts(
                      title: Strings.sendCode,
                      family: AppFonts.taM,
                      size: 14,
                      textColor: Color(0xff44494E),
                      widget: FontWeight.normal),
                  const SizedBox(
                    height: 30,
                  ),
                 
                const SizedBox(
                    height: 72,
                  ),
        
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: CustomButton(title: Strings.next, onPressed: (){}),
                  ),
                    const SizedBox(
                    height: 20,
                  ),
        
                    const Texts(
                      title: Strings.vistor,
                      family: AppFonts.taB,
                      size: 14,
                      textColor: Color(0xff292626),
                      widget: FontWeight.bold),
            Container(
    decoration: BoxDecoration(
      color: const Color(0xfffefefe),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(width: 1.0, color: const Color(0xfff6f6f7)),
      boxShadow:const [
        BoxShadow(
          color: const Color(0x0f000000),
          offset: Offset(1, 1),
          blurRadius: 6,
        ),
      ],
    ),
    child: TextField(
      
    ),
  )
            
               ]),
              ),
            ))
          ],
        ));
 
  }
}