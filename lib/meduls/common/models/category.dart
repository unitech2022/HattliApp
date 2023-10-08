import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final int id;
  final String name;
  final String nameEng;
  final String imageUrl;
  final int status;
  final String createdAt;

  const CategoryModel(
      {required this.id,
      required this.name,
      required this.nameEng,
      required this.imageUrl,
      required this.status,
      required this.createdAt});

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
      id: json["id"],
      name: json["name"],
      nameEng: json["nameEng"],
      imageUrl: json["imageUrl"],
      status: json["status"],
      createdAt: json["createdAt"]);

  @override
  List<Object?> get props => [id, name, imageUrl, status, nameEng, createdAt];
}
