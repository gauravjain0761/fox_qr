import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fox/features/drawer/logic/drawercontroller.dart';
import 'package:fox/routes/routes.dart';
import 'package:fox/shared/shared.dart';
import 'package:fox/themes/app_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
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
        height: 70.h,
        title: "Privacy Policy",
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
              sizedBoxWithHeight(50),
              Text(
                "Privacy Policy",
                style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600),
              ),
              sizedBoxWithHeight(25),
              Consumer<DrawerProvider>(
                builder: (context, value, child) {
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
                                  .elementAt(1)
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
                              .elementAt(1)
                              .listvalue!
                              .length,
                        ),
                        sizedBoxWithHeight(20),
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
                      ],
                    );
                  }
                  return const SizedBox();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
