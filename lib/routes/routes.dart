import 'package:flutter/foundation.dart';
import 'package:fox/features/auth/auth.dart';
import 'package:fox/features/home_page/widgets/create_qr_page.dart';
import 'package:fox/features/past_qr/display_qr.dart';
import 'package:fox/features/past_qr/past_qr.dart';
import 'package:fox/features/splash/index.dart';
import 'package:fox/features/starter_screen/ui/starter_screen.dart';
import 'package:fox/routes/arguments/index.dart';
import 'package:fox/shared/shared.dart';

import 'package:flutter/material.dart';
import 'package:fox/features/home_page/home_page.dart';
import 'package:fox/features/premium/purchase_screen.dart';
import 'package:fox/shared/ui/content_display/content_display.dart';

part 'auth_routes.dart';
part 'create_post_routes.dart';
part 'general_routes.dart';
part 'post_routes.dart';
part 'profile_routes.dart';

///
/// Routes are divided into multiple parts based on modules
/// [AuthRoutes] contains auth module routes
///

class Routes {
  static String currentRoute = '/';
  static const splash = '/';

  static final routes = <String>{
    splash,
    ...AuthRoutes.authRoutes,
    ...GeneralRoutes.generalRoutes,
    ...CreatePostRoutes.createPostRoutes,
    ...PostRoutes.postRoutes,
    ...ProfileRoutes.profileRoutes,
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;

    currentRoute = settings.name ?? '/';
    Widget child;
    if (currentRoute.startsWith(AuthRoutes.authLeading)) {
      child = AuthRoutes.getPage(currentRoute, args);
    } else if (currentRoute.startsWith(GeneralRoutes.generalLeading)) {
      child = GeneralRoutes.getPage(currentRoute, args);
    } else if (currentRoute.startsWith(CreatePostRoutes.createPostLeading)) {
      child = CreatePostRoutes.getPage(currentRoute, args);
    } else if (currentRoute.startsWith(PostRoutes.postLeading)) {
      child = PostRoutes.getPage(currentRoute, args);
    } else if (currentRoute.startsWith(ProfileRoutes.profileLeading)) {
      child = ProfileRoutes.getPage(currentRoute, args);
    } else if (currentRoute == Routes.splash) {
      child = const SplashScreen();
    } else {
      child = const PageNotFound();
    }

    return MaterialPageRoute(
      builder: (_) => child,
      settings: settings,
    );
  }
}
