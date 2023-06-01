// To parse this JSON data, do
//
// final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  Login({
    required this.status,
    required this.message,
    required this.token,
  });

  bool status;
  String message;
  String? token;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        status: json["status"],
        message: json["message"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
