import 'package:fox/features/price_plan_ui/logic/purchaseflutterapi.dart';
import 'package:fox/fox_qr.dart';
import 'package:fox/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:fox/shared/shared.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('mipmap/ic_launcher');

  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings();

  const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  await Purchases.setLogLevel(
    LogLevel.debug,
  );
  PurchaseFlutterAPI.init().then((value) {
    PurchaseFlutterAPI.fetchOffers();
  });
//    flutterLocalNotifications
// Plugin.initialize(
//   initializationSettings,
//   onDidReceiveNotificationResponse: (String payload) async {
//     if (payload != null) {
//       // Open the image in the gallery
//       await OpenFile.open(payload);
//     }
//   },
// );

  InternetConnectionChecker().onStatusChange.listen((status) {
    switch (status) {
      case InternetConnectionStatus.connected:
        if (ModalRoute.of(AppEnvironment.ctx)?.settings.name ==
            GeneralRoutes.noInternet) {
          AppEnvironment.navigator.pop();
        }
        Logger.logMsg('MAIN', 'Data connection is available.');
        break;
      case InternetConnectionStatus.disconnected:
        // AppEnvironment.navigator.pushNamed(GeneralRoutes.noInternet);
        break;
    }
  });

  runApp(const FoxQrApp());
}
