import 'package:hatlli/meduls/common/models/order.dart';

class ResponseTotalOrder {
  final List<Order> successOrders;
    final List<Order> unsuccessfulOrders;

  ResponseTotalOrder({required this.successOrders, required this.unsuccessfulOrders});

    factory ResponseTotalOrder.fromJson(Map<String, dynamic> json) => ResponseTotalOrder(
      successOrders:List<Order>.from(
          (json["successOrders"] as List).map((e) => Order.fromJson(e))),
      unsuccessfulOrders: List<Order>.from(
          (json["unsuccessfulOrders"] as List).map((e) => Order.fromJson(e))));
}

