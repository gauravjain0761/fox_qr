import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseFlutterAPI {
  static final _APIKey = "goog_KraVGsgCVrTKarFkAERQdhGrfdG";

// initialize function to be called to initialize our purchase_Flutter plugin
  static Future init() async {
    await Purchases.setLogLevel(LogLevel.debug);
    PurchasesConfiguration(_APIKey);
    Purchases.configure(PurchasesConfiguration(_APIKey));
  }

// gets a list of offerings from RevenueCat and stores it in a list for use in our app
  static Future<List<Offering>> fetchOffers() async {
    try {
      final offerings = await Purchases.getOfferings();
      final activeOffering = offerings.current;
      final offers = offerings.all;
      offers.map((key, value) {
        print("Identifi ${value.identifier}");
        return MapEntry(key, value);
      });

      return (activeOffering == null) ? [] : [activeOffering];
    } on PlatformException catch (e) {
      return [];
    }
  }
}
