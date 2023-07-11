import 'package:hatlli/meduls/common/models/product.dart';
import 'package:hatlli/meduls/user/models/cart_model.dart';


class CartResponse {
  List<CartDetails>? carts;

  int? countProducts;
  double? totalCost;

  CartResponse({this.carts, this.countProducts, this.totalCost});

  CartResponse.fromJson(Map<String, dynamic> json) {
    if (json['carts'] != null) {
      carts = [];
      json['carts'].forEach((v) {
        carts!.add(CartDetails.fromJson(v));
      });
    }

    countProducts = json['countProducts'];
    totalCost = json['totalCost'].toDouble();
  }
}

class CartDetails {
  final CartModel cart;
  final Product product;

  CartDetails({required this.cart, required this.product});
  factory CartDetails.fromJson(Map<String, dynamic> json) => CartDetails(
      cart: CartModel.fromJson(json["cart"]),
      product: Product.fromJson(json["product"]));
}
