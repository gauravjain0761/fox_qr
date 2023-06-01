import 'package:flutter/material.dart';
import 'package:fox/shared/shared.dart';
import 'package:fox/themes/app_text.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final Widget? child;
  final double height;
  final Widget? leftWidget;
  final VoidCallback? onDrawerTap;
  final Color? color;
  final Color? drawercolor;
  final bool isDrawerNeeded;
  final String? title;
  final double? fontsize;

  const AppHeader({
    super.key,
    this.color,
    this.drawercolor,
    this.child,
    this.height = kToolbarHeight,
    this.onDrawerTap,
    this.title,
    this.fontsize,
    this.leftWidget,
    this.isDrawerNeeded = true,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return child ?? _renderHeader();
  }

  Widget _renderHeader() {
    return Container(
      color: color ?? Colors.transparent,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 32.w, right: 32.w, top: 24.h),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: leftWidget ??
                    AppImage(
                      Images.foxLogo,
                      height: 50.r,
                      width: 50.r,
                    ),
              ),
              if (title != null) ...{
                Align(
                  child: Text(
                    title!,
                    style: AppText.text14w400.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                        fontSize: fontsize),
                  ),
                ),
              },
              if (isDrawerNeeded) ...{
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: onDrawerTap,
                    child: AppImage(
                      Images.drawerIcon,
                      color: drawercolor,
                      width: 16.r,
                      height: 16.r,
                    ),
                  ),
                )
              },
            ],
          ),
        ),
      ),
    );
  }
}
