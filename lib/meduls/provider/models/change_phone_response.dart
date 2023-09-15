class ChangePhoneResponse {
  final bool status;
  final String message;

  ChangePhoneResponse({required this.status, required this.message});

  factory ChangePhoneResponse.fromJson(Map<String, dynamic> json) =>
      ChangePhoneResponse(status: json["status"], message: json["message"]);
}
