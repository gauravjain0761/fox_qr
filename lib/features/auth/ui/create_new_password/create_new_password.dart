import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:fox/routes/routes.dart';
import 'package:fox/shared/shared.dart';
import 'package:fox/themes/app_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  TextEditingController password = TextEditingController();
  bool ispasswordvisible = false;
  bool iscpasswordvisible = false;

  void changepasswordvisiblity() {
    setState(() {
      ispasswordvisible = !ispasswordvisible;
    });
  }

  void changecpasswordvisiblity() {
    setState(() {
      iscpasswordvisible = !iscpasswordvisible;
    });
  }

  final GlobalKey<FormState> _formKey =
      GlobalKey<FormState>(debugLabel: 'newpassword');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(
        height: 70.h,
        onDrawerTap: () async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool(Strings.isskipped, true).then((value) {
            AppEnvironment.navigator.pushNamed(GeneralRoutes.homePageScreen);
          });
        },
        leftWidget: InkWell(
          onTap: () {
            AppEnvironment.navigator.pop();
          },
          child: AppImage(
            Images.arrowBackBlackFilled,
            height: 35.r,
            width: 35.r,
          ),
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
                AppButton(
                    onClick: () {
                      if (_formKey.currentState!.validate()) {}
                    },
                    label: 'Save'),
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
            'Create New Password',
            style: GoogleFonts.montserrat(
              fontSize: 25.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.black,
            ),
          ),
          sizedBoxWithHeight(40),
          Text(
            'Create a new password\nfor your account',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          sizedBoxWithHeight(40),
          TextFormField(
            controller: password,
            textAlign: TextAlign.center,
            validator: (value) {
              if (value!.length < 8) {
                return "Minimum 8 Characters required";
              } else if (!value.contains(RegExp("(?=.*?[A-Za-z])"))) {
                return "Minimum 1 alphabet Required";
              } else if (!value.contains(RegExp("(?=.*?[0-9])"))) {
                return "Minimum 1 Digit Required";
              } else if (!value.contains(RegExp("(?=.*?[!@#\$&*~])"))) {
                return "Minimum 1 Special Character Required";
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
            obscureText: ispasswordvisible ? false : true,
            decoration: InputDecoration(
              counterText: "",
              contentPadding: EdgeInsets.symmetric(vertical: 10.h),
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
                  changepasswordvisiblity();
                },
                child: Icon(
                  ispasswordvisible
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
              if (val != password.text) {
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
            obscureText: iscpasswordvisible ? false : true,
            decoration: InputDecoration(
              counterText: "",
              contentPadding: EdgeInsets.symmetric(vertical: 10.h),
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
                  changecpasswordvisiblity();
                },
                child: Icon(
                  iscpasswordvisible
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
        ],
      ),
    );
  }
}
