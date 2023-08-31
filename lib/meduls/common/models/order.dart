import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';

import 'address_model.dart';

class OrderResponse extends Equatable {
  final Order order;
  final AddressModel address;
  final String name;
  final String imageUrl;

  const OrderResponse(
      {required this.order,
      required this.name,
      required this.imageUrl,
      required this.address});

  factory OrderResponse.fromJson(Map<String, dynamic> json) => OrderResponse(
        order: Order.fromJson(json['order']),
        address: json['address'] != null
            ? AddressModel.fromJson(json['address'])
            : AddressModel(),
        name: json['name'] ==null ?"غير معروف".tr(): json['name'],
        imageUrl: json['imageUrl'] == null ? "غير معروف".tr():json['imageUrl'],
      );

  @override
  List<Object?> get props => [order, name, imageUrl];
}

class Order extends Equatable {
  final int id;
  final int providerId;
  final int status;
  final int payment;
  final String userId;
  final double totalCost;
  final double productsCost;
  // final String driverId;
  final String notes;
  final String createdAt;

  const Order(
      {required this.id,
      required this.providerId,
      required this.status,
      required this.userId,
      required this.totalCost,
      required this.productsCost,
      // required this.driverId,
      required this.notes,
      required this.payment,
      required this.createdAt});

  factory Order.fromJson(Map<String, dynamic> json) => Order(
      id: json["id"],
      providerId: json["providerId"],
      status: json["status"],
      userId: json["userId"],
      totalCost: json["totalCost"].toDouble(),
      productsCost: json["productsCost"].toDouble(),
      // driverId: json["driverId"],
      notes: json["notes"],
      payment: json["payment"],
      createdAt: json["createdAt"]);

  factory Order.fromJsonHome(Map<String, dynamic> json) => Order(
      id: json["order"]["id"],
      providerId: json["order"]["providerId"],
      status: json["order"]["status"],
      userId: json["order"]["userId"],
      totalCost: json["order"]["totalCost"].toDouble(),
      productsCost: json["order"]["productsCost"].toDouble(),
      // driverId: json["driverId"],
      notes: json["order"]["notes"],
      payment: json["order"]["payment"],
      createdAt: json["order"]["createdAt"]);

  @override
  List<Object?> get props => [
        id,
        providerId,
        status,
        userId,
        totalCost,
        productsCost,
        notes,
        createdAt,
        payment
      ];
}
