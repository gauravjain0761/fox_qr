import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fox/features/past_qr/index.dart';
import 'package:fox/features/past_qr/logic/past_qr_controller.dart';
import 'package:fox/shared/shared.dart';
import 'package:fox/themes/app_text.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DisplayQRDetailsScreen extends StatefulWidget {
  final String qrid;
  const DisplayQRDetailsScreen({
    super.key,
    required this.qrid,
  });

  @override
  State<DisplayQRDetailsScreen> createState() => _DisplayQRDetailsScreenState();
}

class _DisplayQRDetailsScreenState extends State<DisplayQRDetailsScreen> {
  @override
  void initState() {
    Provider.of<PastQrController>(context, listen: false)
        .getqrDetail(context: context, qrid: widget.qrid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<PastQrController>(
      context,
      listen: true,
    );
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: false,
      appBar: const AppHeader(
        leftWidget: AppBackButton(),
        isDrawerNeeded: false,
      ),
      body: Consumer<PastQrController>(
        builder: (context, value, child) {
          if (value.qrdetail == null) {
            Loader.show(context,
                progressIndicator: CircularProgressIndicator(
                  color: AppColors.appColor,
                ));
          } else if (value.qrdetail != null) {
            Loader.hide();
            return SafeArea(
              child: GestureDetector(
                onTap: FocusScope.of(context).unfocus,
                child: ListView(
                  padding: EdgeInsets.only(top: 24.h),
                  children: [
                    sizedBoxWithHeight(32),
                    Center(
                      child: Container(
                        decoration:
                            BoxDecoration(color: AppColors.white, boxShadow: [
                          BoxShadow(
                            color: AppColors.dropshadow,
                            spreadRadius: 2,
                            blurRadius: 10,
                          )
                        ]),
                        child: AppImage(
                          storageImageUrl + controller.qrdetail!.qr.qrImage,
                          height: 150.r,
                          width: 150.r,
                        ),
                      ),
                    ),
                    sizedBoxWithHeight(30),
                    Text(
                      'Created: ${DateFormat(
                        "dd MMM yy",
                      ).format(
                        controller.qrdetail!.qr.createdAt,
                      )}  —  Expires: ${DateFormat(
                        "dd MMM yy",
                      ).format(
                        controller.qrdetail!.qr.expiry,
                      )} ',
                      style: AppText.text12w600,
                      textAlign: TextAlign.center,
                    ),
                    sizedBoxWithHeight(8),
                    Text(
                      controller.qrdetail!.qr.qrText,
                      style: AppText.text24w700,
                      textAlign: TextAlign.center,
                    ),
                    sizedBoxWithHeight(8),
                    Text(
                      '${controller.qrdetail!.qr.qrType.name} QR',
                      style: AppText.text16w400,
                      textAlign: TextAlign.center,
                    ),
                    sizedBoxWithHeight(24),
                    AppButton(
                      onClick: () {
                        controller.saveimage(
                          context: context,
                          image:
                              storageImageUrl + controller.qrdetail!.qr.qrImage,
                        );
                      },
                      label: 'Download QR',
                      width: 180,
                      textStyle: AppText.text17w600.copyWith(
                        color: AppColors.white,
                      ),
                      highLightedTextColor: AppColors.white,
                      primaryColor: AppColors.pinkColor,
                    ),
                    sizedBoxWithHeight(24),
                    QrReports(
                      controller: controller,
                    ),
                  ],
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
