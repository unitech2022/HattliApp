import 'package:hatlli/meduls/user/models/cart_model.dart';

import '../../common/models/address_model.dart';
import '../../common/models/category.dart';
import '../../common/models/order.dart';
import '../../common/models/provider.dart';
import '../../common/models/user_response.dart';
import 'favoraite.dart';

class HomeUserResponse {
  AddressModel? address;
  List<Provider>? providers;
  List<Favorite>? favorites;
   List<CategoryModel>? categories;
  List<OrderResponse>? orders;
    List<CartModel>? carts;
  UserModel? user;
  int? notiyCount;

  HomeUserResponse(
      {this.address,
      this.providers,
      this.favorites,
      this.orders,
       this.categories,
      this.carts,
      this.user,
      this.notiyCount});

  HomeUserResponse.fromJson(Map<String, dynamic> json) {
    address =
        json['address'] != null ? AddressModel.fromJson(json['address']) : null;
    if (json['providers'] != null) {
      providers = [];
     
      json['providers'].forEach((v) {
        providers!.add(Provider.fromJson(v));
      });
    }
     if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories!.add(CategoryModel.fromJson(v));
      });
    }
      if (json['carts'] != null) {
      carts = [];
      json['carts'].forEach((v) {
        carts!.add(CartModel.fromJson(v));
      });
    }
    if (json['favorites'] != null) {
      favorites = [];
      json['favorites'].forEach((v) {
        favorites!.add(Favorite.fromJson(v));
      });
    }
    if (json['orders'] != null) {
      orders = [];
      json['orders'].forEach((v) {
        orders!.add(OrderResponse.fromJson(v));
      });
    }
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    notiyCount = json['notiyCount'];
  }
}

