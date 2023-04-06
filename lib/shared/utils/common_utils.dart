import 'package:flutter/material.dart';
import 'package:fox/shared/ui/page_not_found/page_not_found.dart';
import 'package:fox/shared/utils/extensions/extensions.dart';

class CommonUtils {
  CommonUtils._();

  /// Method used to precache the list of asset image into engine
  static void preCacheNetworkImages(
      BuildContext context, List<String> urlList) {
    for (var url in urlList) {
      url.preCacheLocalImages(context);
    }
  }

  static bool hasInvalidArgs<T>(Object args) {
    return (args is! T);
  }

  static Widget misTypedArgsRoute<T>(Object args) {
    return const PageNotFound();
  }
}
