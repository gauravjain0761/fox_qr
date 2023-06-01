import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  final GlobalKey<FormState> formKey =
      GlobalKey<FormState>(debugLabel: '_login');

  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final logincontroller = Provider.of<LoginController>(context);

    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        //   key: _scaffoldKey,
        endDrawer: const AppDrawer(),
        appBar: AppHeader(
          height: 70.h,
          onDrawerTap: () async {
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            prefs.setBool(Strings.isskipped, true).then((value) {
              formKey.currentState!.reset();
              logincontroller.emailController.text = "";
              logincontroller.passwordController.text = '';

              AppEnvironment.navigator.pushNamed(GeneralRoutes.homePageScreen);
            });
            // AppEnvironment.navigator.pushNamed(G)
          },
        ),
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
      ),
    );
  }

  Widget _renderForm({required LoginController controller}) {
    return Form(
      key: formKey,
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
          TextFormField(
            controller: controller.passwordController,
            textAlign: TextAlign.center,
            validator: (value) {
              if (value!.length < 8) {
                return "Password must be of 8 characters with at least one\ndigit and one special character";
              } else if (!value.contains(
                RegExp("(?=.*?[A-Za-z])"),
              )) {
                return "Password must be of 8 characters with at least one\ndigit and one special character";
              } else if (!value.contains(RegExp("(?=.*?[0-9])"))) {
                return "Password must be of 8 characters with at least one\ndigit and one special character";
              } else if (!value.contains(RegExp("(?=.*?[!@#\$&*~])"))) {
                return "Password must be of 8 characters with at least one\ndigit and one special characters";
              } else {
                return null;
              }
            },
            style: GoogleFonts.montserrat(
              fontSize: 15.sp,
              color: AppColors.black,
              fontWeight: FontWeight.w400,
            ),
            cursorColor: AppColors.black,
            obscureText: controller.ispasswordvisible ? false : true,
            decoration: InputDecoration(
              counterText: "",
              contentPadding: EdgeInsets.symmetric(vertical: 10.h) +
                  EdgeInsets.only(
                    left: 45.w,
                  ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.r),
                borderSide: BorderSide(
                  color: AppColors.greyColor.withOpacity(0.12),
                  width: 1.r,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.r),
                borderSide: BorderSide(
                  color: AppColors.greyColor.withOpacity(0.12),
                  width: 1.r,
                ),
              ),
              suffixIcon: InkWell(
                onTap: () {
                  controller.changepasswordvisiblity();
                },
                child: Icon(
                  controller.ispasswordvisible
                      ? Icons.remove_red_eye
                      : Icons.visibility_off_rounded,
                  color: AppColors.greyColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  25.r,
                ),
                borderSide: BorderSide(
                  color: AppColors.greyColor.withOpacity(
                    0.12,
                  ),
                  width: 1.r,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  25.r,
                ),
                borderSide: BorderSide(
                  color: AppColors.greyColor.withOpacity(
                    0.12,
                  ),
                  width: 1.r,
                ),
              ),
              hintText: "Password",
              hintStyle: AppText.text15w400.copyWith(
                color: AppColors.black,
              ),
            ),
          ),
          sizedBoxWithHeight(
            29,
          ),
          Text.rich(
            TextSpan(
              text: 'Don’t have an account? ',
              children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      formKey.currentState!.reset();
                      controller.emailController.text = "";
                      controller.passwordController.text = '';
                      AppEnvironment.navigator.pushNamed(
                        AuthRoutes.signupScreen,
                      );
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
          sizedBoxWithHeight(
            29,
          ),
          Text.rich(
            TextSpan(
              text: 'Forgot Password? ',
              children: [
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      formKey.currentState!.reset();

                      controller.emailController.text = "";
                      controller.passwordController.text = '';
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
                formKey.currentState!.reset();
                controller.emailController.text = "";
                controller.passwordController.text = '';
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
    if (formKey.currentState!.validate()) {
      controller.douserlogin(
        context: context,
      );

      //  AppEnvironment.navigator.pushNamed(GeneralRoutes.homePageScreen);

      // form submission logic
    }
  }
}
