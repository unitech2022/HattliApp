import 'package:hatlli/meduls/common/models/rate_model.dart';
import 'package:hatlli/meduls/common/models/user_response.dart';

class RateResponse {
  final RateModel rate;
  final UserModel user;

  RateResponse({required this.rate, required this.user});

  factory RateResponse.fromJson(Map<String, dynamic> json) => RateResponse(
      rate: RateModel.fromJson(json["rate"]),
      user: UserModel.fromJson(json["user"]));
}
