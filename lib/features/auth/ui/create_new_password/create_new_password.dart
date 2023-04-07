import 'package:flutter/material.dart';
import 'package:fox/shared/shared.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(
        leftWidget: AppImage(
          Images.arrowBackBlackFilled,
          height: 50.r,
          width: 50.r,
        ),
      ),
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: GestureDetector(
          onTap: FocusScope.of(context).unfocus,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.h),
            child: Column(
              children: [
                const Spacer(),
                _renderForm(),
                const Spacer(),
                AppButton(onClick: () {}, label: 'Save'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderForm() {
    return Column(
      children: [
        Text(
          'Create New Password',
          style: TextStyle(
            fontSize: 25.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.black,
          ),
        ),
        sizedBoxWithHeight(40),
        Text(
          'Create a new password\nfor your account',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.black,
          ),
        ),
        sizedBoxWithHeight(40),
        const AppTextFormField(
          name: 'password',
          hintText: "Create A Password",
          // hintStyle: AppText.text15w400.copyWith(
          //   color: AppColors.black,
          // ),
        ),
        sizedBoxWithHeight(20),
        const AppTextFormField(
          name: 'confirm_password',
          hintText: "Re-Enter Password",
          // hintStyle: AppText.text15w400.copyWith(
          //   color: AppColors.black,
          // ),
        ),
      ],
    );
  }
}
