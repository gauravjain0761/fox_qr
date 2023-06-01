// To parse this JSON data, do
//
//     final qrDetail = qrDetailFromJson(jsonString);

import 'dart:convert';

QrDetail qrDetailFromJson(String str) => QrDetail.fromJson(json.decode(str));

String qrDetailToJson(QrDetail data) => json.encode(data.toJson());

class QrDetail {
  bool status;
  Qr qr;

  QrDetail({
    required this.status,
    required this.qr,
  });

  factory QrDetail.fromJson(Map<String, dynamic> json) => QrDetail(
        status: json["status"],
        qr: Qr.fromJson(json["qr"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "qr": qr.toJson(),
      };
}

class Qr {
  String id;
  int userId;
  int qrTypeId;
  String qrName;
  String qrStyle;
  String qrText;
  String qrImage;
  int scanCount;
  DateTime expiry;
  DateTime createdAt;
  DateTime updatedAt;
  QrType qrType;

  Qr({
    required this.id,
    required this.userId,
    required this.qrTypeId,
    required this.qrName,
    required this.qrStyle,
    required this.qrText,
    required this.qrImage,
    required this.scanCount,
    required this.expiry,
    required this.createdAt,
    required this.updatedAt,
    required this.qrType,
  });

  factory Qr.fromJson(Map<String, dynamic> json) => Qr(
        id: json["id"],
        userId: json["user_id"],
        qrTypeId: json["qr_type_id"],
        qrName: json["qr_name"],
        qrStyle: json["qr_style"],
        qrText: json["qr_text"],
        qrImage: json["qr_image"],
        scanCount: json["scan_count"],
        expiry: DateTime.parse(json["expiry"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        qrType: QrType.fromJson(json["qr_type"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "qr_type_id": qrTypeId,
        "qr_name": qrName,
        "qr_style": qrStyle,
        "qr_text": qrText,
        "qr_image": qrImage,
        "scan_count": scanCount,
        "expiry": expiry.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "qr_type": qrType.toJson(),
      };
}

class QrType {
  int id;
  String name;
  int isFree;
  int isTrackable;
  DateTime createdAt;
  DateTime updatedAt;

  QrType({
    required this.id,
    required this.name,
    required this.isFree,
    required this.isTrackable,
    required this.createdAt,
    required this.updatedAt,
  });

  factory QrType.fromJson(Map<String, dynamic> json) => QrType(
        id: json["id"],
        name: json["name"],
        isFree: json["is_free"],
        isTrackable: json["is_trackable"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "is_free": isFree,
        "is_trackable": isTrackable,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
