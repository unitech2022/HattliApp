import 'package:hatlli/meduls/common/models/provider.dart';
import 'package:hatlli/meduls/common/models/user_response.dart';

class ReviewModel {
  final double wallet;
  final int ordersAccepted;
  final int ordersCanceled;
 final int products;
  final Provider provider;
    final Address most;

  ReviewModel(
      {required this.wallet,
      required this.products,
      required this.most,
      required this.ordersAccepted,
        required this.provider,
      required this.ordersCanceled});

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
      wallet: json["wallet"].toDouble(),
      ordersAccepted: json["ordersAccepted"],
      ordersCanceled: json["ordersCanceled"],
       products: json["products"],
        provider: Provider.fromJson(json ["provider"]),
         most: Address.fromJson(json ["most"]),
        );
        
}
