import 'package:flutter/material.dart';
import 'package:fox/routes/routes.dart';
import 'package:fox/shared/shared.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil()..init(context);
    return Scaffold(
      body: GestureDetector(
        onTap: _handleOnTap,
        // child: const RiveAnimation.asset(
        //   'assets/images/qrfox_Landing_Screen.riv',
        //   fit: BoxFit.fill,
        // ),
        child: Stack(
          children: [
            const AppImage(
              Images.backgroundPinkSplash,
            ),
            const Align(
              alignment: Alignment.bottomLeft,
              child: AppImage(
                Images.backgroundYellowSplash,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  const Spacer(),
                  AppImage(
                    "assets/images/splashlogo.svg",
                    width: 150.r,
                    height: 150.r,
                  ),
                  sizedBoxWithHeight(26),
                  Text.rich(
                    TextSpan(
                      text: 'QR',
                      style: GoogleFonts.montserrat(
                        color: AppColors.pinkColor,
                        fontSize: 55.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: ' FOX',
                          style: GoogleFonts.montserrat(
                            color: AppColors.black,
                            fontSize: 53.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  const Spacer(),
                  AppImage(
                    "assets/images/welcome.svg",
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
    AppEnvironment.navigator.pushReplacementNamed(
      GeneralRoutes.starterScreen,
    );
  }
}
