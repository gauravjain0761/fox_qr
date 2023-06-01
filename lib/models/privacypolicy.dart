// To parse this JSON data, do
//
//     final privacyPolicy = privacyPolicyFromJson(jsonString);

import 'dart:convert';

PrivacyPolicy privacyPolicyFromJson(String str) =>
    PrivacyPolicy.fromJson(json.decode(str));

String privacyPolicyToJson(PrivacyPolicy data) => json.encode(data.toJson());

class PrivacyPolicy {
  bool success;
  List<Setting> settings;

  PrivacyPolicy({
    required this.success,
    required this.settings,
  });

  factory PrivacyPolicy.fromJson(Map<String, dynamic> json) => PrivacyPolicy(
        success: json["success"],
        settings: List<Setting>.from(
            json["settings"].map((x) => Setting.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "settings": List<dynamic>.from(settings.map((x) => x.toJson())),
      };
}

class Setting {
  String key;
  String type;
  String? value;
  List<String>? listvalue;

  Setting({
    required this.key,
    required this.type,
    this.listvalue,
    this.value,
  });

  factory Setting.fromJson(Map<String, dynamic> json) {
    dynamic data = json['value'];

    if (data is List<dynamic>) {
      List<String> stringList = List<String>.from(data);
      return Setting(
        listvalue: stringList,
        key: json["key"],
        type: json["type"],
      );
    } else if (data is String) {
      return Setting(
        value: data,
        key: json["key"],
        type: json["type"],
      );
    }
    return Setting(
      key: json["key"],
      type: json["type"],
      value: json["value"],
    );
  }

  Map<String, dynamic> toJson() => {
        "key": key,
        "type": type,
      };
}
