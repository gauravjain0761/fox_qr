// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:fox/shared/shared.dart';

// class Plans {
//   final String title;
//   final String subtitle;
//   final int index;
//   final Color color;
//   final Color border;
//   final Color backgroundColor;
//   final String subscriptiontitle;
//   final List<String> description;

//   Plans({
//     required this.title,
//     required this.index,
//     required this.subscriptiontitle,
//     required this.description,
//     required this.color,
//     required this.border,
//     required this.subtitle,
//     required this.backgroundColor,
//   });
// }

// List<Map<String, dynamic>> rawData = [
//   {
//     'title': '',
//     'subtitle': 'Free',
//     'index': 1,
//     'color': Color(0xffFFFFFF),
//     'border': Colors.black,
//     'backgroundcolor': Color(0xffe4e5e4),
//     "subscriptiontitle": "Unlimited Static Codes",
//     "description": Strings.whatUget
//   },
//   {
//     'title': 'Premium',
//     'subtitle': 'Starter',
//     'index': 2,
//     'color': Color(0xffFF14B5),
//     'border': Colors.white,
//     "subscriptiontitle": "20 Dynamic Codes",
//     'backgroundcolor': Color(0xfffe5acb),
//     "description": [
//       "Halftone And Full Colour Image",
//       "Tracking and Dashboard Access",
//       "12 Month Expiry",
//       "Multiple Content",
//       "No Ads",
//     ]
//   },
//   {
//     'title': 'Premium',
//     'subtitle': 'Pro',
//     'index': 3,
//     'color': Color(0xff26A2C6),
//     'border': Colors.white,
//     'backgroundcolor': Color(0xff8ADEF6),
//     "description": [
//       "Halftone And Full Colour Image",
//       "Tracking and Dashboard Access",
//       "12 Month Expiry",
//       "Multiple Content",
//       "No Ads",
//     ],
//     "subscriptiontitle": "100 Dynamic Codes",
//   },
//   {
//     'title': 'Premium',
//     'subtitle': 'Enterprice',
//     'index': 4,
//     'color': Color(0xff0ffff00),
//     "subscriptiontitle": "Unlimited Dynamic Codes",
//     "description": [
//       "Halftone And Full Colour Image",
//       "Tracking and Dashboard Access",
//       "12 Month Expiry",
//       "Multiple Content",
//       "No Ads",
//     ],
//     'border': Colors.black,
//     'backgroundcolor': Color(0xffe4e500)
//   },
// ];

// To parse this JSON data, do
//
//     final plans = plansFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

Plans plansFromJson(String str) => Plans.fromJson(json.decode(str));

String plansToJson(Plans data) => json.encode(data.toJson());

class Plans {
  bool success;
  List<Plan> plans;

  Plans({
    required this.success,
    required this.plans,
  });

