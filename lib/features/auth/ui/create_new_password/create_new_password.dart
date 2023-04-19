import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:fox/shared/shared.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  TextEditingController password = TextEditingController();

  final _formKey = GlobalKey<FormBuilderState>();

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
            height: 50.r,
            width: 50.r,
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
    return FormBuilder(
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
          AppTextFormField(
            name: 'password',
            controller: password,
            validator: FormBuilderValidators.compose(
              [
                FormBuilderValidators.required(),
                FormBuilderValidators.minLength(8),
              ],
            ),
            hintText: "Create A Password",
          ),
          sizedBoxWithHeight(20),
          AppTextFormField(
            validator: (val) {
              if (val == null) {
                return 'Please Enter Password';
              }
              if (val != password.text) {
                return 'Password not match';
              }
              return null;
            },
            name: 'confirm_password',
            hintText: "Re-Enter Password",
            // hintStyle: AppText.text15w400.copyWith(
            //   color: AppColors.black,
            // ),
          ),
        ],
      ),
    );
  }
}
