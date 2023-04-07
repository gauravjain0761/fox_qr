import 'package:fox/fox_qr.dart';
import 'package:fox/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:fox/shared/shared.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
