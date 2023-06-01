import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fox/features/past_qr/logic/past_qr_controller.dart';
import 'package:fox/routes/routes.dart';
import 'package:fox/shared/shared.dart';
import 'package:fox/themes/app_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

String storageImageUrl = "https://qrfoxprod.s3.af-south-1.amazonaws.com/";

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
    if (istokenavailable == "" && isskipped) {
      setState(() {
        shownodataText = false;
      });
    } else {
      setState(() {
        shownodataText = true;
      });
      Provider.of<PastQrController>(context, listen: false)
          .getpastqrs(context: context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<PastQrController>(context, listen: true);
    return Scaffold(
      appBar: const AppHeader(
        leftWidget: AppBackButton(),
        isDrawerNeeded: false,
        title: 'Past Codes',
      ),
      backgroundColor: AppColors.appColor,
      resizeToAvoidBottomInset: false,
      body: Consumer<PastQrController>(
        builder: (context, value, child) {
          if (value.isloading == true) {
            Loader.show(context,
                progressIndicator: CircularProgressIndicator(
                  color: AppColors.appColor,
                ));
          } else if (value.isloading != true && value.pastqrs != null) {
            Loader.hide();
            return SafeArea(
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
                      : controller.pastqrs!.qrs.data.isNotEmpty
                          ? ListView.separated(
                              padding: EdgeInsets.symmetric(horizontal: 15.w),
                              itemCount: controller.pastqrs!.qrs.data.length,
                              separatorBuilder: (_, __) =>
                                  sizedBoxWithHeight(20),
                              itemBuilder: (_, index) => _renderListItem(
                                  controller: controller, index: index),
                            )
                          : Center(
                              child: Text(
                              "No past QR codes available",
                              style: GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold),
                            )),
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _renderListItem(
      {required PastQrController controller, required int index}) {
    return GestureDetector(
      onTap: () => AppEnvironment.navigator.pushNamed(
        GeneralRoutes.displayQRDetailsScreen,
        arguments: controller.pastqrs!.qrs.data.elementAt(index).id,
      ),
      child: Container(
        height: 90.h,
        padding: EdgeInsets.symmetric(
          horizontal: 15.w,
          vertical: 16.h,
        ),
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
              storageImageUrl +
                  controller.pastqrs!.qrs.data.elementAt(index).qrImage,
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
                    controller.pastqrs!.qrs.data.elementAt(index).qrText,
                    style: AppText.text14w600.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                  sizedBoxWithHeight(4),
                  Text(
                    '${controller.pastqrs!.qrs.data.elementAt(index).qrName} QR',
                    style: AppText.text12w400.copyWith(
                      color: AppColors.black,
                    ),
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
