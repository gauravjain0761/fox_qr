import 'package:flutter/material.dart';
import 'package:fox/shared/shared.dart';

import '../../../../themes/app_text.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool tncchecked = false;
  bool ppchecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(),
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: GestureDetector(
          onTap: FocusScope.of(context).unfocus,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.h),
            child: Column(
              children: [
                sizedBoxWithHeight(22),
                _renderForm(),
                const Spacer(),
                sizedBoxWithHeight(40),
                // TODO: add app check

                AppButton(
                  onClick: () {},
                  label: 'Create Account',
                  iconAlign: Alignment.centerRight,
                  icon: AppImage(
                    Images.arrowBackWhite,
                    height: 16.h,
                    width: 32.w,
                  ),
                ),
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
          'Sign Up',
          style: TextStyle(
            fontSize: 25.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.black,
          ),
        ),
        sizedBoxWithHeight(41),
        const AppTextFormField(
          name: 'email',
          hintText: "email@address.foxtrot",
        ),
        sizedBoxWithHeight(20),
        const AppTextFormField(
          name: 'password',
          hintText: "Create A Password",
        ),
        sizedBoxWithHeight(20),
        const AppTextFormField(
          name: 'confirm_password',
          hintText: "Re-Enter Password",
        ),
        sizedBoxWithHeight(40),
        Divider(
          color: AppColors.greyColor.withOpacity(0.12),
          height: 1.h,
        ),
        sizedBoxWithHeight(40),
        const AppTextFormField(
          name: 'username',
          hintText: "Username",
        ),
        sizedBoxWithHeight(120),
        Row(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  tncchecked = !tncchecked;
                });
              },
              child: Container(
                height: 25.h,
                width: 25.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    7.r,
                  ),
                  border: Border.all(
                    color: AppColors.black,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: tncchecked
                      ? Icon(
                          Icons.check,
                          size: 20.h,
                          color: AppColors.black,
                        )
                      : SizedBox(),
                ),
              ),
            ),
            sizedBoxWithWidth(18),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "I agree to the ",
                    style: AppText.text12w400,
                  ),
                  TextSpan(
                    text: "Terms and Conditions",
                    style: AppText.text12w400.copyWith(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        sizedBoxWithHeight(20),
        Row(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  ppchecked = !ppchecked;
                });
              },
              child: Container(
                height: 25.h,
                width: 25.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    7.r,
                  ),
                  border: Border.all(
                    color: AppColors.black,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: ppchecked
                      ? Icon(
                          Icons.check,
                          size: 20.h,
                          color: AppColors.black,
                        )
                      : SizedBox(),
                ),
              ),
            ),
            sizedBoxWithWidth(18),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "I agree to the ",
                    style: AppText.text12w400,
                  ),
                  TextSpan(
                    text: "Privacy Policy",
                    style: AppText.text12w400.copyWith(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}
