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

// To parse this JSON data, do
//
//     final createQrAuth = createQrAuthFromJson(jsonString);

// CreateQrAuth createQrAuthFromJson(String str) =>
//     CreateQrAuth.fromJson(json.decode(str));

// String createQrAuthToJson(CreateQrAuth data) => json.encode(data.toJson());

// class CreateQrAuth {
//   bool success;
//   String message;
//   String image;
//   QrType qrType;

//   CreateQrAuth({
//     required this.success,
//     required this.message,
//     required this.image,
//     required this.qrType,
//   });

//   factory CreateQrAuth.fromJson(Map<String, dynamic> json) => CreateQrAuth(
//         success: json["success"],
//         message: json["message"],
//         image: json["image"],
//         qrType: QrType.fromJson(json["qr_type"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "message": message,
//         "image": image,
//         "qr_type": qrType.toJson(),
//       };
// }

// class QrType {
//   int id;
//   String name;
//   int isFree;
//   int isTrackable;
//   DateTime createdAt;
//   DateTime updatedAt;

//   QrType({
//     required this.id,
//     required this.name,
//     required this.isFree,
//     required this.isTrackable,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory QrType.fromJson(Map<String, dynamic> json) => QrType(
//         id: json["id"],
//         name: json["name"],
//         isFree: json["is_free"],
//         isTrackable: json["is_trackable"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "is_free": isFree,
//         "is_trackable": isTrackable,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//       };
// }
