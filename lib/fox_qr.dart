import 'package:fox/features/auth/logic/auth_controller.dart';
import 'package:fox/shared/shared.dart';
import 'package:fox/routes/routes.dart';
import 'package:fox/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

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
        ChangeNotifierProvider(create: (_) => getIt<AuthController>()),
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
            localizationsDelegates: const [FormBuilderLocalizations.delegate],
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
    getIt.registerSingleton(AuthController());
  }
}
