import 'package:fox/features/auth/logic/auth_controller.dart';
import 'package:fox/features/auth/logic/login_controller.dart';
import 'package:fox/features/auth/logic/register_controller.dart';
import 'package:fox/features/auth/logic/reset_password_controller.dart';
import 'package:fox/features/drawer/logic/drawercontroller.dart';
import 'package:fox/features/home_page/logic/home_controller.dart';
import 'package:fox/features/past_qr/logic/past_qr_controller.dart';
import 'package:fox/features/price_plan_ui/logic/plans_controller.dart';

import 'package:fox/shared/shared.dart';
import 'package:fox/routes/routes.dart';
import 'package:fox/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

import 'features/auth/auth.dart';

class FoxQrApp extends StatefulWidget {
  const FoxQrApp({super.key});

  @override
  State<FoxQrApp> createState() => _FoxQrAppState();
}

class _FoxQrAppState extends State<FoxQrApp> {
  final getIt = GetIt.I;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => getIt<AuthController>(),
        ),
        ChangeNotifierProvider(
          create: (_) => getIt<LoginController>(),
        ),
        ChangeNotifierProvider(
          create: (_) => getIt<HomeController>(),
        ),
        ChangeNotifierProvider(
          create: (_) => getIt<PlansController>(),
        ),
        ChangeNotifierProvider(
          create: (_) => getIt<DrawerProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => getIt<ResetPasswordController>(),
        ),
        ChangeNotifierProvider(
          create: (_) => getIt<PastQrController>(),
        ),

        ChangeNotifierProvider(
          create: (_) => getIt<RegisterController>(),
        ),
        // ChangeNotifierProvider(create: (_) => GetIt.I<CreateQrController>()),
      ],
      child: ValueListenableBuilder(
        valueListenable: AppEnvironment.appTheme,
        builder: (_, __, ___) {
          return MaterialApp(
            theme: themeData,
            color: AppColors.appColor,
            debugShowCheckedModeBanner: false,
            onGenerateRoute: Routes.onGenerateRoute,
            navigatorKey: AppEnvironment.rootNavigationKey,
            navigatorObservers: [
              AppEnvironment.routeObserver,
            ],
            initialRoute: Routes.splash,
          );
        },
      ),
    );
  }

  void _preCacheImages() {
    // CommonUtils.preCacheNetworkImages(context, [Images.foxLogo]);
  }

  void _initialize() {
    _registerRepos();
    _registerNotifiers();
    _preCacheImages();
  }

  void _registerRepos() {}

  void _registerNotifiers() {
    getIt.registerSingleton(
      LoginController(),
    );
    getIt.registerSingleton(
      RegisterController(),
    );
    getIt.registerSingleton(
      ResetPasswordController(),
    );
    getIt.registerSingleton(
      PastQrController(),
    );

    getIt.registerSingleton(
      HomeController(),
    );
    getIt.registerSingleton(
      PlansController(),
    );
    getIt.registerSingleton(
      DrawerProvider(),
    );

    getIt.registerSingleton(
      AuthController(),
    );
    // getIt.registerSingleton(CreateQrController());
  }
}
