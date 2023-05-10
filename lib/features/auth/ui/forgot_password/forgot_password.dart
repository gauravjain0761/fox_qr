import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:fox/routes/routes.dart';
import 'package:fox/shared/shared.dart';
import 'package:fox/themes/app_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: 'forgot');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(
        leftWidget: InkWell(
          onTap: () {
            AppEnvironment.navigator.pop();
          },
          child: AppImage(
            Images.arrowBackBlackFilled,
            height: 40.r,
            width: 40.r,
          ),
        ),
        height: 70.h,
        onDrawerTap: () async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool(Strings.isskipped, true).then((value) {
            AppEnvironment.navigator.pushNamed(GeneralRoutes.homePageScreen);
          });
        },
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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: AppButton(
                    border: Border.all(color: AppColors.black, width: 2.r),
                    primaryColor: AppColors.white,
                    highLightedTextColor: AppColors.black,
                    textStyle: AppText.text20w600Black,
                    onClick: _handleSend,
                    label: 'Send',
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
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          Text(
            'Forgot Password',
            style: GoogleFonts.montserrat(
              fontSize: 25.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.black,
            ),
          ),
          sizedBoxWithHeight(40),
          Text(
            'Please enter your email address to\nreceive an activation link',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          sizedBoxWithHeight(40),
          AppTextFormField(
            name: 'email',
            hintText: "email@address.foxtrot",
            validator: (value) {
              if (isValidEmail(value!)) {
                return null;
              } else {
                return "Please Enter Valid Email";
              }
            },
            hintStyle: AppText.text15w400.copyWith(
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }

  void _handleSend() {
    if (_formKey.currentState!.validate()) {
      AppEnvironment.navigator.pushNamed(AuthRoutes.createNewPasswordScreen);
    }
  }
}
