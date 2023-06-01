part of 'themes.dart';

final _timePickerTheme = TimePickerThemeData(
  backgroundColor: AppColors.greyColor,
  hourMinuteShape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    side: BorderSide(color: AppColors.yellowcolor, width: 4),
  ),
  dayPeriodBorderSide: BorderSide(color: AppColors.yellowcolor, width: 4),
  dayPeriodColor: Colors.blueGrey.shade600,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    side: BorderSide(color: AppColors.yellowcolor, width: 4),
  ),
  dayPeriodTextColor: AppColors.black,
  dayPeriodShape: RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
    side: BorderSide(color: AppColors.yellowcolor, width: 4),
  ),
  hourMinuteColor: MaterialStateColor.resolveWith((states) =>
      states.contains(MaterialState.selected)
          ? AppColors.yellowcolor
          : Colors.blueGrey.shade800),
  hourMinuteTextColor: MaterialStateColor.resolveWith((states) =>
      states.contains(MaterialState.selected)
          ? Colors.black
          : AppColors.yellowcolor),
  dialHandColor: Colors.blueGrey.shade700,
  dialBackgroundColor: Colors.blueGrey.shade800,
  hourMinuteTextStyle:
      GoogleFonts.montserrat(fontSize: 20.sp, fontWeight: FontWeight.bold),
  dayPeriodTextStyle:
      GoogleFonts.montserrat(fontSize: 12.sp, fontWeight: FontWeight.bold),
  helpTextStyle: GoogleFonts.montserrat(
      fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.white),
  inputDecorationTheme: const InputDecorationTheme(
    border: InputBorder.none,
    contentPadding: EdgeInsets.all(0),
  ),
  dialTextColor: MaterialStateColor.resolveWith((states) =>
      states.contains(MaterialState.selected)
          ? AppColors.yellowcolor
          : Colors.white),
  entryModeIconColor: AppColors.yellowcolor,
);

class _DarkTheme {
  static ThemeData darkThemeData = ThemeData(
    timePickerTheme: _timePickerTheme,
    brightness: Brightness.dark,
  ).copyWith(
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
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
    scaffoldBackgroundColor: AppColors.scaffoldColor,
    focusColor: AppColors.greyColor.withOpacity(0.12),
    hoverColor: AppColors.inputDefault,
    disabledColor: AppColors.inputDisable,
    primaryColorLight: AppColors.inputDefault,
    platform: TargetPlatform.iOS,
    toggleButtonsTheme: ToggleButtonsThemeData(
      textStyle: AppText.text14w400,
    ),
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: MaterialStateProperty.all(AppColors.appColor),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return AppColors.appColor;
        }
        return null;
      }),
      trackColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return AppColors.appColor;
        }
        return null;
      }),
    ),
    radioTheme: RadioThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return AppColors.appColor;
        }
        return null;
      }),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return null;
        }
        if (states.contains(MaterialState.selected)) {
          return AppColors.appColor;
        }
        return null;
      }),
    ),

  );
}
