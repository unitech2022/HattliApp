import 'package:equatable/equatable.dart';
import 'package:hatlli/meduls/common/models/product.dart';

class ProductsResponsePagination extends Equatable {
  final int currentPage;
  final int totalPages;
  final List<Product> items;

  ProductsResponsePagination(
      {required this.currentPage,
      required this.totalPages,
      required this.items});

  factory ProductsResponsePagination.fromJson(Map<String, dynamic> json) =>
      ProductsResponsePagination(
          currentPage: json["currentPage"],
          totalPages: json["totalPages"],
          items: List<Product>.from(
              (json["items"] as List).map((e) => Product.fromJson(e))));
  @override
  List<Object?> get props => [currentPage, totalPages, items];
}
