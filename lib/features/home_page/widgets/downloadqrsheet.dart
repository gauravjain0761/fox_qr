import 'package:flutter/material.dart';
import 'package:fox/features/home_page/logic/home_controller.dart';
import 'package:fox/models/create_qr.dart';
import 'package:fox/shared/shared.dart';
import 'package:fox/themes/app_text.dart';
import 'package:provider/provider.dart';

downloadqr({required BuildContext context, required CreateQr createQr}) {
  var homecontroller = Provider.of<HomeController>(context, listen: false);

  showDialog(
      barrierDismissible: true,
      barrierLabel: '',
      barrierColor: Colors.white.withOpacity(0.9),
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Column(
            children: [
              sizedBoxWithHeight(40),
              Text(
                "Your QR Code",
                style: AppText.text24w700,
              ),
              sizedBoxWithHeight(100),
              Image.memory(
                homecontroller.byteimage!,
                // bytesImage,
                height: 200.h,
                width: 200.w,
              ),
              sizedBoxWithHeight(60),
              Text(
                "Expires on 28/02/24",
                style: AppText.text17w600.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Spacer(),
              InkWell(
                onTap: () async {
                  homecontroller.saveimage(
                    context: context,
                    image: homecontroller.fileimage!.path,
                  );
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
                      sizedBoxWithWidth(
                        20,
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
          elevation: 0,
        );
      },
      context: context);
}