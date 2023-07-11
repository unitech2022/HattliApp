class AddressModel {
  int? id;
  String? userId;
  String? description;
  String? name;
  double? lat;
  double? lng;
  bool? defaultAddress;
  String? createdAt;

  AddressModel(
      {this.id,
      this.userId,
      this.description,
      this.name,
      this.lat,
      this.lng,
      this.defaultAddress,
      this.createdAt});

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    description = json['description'];
    name = json['name'];
    lat = json['lat'];
    lng = json['lng'];
    defaultAddress = json['defaultAddress'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['description'] = description;
    data['name'] = name;
    data['lat'] = lat;
    data['lng'] = lng;
    data['defaultAddress'] = defaultAddress;
    data['createdAt'] = createdAt;
    return data;
  }
}
