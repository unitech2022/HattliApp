import 'package:equatable/equatable.dart';

class Provider extends Equatable{
  final int id;
  final int categoryId;
  final String title;
  final String userId;
  final String email;  
  final String about;
  final String logoCompany;
  final String imagePassport;
  final String nameAdministratorCompany;
  final String addressName;
  final double lat;
  final double lng;
  final double rate;
  final int status;
  final double discount;
  final double distance;
  final String createdAt;

  const Provider(
      {required this.id,
      required this.categoryId,
      required this.title,
       required this.email,
      required this.userId,
      required this.about,
      required this.logoCompany,
      required this.imagePassport,
      required this.nameAdministratorCompany,
      required this.addressName,
      required this.lat,
      required this.lng,
      required this.rate,
      required this.status,
      required this.discount,
      required this.distance,
      required this.createdAt});

  factory Provider.fromJson(Map<String, dynamic> json) => Provider(
        id: json['id'],
        categoryId: json['categoryId'],
        title: json['title'],
        userId: json['userId'],
        email: json['email'],
        about: json['about'],
        logoCompany: json['logoCompany'],
        imagePassport: json['imagePassport'],
        nameAdministratorCompany: json['nameAdministratorCompany'],
        addressName: json['addressName'],
        lat: json['lat'].toDouble(),
        lng: json['lng'].toDouble(),
        rate: json['rate'].toDouble(),
        status: json['status'],
        discount: json['discount'].toDouble(),
        distance: json['distance'].toDouble(),
        createdAt: json['createdAt'],
      );
      
        @override
        // TODO: implement props
        List<Object?> get props => [id,
      categoryId,
     title,
     userId,
      about,
     logoCompany,
    imagePassport,
    nameAdministratorCompany,
    addressName,
     lat,
      lng,
     rate,
     status,
     discount,
 distance,
      createdAt];

 
}
