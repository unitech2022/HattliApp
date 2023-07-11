import '../../common/models/product.dart';

class FavoriteResponse {
  final Favorite favorite;
  final Product product;

  FavoriteResponse({required this.favorite, required this.product});

  factory FavoriteResponse.fromJson(Map<String, dynamic> json) =>
      FavoriteResponse(
          favorite: Favorite.fromJson(json['favorite']),
          product: Product.fromJson(json['product']));
}

class Favorite {
  int? id;
  String? userId;
  int? productId;
  int? providerId;
  String? createdAt;

  Favorite(
      {this.id, this.userId, this.productId, this.providerId, this.createdAt});

  Favorite.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    productId = json['productId'];
    providerId = json['providerId'];
    createdAt = json['createdAt'];
  }
}
