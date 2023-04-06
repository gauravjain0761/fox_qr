import 'package:flutter/material.dart';
import 'package:fox/routes/routes.dart';
import 'package:fox/shared/shared.dart';
import 'package:google_fonts/google_fonts.dart';

class StarterScreen extends StatelessWidget {
  const StarterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _handleOnTap,
        child: Stack(
          children: [
            const Align(
              alignment: Alignment.topRight,
              child: AppImage(Images.backgroundPinkStarterScreen),
            ),
            Positioned(
              bottom: 56.h,
              left: 0.w,
              child: const AppImage(Images.backgroundYellowStarterScreen),
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  sizedBoxWithHeight(48),
                  AppImage(Images.foxLogo, width: 50.r, height: 50.r),
                  sizedBoxWithHeight(86),
                  AppImage(
                    Images.manScanThisImage,
                    height: 400.h,
                    width: 200.w,
                  ),
                  sizedBoxWithHeight(68),
                  Text(
                    'GENERATE',
                    style: GoogleFonts.montserrat(
                      fontSize: 45.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'QR CODES',
                    style: GoogleFonts.montserrat(
                      fontSize: 35.sp,
                      color: AppColors.pinkColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  sizedBoxWithHeight(23),
                  Text(
                    'Tap To Continue',
                    style: GoogleFonts.montserrat(
                      fontSize: 12.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleOnTap() {
    AppEnvironment.navigator.pushNamed(AuthRoutes.loginScreen);
  }
}
