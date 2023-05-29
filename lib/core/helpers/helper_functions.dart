import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../meduls/common/models/user_response.dart';

import '../utils/app_model.dart';


pushPage(context, page) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}

// bool isLogin() {
//   return currentUser.token != "";
// }

// pushPageTransition({context, page, type}) {
//   Navigator.push(
//       context,
//       PageTransition(
//           duration: const Duration(milliseconds: 300),
//           reverseDuration:
//               // ignore: prefer_const_constructors
//               Duration(milliseconds: 300),
//           // alignment: Alignment.center,
//           curve: Curves.ease,
//           type: type,
//           child: page));
// }

pop(context) {
  Navigator.pop(context);
}

pushPageRoutName(context, route) {
  Navigator.pushNamed(
    context,
    route,
  );
}

pushPageRoutNameReplaced(context, route) {
  Navigator.pushReplacementNamed(
    context,
    route,
  );
}

widthScreen(context) => MediaQuery.of(context).size.width;

heightScreen(context) => MediaQuery.of(context).size.height;

SizedBox sizedHeight(double height) => SizedBox(
      height: height,
    );
SizedBox sizedWidth(double width) => SizedBox(
      width: width,
    );

showTopMessage({context, customBar}) {
  showTopSnackBar(
    Overlay.of(context),
    customBar,
  );
}

saveToken(UserResponse userResponse) {
  const storage = FlutterSecureStorage();
  storage.write(key: 'token', value: userResponse.token);
  storage.write(key: 'id', value: userResponse.user!.id);
  storage.write(key: 'phone', value: userResponse.user!.id);
  storage.write(key: 'deviceToken', value: userResponse.user!.deviceToken);
  storage.write(key: 'role', value: userResponse.user!.role);
  storage.write(key: 'lat', value: userResponse.user!.lat.toString());
    storage.write(key: 'lng', value: userResponse.user!.lng.toString());
  storage.write(key: 'name', value: userResponse.user!.fullName);
  storage.write(key: 'email', value: currentUser!.user!.email);
  storage.write(key: 'image', value:currentUser!.user!.profileImage);
}

readToken() async {
  // await getBaseUrl();
  const storage =  FlutterSecureStorage();
  try {

    AppModel.lang=(await storage.read(key: "lang"))!;
    // currentUser.token = (await storage.read(key: "token"))!;
    // currentUser.id=( await storage.read(key: "id"));
    // currentUser.role=( await storage.read(key: "role"));
    // currentUser.fullName=( await storage.read(key: "name"));
    // currentUser.profileImage=( await storage.read(key: "image"));
    // printFunction("token : ${currentUser.id!}");
  } catch (e) {}
}

Future saveData(key, value) async {
  const storage = FlutterSecureStorage();
  storage.write(key: key, value: value);
}

// Future getData(key)async{
//   const storage = FlutterSecureStorage();
//     try {
//    AppModel.page = (await storage.read(key: key)) ?? "";

//     print("AppModel.page : ${AppModel.page}");
//   } catch (e) {}

// }

// class PageModel {
//   int? number;

//   String? nameSurah;
//   List<Aya> ayates;

//   PageModel({this.number, this.nameSurah, this.ayates = const []});

//   factory PageModel.fromJson(Map<String, dynamic> json) => PageModel(
//       number: json["data"]["surahs"]["number"],
//       // pageNumber: json["data"]["surahs"]["number"],
//       nameSurah: json["data"]["surahs"]["name"],
//       ayates: List<Aya>.from((json["data"]["surahs"]["ayahs"] as List)
//           .map((e) => Aya.fromJson(e))));

//   toJson() => {
//         'number': number,
//         'nameSurah': nameSurah,
//         'ayates': ayates,
//       };
// }

// class Aya {
//   int? number;
//   String? audio;
//   List<String>? audioSecondary;
//   String? text;
//   int? numberInSurah;
//   int? juz;
//   int? manzil;
//   int? page;
//   int? ruku;
//   int? hizbQuarter;
//   String? sajda;

//   Aya(
//       {this.number,
//       this.audio,
//       this.audioSecondary,
//       this.text,
//       this.numberInSurah,
//       this.juz,
//       this.manzil,
//       this.page,
//       this.ruku,
//       this.hizbQuarter,
//       this.sajda});

//   Aya.fromJson(Map<String, dynamic> json) {
//     number = json['number'];
//     audio = json['audio'];
//     audioSecondary = json['audioSecondary'].cast<String>();
//     text = json['text'];
//     numberInSurah = json['numberInSurah'];
//     juz = json['juz'];
//     manzil = json['manzil'];
//     page = json['page'];
//     ruku = json['ruku'];
//     hizbQuarter = json['hizbQuarter'];
//     sajda = json['sajda'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['number'] = this.number;
//     data['audio'] = this.audio;
//     data['audioSecondary'] = this.audioSecondary;
//     data['text'] = this.text;
//     data['numberInSurah'] = this.numberInSurah;
//     data['juz'] = this.juz;
//     data['manzil'] = this.manzil;
//     data['page'] = this.page;
//     data['ruku'] = this.ruku;
//     data['hizbQuarter'] = this.hizbQuarter;
//     data['sajda'] = this.sajda;
//     return data;
//   }
// }

//
void showBottomSheetWidget(context, child) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      isDismissible: true,
      builder: (context) {
        return child;
      });
}

void showDialogWidget(BuildContext context, Widget child) {
  
  showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.all(20),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),

        content: child,
      );
    },
  );
}
