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
  // final Pay _payClient = Pay({
  //   PayProvider.google_pay: PaymentConfiguration.fromJsonString(
  //     '{"provider": "google_pay","data": { "environment": "TEST","apiVersion": 2,"apiVersionMinor": 0,"allowedPaymentMethods": [{"type": "CARD","tokenizationSpecification": { "type": "PAYMENT_GATEWAY"},"parameters": {"allowedCardNetworks": [    "VISA","MASTERCARD"],"allowedAuthMethods": ["PAN_ONLY","CRYPTOGRAM_3DS" ],"billingAddressRequired": true,"billingAddressParameters": {"format": "FULL","phoneNumberRequired": true}} }  ], "merchantInfo": {"merchantId": "1234567889987654","merchantName": "Test Business"},"transactionInfo": {"countryCode": "IN","currencyCode": "INR"}}}',
  //   ),
  // });
  // void onGooglePayPressed() async {
  //   await _payClient.showPaymentSelector(
  //     PayProvider.google_pay,
  //     [
  //       const PaymentItem(amount: "10"),
  //     ],
  //   ).onError((error, stackTrace) {
  //     print(error.toString());
  //     return {};
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: _handleOnTap,

          // Google Pay Integration
          // child: RawGooglePayButton(
          //   onPressed: onGooglePayPressed,
          //   type: GooglePayButtonType.pay,
          // )

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
