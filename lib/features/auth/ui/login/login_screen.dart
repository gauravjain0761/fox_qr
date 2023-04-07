import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fox/routes/routes.dart';
import 'package:fox/shared/shared.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Column(
              children: [
                const Spacer(),
                _renderForm(),
                const Spacer(),
                AppButton(
                  onClick: _handleOnTap,
                  label: 'Log In',
                  iconAlign: Alignment.centerRight,
                  icon: Padding(
                    padding: EdgeInsets.only(
                      right: 15.w,
                    ),
                    child: AppImage(
                      Images.arrowBackWhite,
                      height: 16.h,
                      width: 32.w,
                    ),
                  ),
                ),
                sizedBoxWithHeight(24),
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
          'Log In',
          style: TextStyle(
            fontSize: 25.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.black,
          ),
        ),
        sizedBoxWithHeight(50),
        const AppTextFormField(
          name: 'email',
          hintText: "email@address.foxtrot",
        ),
        sizedBoxWithHeight(20),
        const AppTextFormField(
          name: 'password',
          hintText: "Password",
        ),
        sizedBoxWithHeight(29),
        Text.rich(
          TextSpan(
            text: 'Don’t have an account? ',
            children: [
              TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    AppEnvironment.navigator.pushNamed(AuthRoutes.signupScreen);
                  },
                text: 'Sign Up Here',
                style: TextStyle(
                  fontSize: 15.sp,
                  color: AppColors.pinkColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
            style: TextStyle(
              fontSize: 15.sp,
              color: AppColors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        sizedBoxWithHeight(29),
        Text.rich(
          TextSpan(
            text: 'Forgot Password? ',
            children: [
              TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    AppEnvironment.navigator
                        .pushNamed(AuthRoutes.forgotPasswordScreen);
                  },
                text: 'Reset Here',
                style: TextStyle(
                  fontSize: 15.sp,
                  color: AppColors.pinkColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
            style: TextStyle(
              fontSize: 15.sp,
              color: AppColors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  void _handleOnTap() {
    AppEnvironment.navigator.pushNamed(GeneralRoutes.homePageScreen);
  }
}
