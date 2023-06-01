import 'package:flutter/material.dart';
import 'package:fox/shared/shared.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppText {
  AppText._();

  static TextStyle get text12w400 => GoogleFonts.montserrat(
        color: AppColors.black,
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
      );
  static TextStyle get text12w600 => GoogleFonts.montserrat(
        color: AppColors.black,
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get text12w400Grey => GoogleFonts.montserrat(
        color: AppColors.greyColor,
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get text14w400 => GoogleFonts.montserrat(
        color: AppColors.black,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get text14w700appColor => GoogleFonts.montserrat(
        color: AppColors.appColor,
        fontSize: 14.sp,
        fontWeight: FontWeight.w700,
      );

  static TextStyle get text14w400Black => GoogleFonts.montserrat(
        color: AppColors.black,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      );
  static TextStyle get text14w500 => GoogleFonts.montserrat(
        color: AppColors.white,
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get text14w600 => GoogleFonts.montserrat(
        color: AppColors.white,
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get text14w600OffWhite => GoogleFonts.montserrat(
        color: AppColors.white.withOpacity(0.5),
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get text24w400 => GoogleFonts.montserrat(
        color: AppColors.white,
        fontSize: 24.sp,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get text18w600 => GoogleFonts.montserrat(
        color: AppColors.white,
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get text24w600 => GoogleFonts.montserrat(
        color: AppColors.black,
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get text16w600 => GoogleFonts.montserrat(
        color: AppColors.white,
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get text16w500 => GoogleFonts.montserrat(
        color: AppColors.black,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      );
  static TextStyle get text16w400 => GoogleFonts.montserrat(
        color: AppColors.black,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get text16w600OffWhite => GoogleFonts.montserrat(
        color: AppColors.white.withOpacity(0.5),
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get text20w600White => GoogleFonts.montserrat(
        color: AppColors.white,
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get text20w600Black => GoogleFonts.montserrat(
        color: AppColors.black,
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get text32w600 => GoogleFonts.montserrat(
        color: AppColors.black,
        fontSize: 32.sp,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get text38w600 => GoogleFonts.montserrat(
        color: AppColors.black,
        fontSize: 38.sp,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get text24w700 => GoogleFonts.montserrat(
        color: AppColors.black,
        fontSize: 25.sp,
        fontWeight: FontWeight.w700,
      );
  static TextStyle get text24w600White => GoogleFonts.montserrat(
        color: AppColors.white,
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get text12w400White => GoogleFonts.montserrat(
        color: AppColors.white,
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
      );
  static TextStyle get text16w700White => GoogleFonts.montserrat(
        color: AppColors.white,
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
      );
  static TextStyle get text16w400White => GoogleFonts.montserrat(
        color: AppColors.white,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      );
  static TextStyle get text60w600 => GoogleFonts.montserrat(
        color: AppColors.black,
        fontSize: 60.sp,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get text15w500black => GoogleFonts.montserrat(
        color: AppColors.black,
        fontSize: 15.sp,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get text8w400 => GoogleFonts.montserrat(
        color: AppColors.black,
        fontSize: 8.sp,
        fontWeight: FontWeight.w500,
      );
  static TextStyle get text15w400 => GoogleFonts.montserrat(
        color: AppColors.textcolor,
        fontWeight: FontWeight.w400,
        fontSize: 15.sp,
      );
  static TextStyle get text17w600 => GoogleFonts.montserrat(
        color: AppColors.grey500,
        fontSize: 17.sp,
        fontWeight: FontWeight.w600,
      );
  static TextStyle get text10w400 => GoogleFonts.montserrat(
        color: AppColors.black,
        fontSize: 10.sp,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get text13w600 => GoogleFonts.montserrat(
        color: AppColors.bluecolor,
        fontSize: 13.sp,
        fontWeight: FontWeight.normal,
      );
}
