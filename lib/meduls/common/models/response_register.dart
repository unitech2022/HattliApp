class ResponseRegister {
  final String message;
  final bool status;

  ResponseRegister({required this.message, required this.status});
  factory ResponseRegister.fromJson(Map<String, dynamic> json) {
    return ResponseRegister(message: json["message"], status: json["status"]);
  }
}