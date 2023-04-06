import 'package:cupertino_back_gesture/cupertino_back_gesture.dart';
import 'package:fox/shared/data/constants/colors.dart';
import 'package:fox/shared/utils/app_environment.dart';
import 'package:fox/themes/app_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

part 'dark_theme.dart';
part 'light_theme.dart';

ThemeData get themeData => AppEnvironment.isDark
    ? _DarkTheme.darkThemeData
    // ? _LightTheme.lightThemeData
    : _DarkTheme.darkThemeData;
