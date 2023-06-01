import 'package:flutter/material.dart';
import 'package:fox/routes/routes.dart';
import 'package:fox/shared/shared.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StarterScreen extends StatefulWidget {
  const StarterScreen({super.key});

  @override
  State<StarterScreen> createState() => _StarterScreenState();
}

class _StarterScreenState extends State<StarterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: _handleOnTap,
          // child: const RiveAnimation.asset(
          //   'assets/images/qrfox_Info_Screen.riv',
          //   fit: BoxFit.fill,
          // ),
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
                    AppImage(
                      Images.foxLogo,
                      width: 70.r,
                      height: 70.r,
                    ),
                    sizedBoxWithHeight(10),
                    Column(
                      children: [
                        Container(
                          height: 250.h,
                          width: 250.w,
                          padding: EdgeInsets.all(
                            95.r,
                          ),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                'assets/images/full_color_graphic.png',
                              ),
                            ),
                          ),
                          child: Transform.translate(
                            offset: Offset(-90, -95),
                            child: AppImage(
                              "assets/images/cake.svg",
                              height: 20.h,
                              width: 70.w,
                            ),
                          ),
                        ),
                        Stack(
                          children: [
                            Transform.translate(
                              offset: Offset(0, 140),
                              child: Container(
                                height: 189.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/generateqr.png"),
                                  ),
                                ),
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(90, -25),
                              child: Container(
                                height: 210.h,
                                width: 210.w,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                      'assets/images/half_graphic.png',
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Transform.translate(
                              offset: const Offset(
                                200,
                                -65,
                              ),
                              child: const AppImage(
                                "assets/images/viewhere.svg",
                              ),
                            ),
                            Transform.translate(
                              offset: const Offset(83, 100),
                              child: AppImage(
                                "assets/images/locationstarter.svg",
                                height: 70.h,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 160.h,
                            bottom: 30.h,
                          ),
                          child: Text(
                            'Tap To Continue',
                            style: GoogleFonts.montserrat(
                              fontSize: 12.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String istokenavailable = prefs.getString(Strings.usertoken) ?? "";
    final bool isskipped = prefs.getBool(Strings.isskipped) ?? false;
    if (istokenavailable == "" && !isskipped) {
      AppEnvironment.navigator.pushReplacementNamed(AuthRoutes.loginScreen);
    } else {
      AppEnvironment.navigator.pushReplacementNamed(
        GeneralRoutes.homePageScreen,
      );
    }
  }

  void _handleOnTap() {
    //  AppEnvironment.navigator.pushNamed(AuthRoutes.loginScreen);

    isLoggedIn();
  }
}