  factory Plans.fromJson(Map<String, dynamic> json) => Plans(
        success: json["success"],
        plans: List<Plan>.from(json["plans"].map((x) => Plan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "plans": List<dynamic>.from(plans.map((x) => x.toJson())),
      };
}

class Plan {
  int id;
  String name;
  String tagline;
  int isFree;
  String? priceTagPrefix;
  String? priceTagSurfix;
  int isCustom;
  List<String> descriptions;
  String numberOfCodesTagPrefix;
  int? numberOfCodes;
  String numberOfCodesText;
  String ctaText;
  int sortingOrder;
  dynamic deletedAt;
  Color buttoncolor;
  DateTime createdAt;
  DateTime updatedAt;
  String? effectiveMonthlyPrice;
  List<Pricing>? pricings;

  Plan({
    required this.id,
    required this.name,
    required this.tagline,
    required this.isFree,
    required this.buttoncolor,
    this.priceTagPrefix,
    this.priceTagSurfix,
    required this.isCustom,
    required this.descriptions,
    required this.numberOfCodesTagPrefix,
    this.numberOfCodes,
    required this.numberOfCodesText,
    required this.ctaText,
    required this.sortingOrder,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    this.effectiveMonthlyPrice,
    this.pricings,
  });

  factory Plan.fromJson(Map<String, dynamic> json) {
    // Define a map of ID-color mappings
    // Define a map of ID-color mappings
    int id = json['id'];

    Map<dynamic, Color> idColorMap = {
      1: Colors.blue,
      id: Colors.red,
      3: Colors.green,
      id: Colors.black
      // Add more ID-color mappings as needed
    };

    return Plan(
      id: json["id"],
      name: json["name"],
      tagline: json["tagline"],
      isFree: json["is_free"],
      priceTagPrefix: json["price_tag_prefix"],
      priceTagSurfix: json["price_tag_surfix"],
      buttoncolor: idColorMap["id"] ?? Colors.yellow,
      isCustom: json["is_custom"],
      descriptions: List<String>.from(json["descriptions"].map((x) => x)),
      numberOfCodesTagPrefix: json["number_of_codes_tag_prefix"],
      numberOfCodes: json["number_of_codes"],
      numberOfCodesText: json["number_of_codes_text"],
      ctaText: json["cta_text"],
      sortingOrder: json["sorting_order"],
      deletedAt: json["deleted_at"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      effectiveMonthlyPrice: json["effectiveMonthlyPrice"],
      pricings: json["pricings"] == null
          ? []
          : List<Pricing>.from(
              json["pricings"]!.map((x) => Pricing.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "tagline": tagline,
        "is_free": isFree,
        "price_tag_prefix": priceTagPrefix,
        "price_tag_surfix": priceTagSurfix,
        "is_custom": isCustom,
        "descriptions": List<dynamic>.from(descriptions.map((x) => x)),
        "number_of_codes_tag_prefix": numberOfCodesTagPrefix,
        "number_of_codes": numberOfCodes,
        "number_of_codes_text": numberOfCodesText,
        "cta_text": ctaText,
        "sorting_order": sortingOrder,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "effectiveMonthlyPrice": effectiveMonthlyPrice,
        "pricings": pricings == null
            ? []
            : List<dynamic>.from(pricings!.map((x) => x.toJson())),
      };

  Color getbackroundcolor() {
    if (id == 0) {
      return const Color(0xffFFFFFF);
    } else if (id == 1) {
      return const Color(0xffFF14B5);
    } else if (id == 2) {
      return const Color(0xff26A2C6);
    } else if (id == 3) {
      return const Color(0xff0ffff00);
    }
    return const Color(0xffFFFFFF);
  }
}

class Pricing {
  int discountEnabled;
  dynamic discountStartDate;
  dynamic discountEndDate;
  dynamic discountedPrice;
  int durationInMonths;
  double price;
  String platform;
  String paymentGateway;
  dynamic gatewayPaymentLink;
  int sortingOrder;

  Pricing({
    required this.discountEnabled,
    this.discountStartDate,
    this.discountEndDate,
    this.discountedPrice,
    required this.durationInMonths,
    required this.price,
    required this.platform,
    required this.paymentGateway,
    this.gatewayPaymentLink,
    required this.sortingOrder,
  });

  factory Pricing.fromJson(Map<String, dynamic> json) => Pricing(
        discountEnabled: json["discount_enabled"],
        discountStartDate: json["discount_start_date"],
        discountEndDate: json["discount_end_date"],
        discountedPrice: json["discounted_price"],
        durationInMonths: json["duration_in_months"],
        price: json["price"]?.toDouble(),
        platform: json["platform"],
        paymentGateway: json["payment_gateway"],
        gatewayPaymentLink: json["gateway_payment_link"],
        sortingOrder: json["sorting_order"],
      );

  Map<String, dynamic> toJson() => {
        "discount_enabled": discountEnabled,
        "discount_start_date": discountStartDate,
        "discount_end_date": discountEndDate,
        "discounted_price": discountedPrice,
        "duration_in_months": durationInMonths,
        "price": price,
        "platform": platform,
        "payment_gateway": paymentGateway,
        "gateway_payment_link": gatewayPaymentLink,
        "sorting_order": sortingOrder,
      };
}
