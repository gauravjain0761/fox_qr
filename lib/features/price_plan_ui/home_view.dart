import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fox/features/price_plan_ui/logic/plans_controller.dart';
import 'package:fox/routes/routes.dart';
import 'package:fox/shared/shared.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';

import 'plans.dart';
import 'plan_details.dart';

import 'continue_button.dart';
import 'animated_pages.dart';

class PurchaseNew extends StatefulWidget {
  const PurchaseNew({Key? key}) : super(key: key);

  @override
  _PurchaseNewState createState() => _PurchaseNewState();
}

class _PurchaseNewState extends State<PurchaseNew> {
  late PageController _pageController;
  int currentIndex = 0;
  double pageValue = 0.0;
  Offerings? _offerings;
  PlansController plansController = PlansController();

  Future<void> fetchData() async {
    Offerings? offerings;
    try {
      offerings = await Purchases.getOfferings();
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _offerings = offerings;
    });
  }

  @override
  void initState() {
    super.initState();
    plansController = Provider.of<PlansController>(context, listen: false);
    plansController.getuserplans(context: context);
    fetchData();

    _pageController = PageController(
      initialPage: currentIndex,
      viewportFraction: 0.8,
    )..addListener(() {
        setState(() {
          pageValue = _pageController.page!;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<PlansController>(context, listen: true);
    if (_offerings != null) {
      final offering = _offerings!.current;
      if (offering != null) {}
    }
    // final reversedMovieList = movies.reversed.toList();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
      ),
      child: Consumer<PlansController>(
        builder: (context, value, child) {
          if (value.plans != null) {
            Loader.hide();
            return Scaffold(
              appBar: AppHeader(
                height: 70.h,
                drawercolor:
                    value.plans!.plans.elementAt(currentIndex).id == 2 ||
                            value.plans!.plans.elementAt(currentIndex).id == 3
                        ? Colors.white
                        : null,
                leftWidget: AppImage(
                  Images.foxLogo,
                  color: value.plans!.plans.elementAt(currentIndex).id == 2 ||
                          value.plans!.plans.elementAt(currentIndex).id == 3
                      ? Colors.white
                      : null,
                  height: 50.r,
                  width: 50.r,
                ),
                onDrawerTap: () async {},
              ),
              backgroundColor: getbackroundcolor(),
              body: Stack(
                children: <Widget>[
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: ShapeOfView(
                        shape: ArcShape(
                            direction: ArcDirection.Outside,
                            height: 20,
                            position: ArcPosition.Top),
                        child: Container(
                          height: 350.0,
                          padding: EdgeInsets.only(
                            bottom: 170.h,
                          ),
                          color: getbackroundcolorwithopacity(),
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              "Swipe Through Plans",
                              style: GoogleFonts.montserrat(
                                color: value.plans!.plans
                                                .elementAt(currentIndex)
                                                .id ==
                                            2 ||
                                        value.plans!.plans
                                                .elementAt(currentIndex)
                                                .id ==
                                            3
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      )),
                  AnimatedPages(
                    pageValue: pageValue,
                    pageController: _pageController,
                    pageCount: value.plans!.plans.length,
                    onPageChangeCallback: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    child: (index, _) => PlanDetails(
                      value.plans!.plans[index],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Subscription Includes:",
                          style: GoogleFonts.montserrat(
                              color: value.plans!.plans
                                              .elementAt(currentIndex)
                                              .id ==
                                          2 ||
                                      value.plans!.plans
                                              .elementAt(currentIndex)
                                              .id ==
                                          3
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400),
                        ),
                        sizedBoxWithHeight(8),
                        Text(
                          value.plans!.plans
                              .elementAt(currentIndex)
                              .numberOfCodesText,
                          style: GoogleFonts.montserrat(
                              color: value.plans!.plans
                                              .elementAt(currentIndex)
                                              .id ==
                                          2 ||
                                      value.plans!.plans
                                              .elementAt(currentIndex)
                                              .id ==
                                          3
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        sizedBoxWithHeight(28),
                        SizedBox(
                          height: 200.h,
                          child: ListView.separated(
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(
                              horizontal: 50.w,
                            ),
                            itemCount: value.plans!.plans
                                .elementAt(currentIndex)
                                .descriptions
                                .length,
                            separatorBuilder: (_, __) => sizedBoxWithHeight(12),
                            itemBuilder: (context, index) {
                              return Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    AppImage(
                                      "assets/images/done.svg",
                                      height: 10.h,
                                      width: 10.w,
                                      color: value.plans!.plans
                                                      .elementAt(currentIndex)
                                                      .id ==
                                                  2 ||
                                              value.plans!.plans
                                                      .elementAt(currentIndex)
                                                      .id ==
                                                  3
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    sizedBoxWithWidth(10),
                                    Flexible(
                                      child: Text(
                                        value.plans!.plans
                                            .elementAt(currentIndex)
                                            .descriptions
                                            .elementAt(index),
                                        maxLines: 2,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600,
                                          color: value.plans!.plans
                                                          .elementAt(
                                                              currentIndex)
                                                          .id ==
                                                      2 ||
                                                  value.plans!.plans
                                                          .elementAt(
                                                              currentIndex)
                                                          .id ==
                                                      3
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  Positioned(
                      bottom: 32.0,
                      left: 0.0,
                      right: 0.0,
                      child: pricingtext()),
                ],
              ),
            );
          } else if (value.plans == null) {
            Loader.show(context,
                progressIndicator: CircularProgressIndicator(
                  color: AppColors.appColor,
                ));
          }
          return const SizedBox();
        },
      ),
    );
  }

  Color getbackroundcolorwithopacity() {
    if (currentIndex == 0) {
      return const Color(0xffe4e4e5);
    } else if (currentIndex == 1) {
      return const Color(0xfffe5acb);
    } else if (currentIndex == 2) {
      return const Color(0xff8ADEF6);
    } else if (currentIndex == 3) {
      return const Color(0xffe5e400);
    }
    return const Color(0xffe4e4e5);
  }

  Color getbackroundcolor() {
    if (currentIndex == 0) {
      return const Color(0xffFFFFFF);
    } else if (currentIndex == 1) {
      return const Color(0xffFF14B5);
    } else if (currentIndex == 2) {
      return const Color(0xff26A2C6);
    } else if (currentIndex == 3) {
      return const Color(0xfffefe00);
    }
    return const Color(0xffFFFFFF);
  }

  Widget pricingtext() {
    if (currentIndex == 0) {
      return InkWell(
        onTap: () {
          AppEnvironment.navigator
              .pushReplacementNamed(GeneralRoutes.homePageScreen);
        },
        child: ContinueButton(
          buttontext:
              plansController.plans!.plans.elementAt(currentIndex).ctaText,
        ),
      );
    } else if (currentIndex == 1 || currentIndex == 2) {
      return Column(
        children: [
          ListView.separated(
              separatorBuilder: (context, index) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 15.h,
                    ),
                    child: Text(
                      "OR",
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                );
              },
              shrinkWrap: true,
              itemCount: plansController.plans!.plans
                  .elementAt(currentIndex)
                  .pricings!
                  .length,
              primary: false,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                    context.showSnackBar("Purchase");
                    if (currentIndex == 1) {
                      try {
                        await Purchases.purchasePackage(
                            _offerings!.current!.monthly!);
                      } on PlatformException catch (e) {
                        context.showSnackBar(e.message!);
                      } on Exception catch (e) {
                        context.showSnackBar(e.toString());
                      }
                    } else if (currentIndex == 2) {
                      try {
                        await Purchases.purchasePackage(
                          _offerings!.current!.annual!,
                        );
                      } on PlatformException catch (e) {
                        context.showSnackBar(e.message!);
                      } on Exception catch (e) {
                        context.showSnackBar(
                          e.toString(),
                        );
                      }
                    }
                  },
                  child: MultiPriceContainer(
                    duration: "  /  ${duration(
                      duration: plansController.plans!.plans
                          .elementAt(
                            currentIndex,
                          )
                          .pricings!
                          .elementAt(
                            index,
                          )
                          .durationInMonths,
                    )}",
                    price: '\$${plansController.plans!.plans.elementAt(
                          currentIndex,
                        ).pricings!.elementAt(
                          index,
                        ).price}',
                  ),
                );
              }),
          sizedBoxWithHeight(15),
          Text(
            "(\$${plansController.plans!.plans.elementAt(
                  currentIndex,
                ).effectiveMonthlyPrice})",
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      );
    } else {
      return ContinueButton(
        buttontext:
            plansController.plans!.plans.elementAt(currentIndex).ctaText,
      );
    }
  }
}

String duration({required int duration}) {
  if (duration == 1) {
    return " Month";
  } else if (duration == 12) {
    return "Year";
  } else {
    return "$duration Months ";
  }
}

class MultiPriceContainer extends StatelessWidget {
  final String price;
  final String duration;
  const MultiPriceContainer({
    super.key,
    required this.duration,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 40.w),
      padding: EdgeInsets.symmetric(vertical: 18.h),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(
          30.0,
        ),
      ),
      alignment: Alignment.center,
      child: Text.rich(
        TextSpan(
          text: price,
          children: [
            TextSpan(
                text: duration,
                style: GoogleFonts.montserrat(
                    color: AppColors.white,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400)),
          ],
        ),
        style: GoogleFonts.montserrat(
          color: Colors.white,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
