import 'package:hatlli/meduls/common/models/product.dart';
import 'package:hatlli/meduls/common/models/provider.dart';

class SearchProductResponse {
  final Provider provider;
  final Product product;

  SearchProductResponse({required this.provider, required this.product});

  factory SearchProductResponse.fromJson(Map<String, dynamic> json) =>
      SearchProductResponse(
          provider: Provider.fromJson(json["provider"]),
          product: Product.fromJson(json["product"]));
}
