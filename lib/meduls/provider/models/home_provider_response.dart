import '../../common/models/address_model.dart';
import '../../common/models/category.dart';
import '../../common/models/order.dart';
import '../../common/models/product.dart';
import '../../common/models/provider.dart';
import '../../common/models/user_response.dart';

class HomeResponseProvider {
  AddressModel? address;
  List<Product>? products;
  List<OrderResponse>? orders;
  List<CategoryModel>? categories;
  Provider? provider;
  UserModel? user;
  int? notiyCount;
  

  HomeResponseProvider(
      {this.address,
      this.products,
      this.categories,
      this.orders,
      this.provider,
      this.user,
      this.notiyCount});

  HomeResponseProvider.fromJson(Map<String, dynamic> json) {
    address =
        json['address'] != null ? AddressModel.fromJson(json['address']) : null;
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products!.add(Product.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories!.add(CategoryModel.fromJson(v));
      });
    }
    if (json['orders'] != null) {
      orders = [];
      json['orders'].forEach((v) {
        orders!.add(OrderResponse.fromJson(v));
      });
    }
    provider =
        json['provider'] != null ? Provider.fromJson(json['provider']) : null;
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    notiyCount = json['notiyCount'];
  }
}
