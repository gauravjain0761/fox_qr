// To parse this JSON data, do
//
//     final createQr = createQrFromJson(jsonString);

import 'dart:convert';

CreateQr createQrFromJson(String str) => CreateQr.fromJson(json.decode(str));

String createQrToJson(CreateQr data) => json.encode(data.toJson());

class CreateQr {
  CreateQr({
    required this.success,
    required this.message,
    required this.image,
  });

  bool success;
  String message;
  String image;

  factory CreateQr.fromJson(Map<String, dynamic> json) => CreateQr(
        success: json["success"],
        message: json["message"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "image": image,
      };
}
