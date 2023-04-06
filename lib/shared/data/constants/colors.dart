import 'package:flutter/material.dart';

///
class AppColors {
  AppColors._();

  static Color get appColor => const Color(0xffDBF5FC);
  static Color get pinkColor => const Color(0xffff13b5);
  static Color get pinkLightColor => const Color(0xFFFE89DB);

  static Color get yellowColor => const Color(0xffFFFE70);
  static Color get shadowColor => const Color(0x1D00000D);
  static Color get blueTickColor => const Color(0xff8ADEF6);

  static Color get white => const Color(0xffffffff);
  static Color get errorColor => const Color(0xffe86a7f);
  static Color get black => const Color(0xff000000);
  static Color get dividerColor => const Color(0x3B3B3B21);

  static Color get greyColor => const Color(0xff00001F);
  static Color get navBarColor => const Color(0xff060606);
  static Color get greyTextColor => const Color(0xffBABDBF);
  static Color get inputDefault => const Color(0xFFFAF9FB);
  static Color get inputDisable => const Color(0xfff6f7fb);

  static Color get buttonColor => const Color(0xff000000);
  static Color get buttonDisabledColor => const Color(0xff4E5311);
  static Color get buttonSplashColor => buttonColor.withOpacity(0.2);
  static Color get goldColor => const Color(0xffd4af37);
  static Color get successColor => const Color(0xff00ab41);
  static Color get scaffoldColor => const Color(0xffDBF5FC);
  static Color get textcolor => const Color(0xff9babb0);
  static Color get bordercolor => const Color(0xffe5e5e5);
  static Color get grey500 => const Color(0xff7e7e7f);
  static Color get unselectedtext => const Color(0xff789ea8);

  static Color get yellowcolor => const Color(0xffFFFF70);
  static LinearGradient get postDetailGradient1 => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [scaffoldColor.withOpacity(0.7), Colors.transparent],
      );
  static LinearGradient get postDetailGradient2 => LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.transparent,
          scaffoldColor.withOpacity(0.7),
        ],
      );
}
