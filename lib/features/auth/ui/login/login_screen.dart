import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:fox/features/auth/logic/login_controller.dart';
import 'package:fox/routes/routes.dart';
import 'package:fox/shared/shared.dart';
import 'package:fox/themes/app_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final logincontroller = Provider.of<LoginController>(context);

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
                _renderForm(controller: logincontroller),
                const Spacer(),
                AppButton(
                  onClick: () {
                    _handleOnTap(controller: logincontroller);
                  },
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

  Widget _renderForm({required LoginController controller}) {
    return FormBuilder(
      key: controller.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          Text(
            'Log In',
            style: GoogleFonts.montserrat(
              fontSize: 25.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.black,
            ),
          ),
          sizedBoxWithHeight(50),
          AppTextFormField(
            controller: controller.emailController,
            validator: FormBuilderValidators.compose(
              [
                FormBuilderValidators.required(),
                FormBuilderValidators.email(),
              ],
            ),
            name: 'email',
            hintText: "email@address.foxtrot",
          ),
          sizedBoxWithHeight(20),
          AppTextFormField(
            controller: controller.passwordController,
            name: 'password',
            hintText: "Password",
            validator: FormBuilderValidators.required(),
          ),
          sizedBoxWithHeight(29),
          Text.rich(
            TextSpan(
              text: 'Don’t have an account? ',
              children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      AppEnvironment.navigator
                          .pushNamed(AuthRoutes.signupScreen);
                    },
                  text: 'Sign Up Here',
                  style: GoogleFonts.montserrat(
                    fontSize: 15.sp,
                    color: AppColors.pinkColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
              style: GoogleFonts.montserrat(
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
                  style: GoogleFonts.montserrat(
                    fontSize: 15.sp,
                    color: AppColors.pinkColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
              style: GoogleFonts.montserrat(
                fontSize: 15.sp,
                color: AppColors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          sizedBoxWithHeight(29),
          InkWell(
            onTap: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              prefs.setBool(Strings.isskipped, true).then((value) {
                AppEnvironment.navigator
                    .pushReplacementNamed(GeneralRoutes.homePageScreen);
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: 8.h,
                horizontal: 16.w,
              ),
              child: Text(
                "SKIP",
                style: AppText.text14w400,
              ),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: AppColors.grey500,
                  ),
                  borderRadius: BorderRadius.circular(20)),
            ),
          )
        ],
      ),
    );
  }

  void _handleOnTap({required LoginController controller}) {
    if (controller.formKey.currentState!.validate()) {
      controller.douserlogin(
        context: context,
      );

      //  AppEnvironment.navigator.pushNamed(GeneralRoutes.homePageScreen);

      // form submission logic
    }
  }
}
