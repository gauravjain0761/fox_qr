import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fox/features/drawer/logic/drawercontroller.dart';
import 'package:fox/shared/shared.dart';
import 'package:fox/themes/app_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:layout_grids/layout_grids.dart';
import 'package:provider/provider.dart';

import '../../routes/routes.dart';
// grids: [
//   FlexColumnGrid(
//     count: 4,
//     gutter: 8,
//     margin: 32.w,
//     color: Colors.green.withOpacity(0.2),
//   ),
// ],

class TermsConditions extends StatefulWidget {
  const TermsConditions({super.key});

  @override
  State<TermsConditions> createState() => _TermsConditionsState();
}

class _TermsConditionsState extends State<TermsConditions> {
  DrawerProvider controller = DrawerProvider();
  @override
  void initState() {
    controller = Provider.of<DrawerProvider>(
      context,
      listen: false,
    );
    controller.getprivacypolicy(context: context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppHeader(
        fontsize: 10.sp,
        height: 70.h,
        title: "Terms Of Use",
        onDrawerTap: () async {
          // final SharedPreferences prefs = await SharedPreferences.getInstance();
          // prefs.setBool(Strings.isskipped, true).then((value) {
          //   AppEnvironment.navigator.pushNamed(GeneralRoutes.homePageScreen);
          // });
        },
        leftWidget: InkWell(
          onTap: () {
            AppEnvironment.navigator.pop();
          },
          child: AppImage(
            Images.arrowBackBlackFilled,
            height: 35.r,
            width: 35.r,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 36.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizedBoxWithHeight(80),
              Text(
                "Terms & Conditions",
                style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600),
              ),
              sizedBoxWithHeight(25),
              Consumer<DrawerProvider>(builder: (context, value, child) {
                if (value.privacypolicy == null) {
                  Loader.show(context,
                      progressIndicator: CircularProgressIndicator(
                        color: AppColors.appColor,
                      ));
                } else if (value.privacypolicy != null) {
                  Loader.hide();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemBuilder: (context, index) {
                          return Text(
                            value.privacypolicy!.settings
                                .elementAt(2)
                                .listvalue!
                                .elementAt(index),
                            style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          );
                        },
                        itemCount: value.privacypolicy!.settings
                            .elementAt(2)
                            .listvalue!
                            .length,
                      ),
                      sizedBoxWithHeight(60),
                      InkWell(
                        onTap: () {
                          AppEnvironment.navigator.pushReplacementNamed(
                              GeneralRoutes.homePageScreen);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                                vertical: 18.h,
                              ) +
                              EdgeInsets.only(
                                left: 80.w,
                                right: 20.w,
                              ),
                          decoration: BoxDecoration(
                              color: AppColors.black,
                              borderRadius: BorderRadius.circular(
                                30.r,
                              )),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "       Done ",
                                style: AppText.text20w600White,
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: AppColors.white,
                              )
                            ],
                          ),
                        ),
                      ),
                      sizedBoxWithHeight(40)
                    ],
                  );
                }
                return const SizedBox();
              }),
            ],
          ),
        ),
      ),
    );
  }
}
