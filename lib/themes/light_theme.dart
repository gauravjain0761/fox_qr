part of 'themes.dart';

class _LightTheme {
  static ThemeData lightThemeData = ThemeData(
    brightness: Brightness.light,
  ).copyWith(
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS:
            CupertinoPageTransitionsBuilderCustomBackGestureWidth(),
      },
    ),
    textTheme: GoogleFonts.montserratTextTheme(),
    colorScheme: const ColorScheme.light().copyWith(
      primary: AppColors.appColor,
      secondary: AppColors.appColor,
    ),
    primaryTextTheme: GoogleFonts.montserratTextTheme(),
    toggleableActiveColor: AppColors.appColor,
    appBarTheme: AppBarTheme(color: AppColors.white),
    scaffoldBackgroundColor: AppColors.appColor,
    errorColor: AppColors.errorColor,
    focusColor: AppColors.greyColor.withOpacity(0.12),
    hoverColor: AppColors.inputDefault,
    disabledColor: AppColors.inputDisable,
    primaryColorLight: AppColors.inputDefault,
    backgroundColor: AppColors.white,
    toggleButtonsTheme: ToggleButtonsThemeData(
      textStyle: AppText.text14w400,
    ),
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: MaterialStateProperty.all(AppColors.appColor),
    ),
  );
}
