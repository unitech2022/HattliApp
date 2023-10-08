class RateModel {
  final int id;
  final int productId;
  final String userId;
  final String comment;
  final int stare;
  final String createAte;

  RateModel(
      {required this.id,
      required this.productId,
      required this.userId,
      required this.comment,
      required this.stare,
      required this.createAte});

  factory RateModel.fromJson(Map<String, dynamic> json) => RateModel(
      id: json["id"],
      productId: json["productId"],
      userId: json["userId"],
      comment: json["comment"]!=null? json["comment"]:"",
      stare: json["stare"],
      createAte: json["createAte"]);
}
