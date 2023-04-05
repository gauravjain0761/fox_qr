import 'package:flutter/material.dart';
import 'package:fox/features/past_qr/index.dart';
import 'package:fox/shared/shared.dart';
import 'package:fox/themes/app_text.dart';

class DisplayQRDetailsScreen extends StatefulWidget {
  const DisplayQRDetailsScreen({super.key});

  @override
  State<DisplayQRDetailsScreen> createState() => _DisplayQRDetailsScreenState();
}

class _DisplayQRDetailsScreenState extends State<DisplayQRDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: false,
      appBar: const AppHeader(leftWidget: AppBackButton()),
      body: SafeArea(
        child: GestureDetector(
          onTap: FocusScope.of(context).unfocus,
          child: ListView(
            padding: EdgeInsets.only(top: 24.h),
            children: [
              sizedBoxWithHeight(32),
              Center(
                child: Card(
                  color: AppColors.white,
                  child: AppImage(
                    Images.foxLogo,
                    height: 150.r,
                    width: 150.r,
                  ),
                ),
              ),
              sizedBoxWithHeight(30),
              Text(
                'Created: 02 Feb 23  —  Expires: 02 Feb ‘24',
                style: AppText.text12w600,
                textAlign: TextAlign.center,
              ),
              sizedBoxWithHeight(8),
              Text(
                'Mandela Campaign QRs',
                style: AppText.text24w700,
                textAlign: TextAlign.center,
              ),
              sizedBoxWithHeight(8),
              Text(
                'Website QRs',
                style: AppText.text16w400,
                textAlign: TextAlign.center,
              ),
              sizedBoxWithHeight(24),
              AppButton(
                onClick: () {},
                label: 'Download QR',
                width: 180,
                highLightedTextColor: AppColors.white,
                primaryColor: AppColors.pinkColor,
              ),
              sizedBoxWithHeight(24),
              const QrReports(),
            ],
          ),
        ),
      ),
    );
  }
}
