import 'package:flutter/material.dart';
import 'package:fox/features/home_page/logic/home_controller.dart';
import 'package:fox/models/create_qr.dart';
import 'package:fox/routes/routes.dart';
import 'package:fox/shared/shared.dart';
import 'package:fox/themes/app_text.dart';
import 'package:provider/provider.dart';

downloadqr(
    {required BuildContext context,
    required CreateQr createQr,
    required GlobalKey<FormState> formkey}) {
  var homecontroller = Provider.of<HomeController>(context, listen: false);
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 32.w,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                sizedBoxWithHeight(40),
                Text(
                  "Your QR Code",
                  style: AppText.text24w700,
                ),
                sizedBoxWithHeight(0),
                Image.memory(
                  homecontroller.byteimage!,
                  // bytesImage,
                  height: 400.h,
                  width: 500.w,
                ),
                sizedBoxWithHeight(15),
                Text(
                  "Expires on 28/02/24",
                  style: AppText.text17w600.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                sizedBoxWithHeight(20),
                InkWell(
                  onTap: () {
                    homecontroller.saveimage(
                        context: context,
                        image: homecontroller.fileimage!.path,
                        formkey: formkey);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 16.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.black,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Download",
                          style: AppText.text15w500black.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        AppImage(
                          "assets/images/download.png",
                          height: 15.h,
                          width: 15.w,
                          color: AppColors.white,
                        )
                      ],
                    ),
                  ),
                ),
                sizedBoxWithHeight(40)
              ],
            ),
          ),
        );
      });

  // showDialog(
  //     barrierDismissible: true,
  //     barrierLabel: '',
  //     barrierColor: Colors.white.withOpacity(0.9),
  //     builder: (context) {
  //       return WillPopScope(
  //         onWillPop: () async {
  //           homecontroller.reset(formkey: formkey);

  //           AppEnvironment.navigator.pushNamed(GeneralRoutes.homePageScreen);

  //           return false;
  //         },
  //         child: AlertDialog(
  //           backgroundColor: Colors.transparent,
  //           content: Column(
  //             children: [
  //               sizedBoxWithHeight(40),
  //               Text(
  //                 "Your QR Code",
  //                 style: AppText.text24w700,
  //               ),
  //               sizedBoxWithHeight(100),
  //               Image.memory(
  //                 homecontroller.byteimage!,
  //                 // bytesImage,
  //                 height: 200.h,
  //                 width: 200.w,
  //               ),
  //               sizedBoxWithHeight(60),
  //               Text(
  //                 "Expires on 28/02/24",
  //                 style: AppText.text17w600.copyWith(
  //                   fontWeight: FontWeight.w900,
  //                 ),
  //               ),
  //               const Spacer(),
  //               InkWell(
  //                 onTap: () async {
  //                   homecontroller.saveimage(
  //                       context: context,
  //                       image: homecontroller.fileimage!.path,
  //                       formkey: formkey);
  //                 },
  //                 child: Container(
  //                   padding: EdgeInsets.symmetric(
  //                     vertical: 16.h,
  //                   ),
  //                   decoration: BoxDecoration(
  //                     color: AppColors.black,
  //                     borderRadius: BorderRadius.circular(20.r),
  //                   ),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Text(
  //                         "Download",
  //                         style: AppText.text15w500black.copyWith(
  //                           color: AppColors.white,
  //                         ),
  //                       ),
  //                       sizedBoxWithWidth(
  //                         20,
  //                       ),
  //                       AppImage(
  //                         "assets/images/download.png",
  //                         height: 15.h,
  //                         width: 15.w,
  //                         color: AppColors.white,
  //                       )
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               sizedBoxWithHeight(40)
  //             ],
  //           ),
  //           elevation: 0,
  //         ),
  //       );
  //     },
  //     context: context);
}
