// To parse this JSON data, do
//
//     final qrTypes = qrTypesFromJson(jsonString);

import 'dart:convert';

QrTypes qrTypesFromJson(String str) => QrTypes.fromJson(json.decode(str));

String qrTypesToJson(QrTypes data) => json.encode(data.toJson());

class QrTypes {
  QrTypes({
    required this.success,
    required this.qrTypes,
  });

  bool success;
  List<QrType> qrTypes;

  factory QrTypes.fromJson(Map<String, dynamic> json) => QrTypes(
        success: json["success"],
        qrTypes:
            List<QrType>.from(json["qr_types"].map((x) => QrType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "qr_types": List<dynamic>.from(qrTypes.map((x) => x.toJson())),
      };
}

class QrType {
  QrType({
    required this.id,
    required this.name,
    required this.isFree,
    required this.isTrackable,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  int isFree;
  int isTrackable;
  DateTime createdAt;
  DateTime updatedAt;

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
