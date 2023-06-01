// To parse this JSON data, do
//
//     final pastQrs = pastQrsFromJson(jsonString);

import 'dart:convert';

PastQrs pastQrsFromJson(String str) => PastQrs.fromJson(json.decode(str));

String pastQrsToJson(PastQrs data) => json.encode(data.toJson());

class PastQrs {
  bool success;
  Qrs qrs;

  PastQrs({
    required this.success,
    required this.qrs,
  });

  factory PastQrs.fromJson(Map<String, dynamic> json) => PastQrs(
        success: json["success"],
        qrs: Qrs.fromJson(json["qrs"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "qrs": qrs.toJson(),
      };
}

class Qrs {
  int currentPage;
  List<Datum> data;
  String firstPageUrl;
  dynamic from;
  int lastPage;
  String lastPageUrl;
  List<Link> links;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  dynamic to;
  int total;

  Qrs({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    this.nextPageUrl,
    required this.path,
    required this.perPage,
    this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory Qrs.fromJson(Map<String, dynamic> json) => Qrs(
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Datum {
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

  Datum({
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
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
      };
}

class Link {
  String? url;
  dynamic label;
  bool active;

  Link({
    this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
