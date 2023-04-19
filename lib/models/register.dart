// To parse this JSON data, do
//
//     final registerSuccess = registerSuccessFromJson(jsonString);

import 'dart:convert';

RegisterSuccess registerSuccessFromJson(String str) =>
    RegisterSuccess.fromJson(json.decode(str));

String registerSuccessToJson(RegisterSuccess data) =>
    json.encode(data.toJson());

class RegisterSuccess {
  RegisterSuccess({
    required this.status,
    required this.message,
    required this.token,
  });

  bool status;
  String message;
  String token;

  factory RegisterSuccess.fromJson(Map<String, dynamic> json) =>
      RegisterSuccess(
        status: json["status"],
        message: json["message"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "token": token,
      };
}

// To parse this JSON data, do
//
//     final userExists = userExistsFromJson(jsonString);

UserExists userExistsFromJson(String str) =>
    UserExists.fromJson(json.decode(str));

String userExistsToJson(UserExists data) => json.encode(data.toJson());

class UserExists {
  UserExists({
    required this.status,
    required this.message,
    required this.errors,
  });

  bool status;
  String message;
  Errors errors;

  factory UserExists.fromJson(Map<String, dynamic> json) => UserExists(
        status: json["status"],
        message: json["message"],
        errors: Errors.fromJson(json["errors"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "errors": errors.toJson(),
      };
}

class Errors {
  Errors({
    required this.email,
  });

  List<String> email;

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        email: List<String>.from(json["email"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "email": List<dynamic>.from(email.map((x) => x)),
      };
}
