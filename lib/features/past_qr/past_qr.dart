import 'package:flutter/material.dart';
import 'package:fox/routes/routes.dart';
import 'package:fox/shared/shared.dart';
import 'package:fox/themes/app_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PastQrScreen extends StatefulWidget {
  const PastQrScreen({super.key});

  @override
  State<PastQrScreen> createState() => _PastQrScreenState();
}

class _PastQrScreenState extends State<PastQrScreen> {
  @override
  void initState() {
    isLoggedIn();
    super.initState();
  }

  bool shownodataText = false;
  Future isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String istokenavailable = prefs.getString(Strings.usertoken) ?? "";
    final bool isskipped = prefs.getBool(Strings.isskipped) ?? false;
    if (istokenavailable == "" && !isskipped) {
      setState(() {
        shownodataText = true;
      });
    } else {
      setState(() {
        shownodataText = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(
        leftWidget: AppBackButton(),
        isDrawerNeeded: false,
        title: 'Past Codes',
      ),
      backgroundColor: AppColors.appColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: GestureDetector(
          onTap: FocusScope.of(context).unfocus,
          child: Padding(
            padding: EdgeInsets.only(top: 32.h),
            child: shownodataText == false
                ? Center(
                    child: Text(
                    "No past QR codes available",
                    style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold),
                  ))
                : ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 15.w),
                    itemCount: 3,
                    separatorBuilder: (_, __) => sizedBoxWithHeight(20),
                    itemBuilder: (_, index) => _renderListItem(),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _renderListItem() {
    return GestureDetector(
      onTap: () => AppEnvironment.navigator
          .pushNamed(GeneralRoutes.displayQRDetailsScreen),
      child: Container(
        height: 90.h,
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              blurRadius: 25.r,
              offset: Offset(0, 3.h),
              color: AppColors.shadowColor,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppImage(
              Images.foxLogo,
              height: 60.r,
              width: 60.r,
            ),
            sizedBoxWithWidth(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Mandela Campaign QR',
                    style: AppText.text14w600.copyWith(color: AppColors.black),
                  ),
                  sizedBoxWithHeight(4),
                  Text(
                    'Website QR',
                    style: AppText.text12w400.copyWith(color: AppColors.black),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 20.r,
              color: AppColors.black,
            )
          ],
        ),
      ),
    );
  }
}
