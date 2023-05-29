class CheckUserResponse {
    int status;
    String code;

    CheckUserResponse({
        required this.status,
        required this.code,
    });

    factory CheckUserResponse.fromJson(Map<String, dynamic> json) => CheckUserResponse(
        status: json["status"],
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
    };
}
