import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final int providerId;
  final int categoryId;
  final String brandId;
  final String name;
  final String description;
  final String images;
  final String sizes;
  final double price;
  final double discount;
  final int status;
  final String calories;
  final double rate;
  final String createdAt;

  const Product(
      {required this.id,
      required this.providerId,
      required this.categoryId,
      required this.brandId,
      required this.name,
      required this.description,
      required this.images,
      required this.sizes,
      required this.price,
      required this.discount,
      required this.status,
      required this.calories,
      required this.rate,
      required this.createdAt});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        providerId: json['providerId'],
        categoryId: json['categoryId'],
        brandId : json['brandId'],
        name: json['name'],
        description: json['description'],
        images: json['images'],
        sizes: json['sizes'],
        price: json['price'].toDouble(),
        discount: json['discount'].toDouble(),
        status: json['status'],
        calories: json['calories'],
        rate: json['rate'].toDouble(),
        createdAt: json['createdAt'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['providerId'] = providerId;
    data['categoryId'] = categoryId;
    data['brandId'] = brandId;
    data['name'] = name;
    data['description'] = description;
    data['images'] = images;
    data['sizes'] = sizes;
    data['price'] = price;
    data['discount'] = discount;
    data['status'] = status;
    data['calories'] = calories;
    data['rate'] = rate;
    data['createdAt'] = createdAt;
    return data;
  }

  @override
  List<Object?> get props => [
       id,
  providerId,
categoryId,
   brandId,
 name,
 description,
 images,
  sizes,
  price,
 discount,
 status,
  calories,
   rate,
 createdAt,
  ];
}
