import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:fox/features/auth/logic/register_controller.dart';
import 'package:fox/shared/shared.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../themes/app_text.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final registercontroller = Provider.of<RegisterController>(context);

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
              mainAxisSize: MainAxisSize.min,
              children: [
                sizedBoxWithHeight(22),
                _renderForm(registercontroller),
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
                    } else if (registercontroller.formKey.currentState!
                        .validate()) {
                      registercontroller.douserRegistration(context: context);
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
    );
  }

  Widget _renderForm(RegisterController controller) {
    return FormBuilder(
      key: controller.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
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
            validator: FormBuilderValidators.compose(
              [
                FormBuilderValidators.required(),
                FormBuilderValidators.email(),
              ],
            ),
            name: 'email',
            controller: controller.emailController,
            hintText: "email@address.foxtrot",
          ),
          sizedBoxWithHeight(20),
          AppTextFormField(
            controller: controller.password,
            validator: FormBuilderValidators.compose(
              [
                FormBuilderValidators.required(),
                FormBuilderValidators.minLength(8),
              ],
            ),
            name: 'password',
            hintText: "Create A Password",
          ),
          sizedBoxWithHeight(20),
          AppTextFormField(
            validator: (val) {
              if (val == null) {
                return 'Please Enter Password';
              }
              if (val != controller.password.text) {
                return 'Password not match';
              }
              return null;
            },
            name: 'confirm_password',
            hintText: "Re-Enter Password",
          ),
          sizedBoxWithHeight(40),
          // Divider(
          //   color: AppColors.greyColor.withOpacity(0.12),
          //   height: 1.h,
          // ),
          // sizedBoxWithHeight(40),
          // AppTextFormField(
          //   validator: FormBuilderValidators.compose(
          //     [
          //       FormBuilderValidators.required(),
          //     ],
          //   ),
          //   name: 'username',
          //   hintText: "Username",
          // ),
          //  Spacer(),
        ],
      ),
    );
  }
}
