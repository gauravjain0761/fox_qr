import 'package:flutter/material.dart';
import 'package:fox/routes/routes.dart';
import 'package:fox/shared/shared.dart';
import 'package:fox/themes/app_text.dart';

class PastQrScreen extends StatefulWidget {
  const PastQrScreen({super.key});

  @override
  State<PastQrScreen> createState() => _PastQrScreenState();
}

class _PastQrScreenState extends State<PastQrScreen> {
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
            child: ListView.separated(
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
