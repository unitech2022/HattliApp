import 'package:equatable/equatable.dart';

class ManualOrder extends Equatable {
  final int id;
  final int providerId;
  final int status;

  final String userId;
  final double totalCost;

  // final String driverId;
  final String desc;
  final String createdAt;

  ManualOrder(
      {required this.id,
      required this.providerId,
      required this.status,
      required this.userId,
      required this.totalCost,
      required this.desc,
      required this.createdAt});

  factory ManualOrder.fromJson(Map<String, dynamic> json) => ManualOrder(
      id: json["id"],
      providerId: json["providerId"],
      status: json["status"],
      userId: json["userId"],
      totalCost: json["totalCost"].toDouble(),
      desc: json["desc"],
      createdAt: json["createdAt"]);

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        providerId,
        status,
        userId,
        totalCost,
        desc,
        createdAt,
      ];
}
