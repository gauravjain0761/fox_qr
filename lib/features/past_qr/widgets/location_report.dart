import 'package:flutter/material.dart';
import 'package:fox/shared/shared.dart';
import 'package:fox/themes/app_text.dart';

class LocationReports extends StatelessWidget {
  const LocationReports({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          // decoration: BoxDecoration(
          //   border: Border(
          //     bottom: BorderSide(
          //       color: AppColors.greyTextColor,
          //       width: 1.w,
          //     ),
          //   ),
          // ),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
              child: Text(
                'Total Scans',
                style: AppText.text12w400.copyWith(
                  color: AppColors.black.withOpacity(0.7),
                ),
              ),
            ),
            sizedBoxWithWidth(30),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
              child: Text(
                'Locations',
                style: AppText.text12w400.copyWith(
                  color: AppColors.black.withOpacity(0.7),
                ),
              ),
            ),
          ],
        ),
        Divider(
          thickness: 1.5,
          color: AppColors.dividerColor,
        ),
        _renderRow('21', 'Johannesburg, ZA'),
        _renderRow('26', 'Johannesburg, ZA'),
        sizedBoxWithHeight(44),
      ],
    );
  }

  Row _renderRow(String key, String value) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
          child: Text(
            key,
            style: AppText.text14w600.copyWith(color: AppColors.black),
          ),
        ),
        sizedBoxWithWidth(70),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
          child: Text(
            value,
            style: AppText.text14w600.copyWith(color: AppColors.black),
          ),
        ),
      ],
    );
  }
}
