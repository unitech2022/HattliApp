import 'package:hatlli/meduls/common/models/address_model.dart';
import 'package:hatlli/meduls/common/models/order.dart';
import 'package:hatlli/meduls/common/models/product.dart';
import 'package:hatlli/meduls/common/models/provider.dart';
import 'package:hatlli/meduls/common/models/user_response.dart';

class OrderDetailsResponse {
  Order? order;
  List<ProductOrder>? products;
  Provider? provider;
  AddressModel? address;
  UserModel? userModel;

  OrderDetailsResponse(
      {this.order, this.products, this.provider, this.address, this.userModel});

  OrderDetailsResponse.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ? Order.fromJson(json['order']) : null;
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products!.add(ProductOrder.fromJson(v));
      });
    }
    provider =
        json['provider'] != null ? Provider.fromJson(json['provider']) : null;
    address =
        json['address'] != null ? AddressModel.fromJson(json['address']) : null;
    userModel = json['userDetail'] != null
        ? UserModel.fromJson(json['userDetail'])
        : null;
  }
}

class ProductOrder {
  OrderItem? order;
  Product? product;

  ProductOrder({this.order, this.product});

  ProductOrder.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ? OrderItem.fromJson(json['order']) : null;
    product =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }
}

class OrderItem {
  int? id;
  int? productId;
  int? quantity;

  int? orderId;
  int? cost;
  String? userId;
  String? createdAt;

  OrderItem(
      {this.id,
      this.productId,
      this.quantity,
      this.orderId,
      this.cost,
      this.userId,
      this.createdAt});

  OrderItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['productId'];
    quantity = json['quantity'];

    orderId = json['orderId'];
    cost = json['cost'];
    userId = json['userId'];
    createdAt = json['createdAt'];
  }
}
