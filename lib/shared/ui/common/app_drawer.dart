import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:fox/routes/arguments/content_args.dart';
import 'package:fox/features/premium/purchase_screen.dart';
import 'package:fox/routes/routes.dart';
import 'package:fox/shared/shared.dart';
import 'package:fox/themes/app_text.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 280.w,
      backgroundColor: AppColors.white.withOpacity(0.89),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(
            sigmaX: 5,
            sigmaY: 5,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                sizedBoxWithHeight(24),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: AppEnvironment.navigator.pop,
                    child: Icon(
                      Icons.close,
                      color: AppColors.black,
                      size: 32.r,
                    ),
                  ),
                ),
                AppImage(
                  Images.foxWithTextLogo,
                  width: 120.r,
                ),
                sizedBoxWithHeight(24),
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: drawerItems.length,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (_, __) => sizedBoxWithHeight(40),
                  itemBuilder: (_, index) => _renderListItem(index),
                ),
                const Spacer(),
                AppButton(
                  onClick: () {},
                  label: 'Log Out',
                  primaryColor: AppColors.pinkColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderListItem(int index) {
    return GestureDetector(
      onTap: () => _handleDrawerItemTap(drawerItems[index].type),
      child: Row(
        children: [
          AppImage(
            drawerItems[index].icon,
            width: 24.w,
            height: 20.h,
          ),
          sizedBoxWithWidth(20),
          Text(
            drawerItems[index].text,
            style: AppText.text18w600.copyWith(color: AppColors.black),
          )
        ],
      ),
    );
  }

  void _handleDrawerItemTap(DrawerItemType type) {
    switch (type) {
      case DrawerItemType.PLANS_AND_PRICES:
        AppEnvironment.navigator.push(
          PageRouteBuilder(
            opaque: false,
            pageBuilder: (_, __, ___) => const PurchaseScreen(),
          ),
        );
        break;

      case DrawerItemType.PAST_QR_CODES:
        AppEnvironment.navigator.pushNamed(GeneralRoutes.pastQrScreen);
        break;

      case DrawerItemType.TERMS_OF_USE:
        AppEnvironment.navigator.pushNamed(
          GeneralRoutes.contentScreen,
          arguments: ContentArgs(
              title: 'Terms of Use',
              onTap: () {
                AppEnvironment.navigator.pop();
              },
              contentUrl: ''),
        );
        break;

      case DrawerItemType.PRIVACY_POLICY:
        AppEnvironment.navigator.pushNamed(
          GeneralRoutes.contentScreen,
          arguments: ContentArgs(
              title: 'Privacy Policy',
              onTap: () {
                AppEnvironment.navigator.pop();
              },
              contentUrl: ''),
        );
        break;

      default:
    }
  }
}
