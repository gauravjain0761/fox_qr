import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fox/features/drawer/logic/drawercontroller.dart';
import 'package:fox/shared/shared.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<DrawerProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppHeader(
        height: 70.h,
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
      body: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          children: [
            Text(
              "Enquire About Enterprise",
              style: GoogleFonts.montserrat(
                color: AppColors.black,
                fontSize: 25.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            sizedBoxWithHeight(41),
            AppTextFormField(
              controller: controller.emailController,
              name: 'name',
              hintText: "email@address.foxtrot",
            ),
            sizedBoxWithHeight(20),
            AppTextFormField(
              controller: controller.messageController,
              name: "",
              hintText: "Write A Short Message",
              maxLines: 9,
            ),
            Spacer(),
            SingleChildScrollView(
              child: InkWell(
                onTap: () {
                  if (!isValidEmail(
                    controller.emailController.text,
                  )) {
                    context.showSnackBar(
                      "Please Enter Valid Email",
                    );
                  } else if (controller.messageController.text.isEmpty) {
                    context.showErrorSnackBar("Message should not be empty");
                  } else {
                    controller.postcontactus(context: context);
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: 16.h,
                  ),
                  child: Center(
                    child: Text(
                      "Submit",
                      style: GoogleFonts.montserrat(
                        color: AppColors.black,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: AppColors.black,
                        width: 2,
                      )),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
