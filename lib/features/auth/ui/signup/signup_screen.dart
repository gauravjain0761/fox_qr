import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:fox/features/auth/logic/register_controller.dart';
import 'package:fox/shared/shared.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:layout_grids/layout_grids.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../routes/routes.dart';
import '../../../../themes/app_text.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> formKey =
      GlobalKey<FormState>(debugLabel: '_register');
  @override
  Widget build(BuildContext context) {
    final registercontroller = Provider.of<RegisterController>(context);

    return WillPopScope(
      onWillPop: () async {
        formKey.currentState!.reset();
        registercontroller.emailController.text = "";
        registercontroller.password.text = '';
        registercontroller.username.text = "";
        return true;
      },
      child: Scaffold(
        appBar: AppHeader(
          height: 70.h,
          onDrawerTap: () async {
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            prefs.setBool(Strings.isskipped, true).then((value) {
              formKey.currentState!.reset();

              registercontroller.emailController.text = "";
              registercontroller.password.text = '';
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
              padding: EdgeInsets.symmetric(
                horizontal: 33.w,
                vertical: 24.h,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  sizedBoxWithHeight(22),
                  _renderForm(
                    registercontroller,
                  ),
                  const Spacer(),

                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          registercontroller.changetnc();
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
                            child: registercontroller.tncchecked
                                ? Icon(
                                    Icons.check,
                                    size: 20.h,
                                    color: AppColors.black,
                                  )
                                : const SizedBox(),
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
                          registercontroller.changepp();
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
                            child: registercontroller.ppchecked
                                ? Icon(
                                    Icons.check,
                                    size: 20.h,
                                    color: AppColors.black,
                                  )
                                : const SizedBox(),
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
                  ),
                  sizedBoxWithHeight(20),

                  // TODO: add app check

                  AppButton(
                    onClick: () {
                      if (!registercontroller.tncchecked) {
                        context
                            .showSnackBar("Please Accept Terms and Conditions");
                      } else if (!registercontroller.ppchecked) {
                        context.showSnackBar("Please Accept Privacy Policy");
                      } else if (formKey.currentState!.validate()) {
                        registercontroller.douserRegistration(
                            context: context, formkey: formKey);
                      }
                    },
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
      ),
    );
  }

  Widget _renderForm(RegisterController controller) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Text(
            'Sign Up',
            style: GoogleFonts.montserrat(
              fontSize: 25.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.black,
            ),
          ),
          sizedBoxWithHeight(41),
          AppTextFormField(
            // suffixIcon: const SizedBox(),
            validator: (value) {
              if (isValidEmail(value!)) {
                return null;
              } else {
                return "Please Enter Valid Email";
              }
            },
            name: 'email',
            controller: controller.emailController,
            hintText: "email@address.foxtrot",
          ),
          sizedBoxWithHeight(20),
          TextFormField(
            controller: controller.password,
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
                return "Password must be of 8 characters with at least one\ndigit and one special character";
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
                borderRadius: BorderRadius.circular(25.r),
                borderSide: BorderSide(
                  color: AppColors.greyColor.withOpacity(0.12),
                  width: 1.r,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.r),
                borderSide: BorderSide(
                  color: AppColors.greyColor.withOpacity(0.12),
                  width: 1.r,
                ),
              ),
              hintText: "Create A Password",
              hintStyle: AppText.text15w400.copyWith(
                color: AppColors.black,
              ),
            ),
          ),

          sizedBoxWithHeight(20),
          TextFormField(
            validator: (val) {
              if (val == null) {
                return 'Please Enter Password';
              }
              if (val != controller.password.text) {
                return 'Password not match';
              }
              return null;
            },
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 15.sp,
              color: AppColors.black,
              fontWeight: FontWeight.w400,
            ),
            cursorColor: AppColors.black,
            obscureText: controller.iscpasswordvisible ? false : true,
            decoration: InputDecoration(
              counterText: "",
              contentPadding: EdgeInsets.symmetric(
                    vertical: 10.h,
                  ) +
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
                  controller.changecpasswordvisiblity();
                },
                child: Icon(
                  controller.iscpasswordvisible
                      ? Icons.remove_red_eye
                      : Icons.visibility_off_rounded,
                  color: AppColors.greyColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.r),
                borderSide: BorderSide(
                  color: AppColors.greyColor.withOpacity(0.12),
                  width: 1.r,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.r),
                borderSide: BorderSide(
                  color: AppColors.greyColor.withOpacity(0.12),
                  width: 1.r,
                ),
              ),
              hintText: "Re-Enter Password",
              hintStyle: AppText.text15w400.copyWith(
                color: AppColors.black,
              ),
            ),
          ),

          // AppTextFormField(
          //   suffixIcon: Icon(Icons.remove_red_eye),

          //   name: 'confirm_password',
          //   hintText: "Re-Enter Password",
          // ),
          sizedBoxWithHeight(40),
          Divider(
            color: AppColors.greyColor.withOpacity(0.12),
            height: 1.h,
          ),
          sizedBoxWithHeight(40),
          AppTextFormField(
            controller: controller.username,
            validator: FormBuilderValidators.compose(
              [
                FormBuilderValidators.required(),
              ],
            ),
            name: 'username',
            hintText: "Username",
          ),
        ],
      ),
    );
  }
}
