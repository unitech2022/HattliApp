
import 'package:flutter/material.dart';
import 'package:hatlli/meduls/provider/ui/account_provider_screen/account_provider_screen.dart';
import 'package:hatlli/meduls/provider/ui/home_screen/home_screen.dart';
import 'package:hatlli/meduls/provider/ui/orders_provider_screen/orders_provider_screen.dart';
import 'package:hatlli/meduls/provider/ui/products_provider_screen/products_provider_screen.dart';
import 'package:hatlli/meduls/user/ui/account_screen/account_screen.dart';
import 'package:hatlli/meduls/user/ui/home_user_screen/home_user_screen.dart';
import 'package:hatlli/meduls/user/ui/orders_screen/orders_screen.dart';
import 'package:hatlli/meduls/user/ui/providers_screen/providers_screen.dart';

import '../../meduls/common/models/category.dart';
import '../../meduls/common/models/current_user.dart';
import '../../meduls/common/models/provider.dart';

UserDetailsPref currentUser = UserDetailsPref();
Provider? currentProvider;
String token = "";

class AppModel {
  static String userRole = "user";
  static String providerRole = "provider";
  static String token = "";
  static String lang = "";
  static String deviceToken = "";
    static String apiKey = "AIzaSyCHcAKXFZuQ8WhkAvW1zv3MTVibHU9EuF0";
}

List<Widget> screensUser = [
  const HomeUserScreen(),
  OrdersScreen(),
  ProvidersScreen(),
  AccountScreen()
];

List<Widget> screensProvider = [
  const HomeProviderScreen(),
  const OrdersProviderScreen(),
  const ProductsProviderScreen(),
  const AccountProviderScreen()
];

String aboutUs = """هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، 
لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن 
تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى 
زيادة عدد الحروف التى يولدها""";

String servicesText = """هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، 
لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن 
تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى 
زيادة عدد الحروف التى يولدها """;

List<CategoryModel> categories = [];

List<String> brands = ["Marka 1", "Marka 2", "Marka 3", "Marka 4", "Marka 5"];

class ColorModel {
  Color color;
  String name;
  bool isSelector;

  ColorModel(
      {required this.color, required this.name, required this.isSelector});
}

class SizeModel {
  String name;
  bool isSelector;

  SizeModel({required this.name, required this.isSelector});
}

List<ColorModel> colorsList = [
  ColorModel(color: Colors.green, name: "أخضر", isSelector: false),
  ColorModel(color: Colors.red, name: "أحمر", isSelector: false),
  ColorModel(color: Colors.black, name: "أسود", isSelector: false),
  ColorModel(color: Colors.white, name: "أبيض", isSelector: false),
  ColorModel(color: Colors.blue, name: "ازرق", isSelector: false),
  ColorModel(color: Colors.yellow, name: "اصفر", isSelector: false),
];

List<SizeModel> sizesList = [
  SizeModel(name: "S", isSelector: false),
  SizeModel(name: "M", isSelector: false),
  SizeModel(name: "L", isSelector: false),
  SizeModel(name: "XL", isSelector: false),
];

List<String> orderStatus = ["جديد", "قيد التجهيز", "قيد التوصيل", "مستلم ","ملغي"];
