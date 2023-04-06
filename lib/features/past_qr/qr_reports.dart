import 'package:flutter/material.dart';
import 'package:fox/features/past_qr/index.dart';
import 'package:fox/shared/shared.dart';
import 'package:fox/themes/app_text.dart';

class QrReports extends StatefulWidget {
  const QrReports({super.key});

  @override
  State<QrReports> createState() => _QrReportsState();
}

class _QrReportsState extends State<QrReports> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.appColor,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        children: [
          sizedBoxWithHeight(32),
          _renderContainer(
            title: 'This Week’s Activity',
            child: QrWeeklyActivity(),
          ),
          sizedBoxWithHeight(20),
          _renderContainer(title: 'Locations', child: const LocationReports()),
          sizedBoxWithHeight(20),
          _renderContainer(title: 'Device Type', child: DeviceTypeReports()),
          sizedBoxWithHeight(24),
        ],
      ),
    );
  }

  Widget _renderContainer({required Widget child, required String title}) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sizedBoxWithHeight(20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              title,
              style: AppText.text16w600.copyWith(color: AppColors.pinkColor),
            ),
          ),
          sizedBoxWithHeight(10),
          Divider(
            color: AppColors.dividerColor,
            endIndent: 10.w,
            indent: 10.w,
          ),
          sizedBoxWithHeight(10),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
