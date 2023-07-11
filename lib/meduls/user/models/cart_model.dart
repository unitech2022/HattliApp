class CartModel {
  final int id;
  final String userId;
  final int productId;
  final int providerId;
  final int quantity;
  final int status;
  final int orderId;
  final double cost;
  
  final String createdAt;

  CartModel(
      {required this.id,
      required this.userId,
      required this.productId,
      required this.providerId,
      required this.quantity,
      required this.status,
      required this.orderId,
      required this.cost,
      
      required this.createdAt});

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
      id: json["id"],
      userId: json["userId"],
      productId: json["productId"],
      providerId: json["providerId"],
      quantity: json["quantity"],
      status: json["status"],
      orderId: json["orderId"],
      cost: json["cost"].toDouble(),
      // options: json["options"]??"not",
      createdAt: json["createdAt"]);
}
