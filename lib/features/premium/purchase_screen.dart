import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:fox/features/premium/premium_path_clipper.dart';
import 'package:fox/models/plan_model.dart';
import 'package:fox/routes/routes.dart';
import 'package:fox/shared/shared.dart';
import 'package:fox/themes/app_text.dart';
import 'package:google_fonts/google_fonts.dart';

class PurchaseScreen extends StatefulWidget {
  const PurchaseScreen({super.key});

  @override
  State<PurchaseScreen> createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  late PageController controller;
  @override
  void initState() {
    super.initState();
    controller = PageController();
  }

  List<PlanModel> planmodel = [
    PlanModel(
        codes: "Unlimited",
        name: "Free",
        price: "0,00",
        features: Strings.whatUget),
    PlanModel(
        codes: "150 Codes",
        name: "Premium Plus",
        price: "15,00",
        features: [
          "Halftone And Full Colour Image",
          "Tracking and Dashboard Access",
          "12 Month Expiry",
          "Multiple Content",
          "No Ads",
        ]),
    PlanModel(
        codes: "500 Codes",
        name: "Premium Pro",
        price: "30,00",
        features: [
          "Halftone And Full Colour Image",
          "Tracking and Dashboard Access",
          "12 Month Expiry",
          "Multiple Content",
          "No Ads",
        ]),
    PlanModel(
        codes: "3000 Codes",
        name: "Premium Ultra",
        price: "100,00",
        features: [
          "Halftone And Full Colour Image",
          "Tracking and Dashboard Access",
          "12 Month Expiry",
          "Multiple Content",
          "No Ads",
        ]),
  ];
  late int selectedindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white.withOpacity(0.8),
      bottomNavigationBar: _renderCta(),
      body: BackdropFilter(
        filter: ui.ImageFilter.blur(
          sigmaX: 20,
          sigmaY: 20,
        ),
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.h),
            shrinkWrap: true,
            primary: false,
            children: [
              Center(
                child: Text(
                  'Join Premium And \nGet More!',
                  textAlign: TextAlign.center,
                  style: AppText.text24w700,
                ),
              ),
              sizedBoxWithHeight(36),
              SizedBox(
                height: 250.h,
                width: double.maxFinite,
                child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: planmodel.length,
                    controller: controller,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              text: 'With ',
                              style: GoogleFonts.montserrat(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.black,
                              ),
                              children: [
                                TextSpan(
                                  text: planmodel.elementAt(selectedindex).name,
                                  style: GoogleFonts.montserrat(
                                    color: AppColors.pinkColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12.sp,
                                  ),
                                ),
                                TextSpan(
                                  text: ' You Get :',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          sizedBoxWithHeight(24),
                          _renderFeatureList(),
                        ],
                      );
                    }),
              ),
              sizedBoxWithHeight(40),
              _renderPlanList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderFeatureList() {
    return ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: Strings.whatUget.length,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (_, __) => sizedBoxWithHeight(24),
      itemBuilder: (_, index) => _renderFeature(index),
    );
  }

  Widget _renderFeature(int index) {
    return Row(
      children: [
        const AppImage(
          "assets/images/done.svg",
        ),
        sizedBoxWithWidth(20),
        Text(
          planmodel.elementAt(selectedindex).features.elementAt(index),
          style: GoogleFonts.montserrat(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
      ],
    );
  }

  Widget _renderPlanList() {
    return ListView.separated(
      itemCount: planmodel.length,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (_, __) => sizedBoxWithHeight(10),
      itemBuilder: (_, index) => _renderPlan(index),
    );
  }

  Widget _renderPlan(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedindex = index;
          controller.animateToPage(selectedindex,
              duration: Duration(seconds: 1), curve: Curves.easeIn);
        });
      },
      child: Container(
        decoration: BoxDecoration(
            color: index == selectedindex
                ? AppColors.blueTickColor
                : Colors.transparent,
            borderRadius: BorderRadius.circular(
              12.r,
            )),
        padding: const EdgeInsets.all(4),
        child: Container(
          height: 80.h,
          decoration: BoxDecoration(
            color: AppColors.pinkColor,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                blurRadius: 25.r,
                offset: Offset(0, 3.h),
                color: AppColors.shadowColor,
              )
            ],
          ),
          child: Stack(
            children: [
              ClipPath(
                // TODO: pass length of string added by value and prefix
                clipper: PremiumPathClipper(
                    length: planmodel.elementAt(index).price.length + 4),
                child: Container(
                  width: MediaQuery.of(AppEnvironment.ctx).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(
                          12.r,
                        ),
                        bottomLeft: Radius.circular(
                          12.r,
                        )),
                    color: AppColors.white.withOpacity(0.45),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: Row(
                  children: [
                    Text.rich(
                      TextSpan(
                        text: '\$${planmodel.elementAt(index).price}',
                        children: [
                          TextSpan(
                              text: ' /yr', style: AppText.text12w400White),
                        ],
                      ),
                      style: AppText.text24w600White,
                    ),
                    const Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(planmodel.elementAt(index).name,
                            style: AppText.text16w700White),
                        Text(
                          planmodel.elementAt(index).codes,
                          style: AppText.text16w400White,
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

  Widget _renderCta() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.h),
      child: SizedBox(
        height: 60.h,
        child: AppButton(
          border: Border.all(color: AppColors.black, width: 2.r),
          primaryColor: AppColors.white,
          highLightedTextColor: AppColors.black,
          textStyle: AppText.text20w600Black,
          onClick: _handleContinueForFree,
          label: 'Continue For Free',
        ),
      ),
    );
  }

  void _handleContinueForFree() {
    AppEnvironment.navigator.pushNamedAndRemoveUntil(
      GeneralRoutes.homePageScreen,
      (route) => false,
    );
  }
}
