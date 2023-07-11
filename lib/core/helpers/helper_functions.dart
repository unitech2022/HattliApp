import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hatlli/core/layout/app_fonts.dart';
import 'package:hatlli/core/widgets/texts.dart';
import 'package:hatlli/meduls/common/models/current_user.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../meduls/common/ui/select_type_account_screen/select_type_account_screen.dart';
import '../utils/app_model.dart';

pushPage(context, page) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}


FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
void firebaseCloudMessagingListeners() {
  if (Platform.isIOS) {
    _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  _firebaseMessaging.getToken().then((token) {
    AppModel.deviceToken = token!;
    if (kDebugMode) {
      print("${AppModel.deviceToken} =====> DIVICEToken");
    }
  });
}



late String currentCity = "";
LocationData locData = LocationData.fromMap({});
Future getLocation() async {
  Location location = Location();
  bool serviceEnabled;
  PermissionStatus permissionGranted;
  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      return;
    }
  }

  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      return;
    }
  }

  locData = await location.getLocation();

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
replacePage({context, page}) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => page));
}

pop(context) {
  Navigator.pop(context);
}

signOut({ctx}) async {
  const storage = FlutterSecureStorage();

  token = "";
  await storage.delete(key: "token");
  await storage.delete(key: "role");
  currentUser.token = '';
  currentUser.role = "";
  replacePage(context: ctx, page: const SelectTypeAccountScreen());
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

bool isLogin() {
  return currentUser.token != null;
}

showTopMessage({context, customBar}) {
  showTopSnackBar(
    Overlay.of(context),
    customBar,
  );
}

saveToken(UserDetailsPref user) {
  const storage = FlutterSecureStorage();
  storage.write(key: 'token', value: user.token);
  storage.write(key: 'id', value: user.id);
  storage.write(key: 'userName', value: user.userName);

  storage.write(key: 'deviceToken', value: user.deviceToken);
  storage.write(key: 'role', value: user.role);
  // storage.write(key: 'lat', value: userResponse.user!.lat.toString());
  //   storage.write(key: 'lng', value: userResponse.user!.lng.toString());
  // storage.write(key: 'name', value: userResponse.user!.fullName);
  // storage.write(key: 'email', value: currentUser!.user!.email);
  // storage.write(key: 'image', value:currentUser!.user!.profileImage

  // );
}

readToken() async {
  // await getBaseUrl();
  const storage = FlutterSecureStorage();
  try {
    currentUser.token =token  =(await storage.read(key: "token"))!;
    currentUser.id = (await storage.read(key: "id"));
    currentUser.role = (await storage.read(key: "role"));
    // currentUser!.fullName != (await storage.read(key: "name"));
    currentUser.userName = (await storage.read(key: "userName"));
    currentUser.deviceToken = (await storage.read(key: "deviceToken") ?? "");
    if (kDebugMode) {
      print("token : $token");
    }
  } catch (e) {
    print(e.toString() + " sfsdl");
  }
}

Future<void> showMyDialog({context, onTap}) async {
  return showDialog<void>(
    context: context,

    barrierDismissible: false,
    // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 30),
        content: Container(
          // padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
          width: widthScreen(context),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        pop(context);
                      },
                      child: SvgPicture.asset("assets/icons/close.svg")),
                ],
              ),
              SvgPicture.asset("assets/icons/location.svg"),
              const SizedBox(
                height: 16,
              ),
              const Texts(
                  title: "هل تسمح بالتطبيق بالوصول لموقعك ",
                  family: AppFonts.moS,
                  size: 12,
                  textColor: Colors.black,
                  widget: FontWeight.w700),
              const SizedBox(
                height: 23,
              ),
              GestureDetector(
                onTap: onTap,
                child: const Texts(
                    title: "نعم أسمح بذلك ",
                    family: AppFonts.moS,
                    size: 13,
                    textColor: Color(0xffB8B8B8),
                    widget: FontWeight.w700),
              ),
              const SizedBox(
                height: 23,
              ),
            ],
          ),
        ),
      );
    },
  );
}

  Future<void> showDialogSuccess({context,message}) {

     return showDialog<void>(
    context: context,

    barrierDismissible: false,
    // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 30),
        content: Container(
          // padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
          width: widthScreen(context),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        pop(context);
                      },
                      child: SvgPicture.asset("assets/icons/close.svg")),
                ],
              ),
              SvgPicture.asset("assets/icons/successd.svg"),
              const SizedBox(
                height: 16,
              ),
               Texts(
                  title: message,
                  family: AppFonts.taM,
                  size: 20,
                  textColor: Colors.black,
                  widget: FontWeight.normal),
             ],
          ),
        ),
      );
    },
  );
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
    
    barrierDismissible: false, 
    // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        insetPadding: const EdgeInsets.all(20),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        content: child,
      );
    },
  );
}
