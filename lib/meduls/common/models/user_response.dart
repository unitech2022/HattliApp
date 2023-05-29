import 'dart:convert';

import 'package:equatable/equatable.dart';

UserResponse userResponseFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse extends Equatable {
  String? token;
  UserModel? user;
  DateTime? expiration;
  bool? status;
  // Address? address;

  UserResponse({
    required this.token,
    required this.user,
    required this.expiration,
    required this.status,
    // required this.address,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        token: json["token"],
        user: UserModel.fromJson(json["user"]),
        expiration: DateTime.parse(json["expiration"]),
        status: json["status"],
        // address: Address.fromJson(json["address"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user!.toJson(),
        "expiration": expiration.toString(),
        "status": status,
        // "address": address!.toJson(),
      };

  @override
  List<Object?> get props => [token, user, expiration, status];
}

class Address extends Equatable {
  final int id;
  final String userId;
  final String description;
  final String name;
  final double lat;
  final double lng;
  final bool defaultAddress;
  final DateTime createdAt;

  const Address({
    required this.id,
    required this.userId,
    required this.description,
    required this.name,
    required this.lat,
    required this.lng,
    required this.defaultAddress,
    required this.createdAt,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        userId: json["userId"],
        description: json["description"],
        name: json["name"],
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
        defaultAddress: json["defaultAddress"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "description": description,
        "name": name,
        "lat": lat,
        "lng": lng,
        "defaultAddress": defaultAddress,
        "createdAt": createdAt.toIso8601String(),
      };

  @override
  List<Object?> get props =>
      [id, userId, defaultAddress, description, lat, lng, createdAt];
}

class UserModel extends Equatable {
   final String id;
     final String userName;
     final String email;
  final String role;
  final String fullName;
  final String nameAdministratorCompany;
  final String deviceToken;
  final int status;
  final String about;
  final String code;
  final String profileImage;
  final String logoCompany;
  final String imagePassport;
  String typeService;
  final String city;
  double points;
  final String address;
  final double lat;
  final double lng;
  final double rate;
  final double surveysBalance;
  final String createdAt;

  UserModel(
      {
        required this.id,
         required this.userName,
          required this.email,
        required this.role,
      required this.fullName,
      required this.nameAdministratorCompany,
      required this.deviceToken,
      required this.status,
      required this.about,
      required this.code,
      required this.profileImage,
      required this.logoCompany,
      required this.imagePassport,
      required this.typeService,
      required this.city,
      required this.points,
      required this.address,
      required this.lat,
      required this.lng,
      required this.rate,
      required this.surveysBalance,
      required this.createdAt});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
       id : json['id'],
          userName : json['userName'],
     role : json['role'],
       email : json['email'],
    fullName : json['fullName'],
    nameAdministratorCompany : json['nameAdministratorCompany']??"",
    deviceToken : json['deviceToken'],
    status : json['status'],
    about : json['about']??"",
    code : json['code'],
    profileImage : json['profileImage']??"",
    logoCompany : json['logoCompany']??"",
    imagePassport : json['imagePassport']??"",
    typeService : json['typeService']??"",
    city : json['city'],
    points : json['points'],
    address : json['address'],
    lat : json['lat'],
    lng : json['lng'],
    rate : json['rate'],
    surveysBalance : json['surveysBalance'],
    createdAt : json['createdAt'],
  );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['role'] = role;
    data['fullName'] = fullName;
    data['nameAdministratorCompany'] = nameAdministratorCompany;
    data['deviceToken'] = deviceToken;
    data['status'] = status;
    data['about'] = about;
    data['code'] = code;
    data['profileImage'] = profileImage;
    data['logoCompany'] = logoCompany;
    data['imagePassport'] = imagePassport;
    data['typeService'] = typeService;
    data['city'] = city;
    data['points'] = points;
    data['address'] = address;
    data['lat'] = lat;
    data['lng'] = lng;
    data['rate'] = rate;
    data['surveysBalance'] = surveysBalance;
    data['createdAt'] = createdAt;
    return data;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        fullName,
       userName,
       email,
        profileImage,
        role,
        deviceToken,
        status,
        code,
       
        city,
       rate,
       lat,
       lng,
       imagePassport,
       logoCompany,
       typeService,
       address,
       about,
       profileImage,
        points,
        surveysBalance,
        createdAt
      ];
}
