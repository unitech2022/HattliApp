import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable{
  final int id;
  final String name;
  final String imageUrl;
  final int status;
  final String createdAt;

  const CategoryModel(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.status,
      required this.createdAt});

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
      id: json["id"],
      name: json["name"],
      imageUrl: json["imageUrl"],
      status: json["status"],
      createdAt: json["createdAt"]);
      
        @override
        // TODO: implement props
        List<Object?> get props => [id,name,imageUrl,status,createdAt];
}
