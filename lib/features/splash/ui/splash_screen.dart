import 'package:flutter/material.dart';
import 'package:fox/routes/routes.dart';
import 'package:fox/shared/shared.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil()..init(context);
    return Scaffold(
      body: GestureDetector(
        onTap: _handleOnTap,
        child: Stack(
          children: [
            const AppImage(Images.backgroundPinkSplash),
            const Align(
              alignment: Alignment.bottomLeft,
              child: AppImage(Images.backgroundYellowSplash),
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  const Spacer(),
                  AppImage(
                    Images.foxLogo,
                    width: 150.r,
                    height: 150.r,
                  ),
                  sizedBoxWithHeight(26),
                  Text.rich(
                    TextSpan(
                      text: 'QR',
                      style: GoogleFonts.montserrat(
                        color: AppColors.pinkColor,
                        fontSize: 48.sp,
                        fontWeight: FontWeight.w700,
                      ),
                      children: [
                        TextSpan(
                          text: ' FOX',
                          style: GoogleFonts.montserrat(
                            color: AppColors.black,
                            fontSize: 48.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'WELCOME',
                    style: GoogleFonts.montserrat(
                      fontSize: 35.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  sizedBoxWithHeight(26),
                  Text(
                    'Tap To Continue',
                    style: GoogleFonts.montserrat(
                      fontSize: 12.sp,
                      color: AppColors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  sizedBoxWithHeight(54),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleOnTap() {
    AppEnvironment.navigator.pushNamed(GeneralRoutes.starterScreen);
  }
}
