import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fox/api/app_repository.dart';
import 'package:fox/routes/routes.dart';
import 'package:fox/shared/shared.dart';

class ResetPasswordController extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  void forgotpassword({
    required BuildContext context,
  }) {
    Loader.show(context,
        progressIndicator: CircularProgressIndicator(
          color: AppColors.appColor,
        ));
    AppRepository()
        .forgotpassword(
      email: emailController.text,
    )
        .then((value) async {
      if (value["status"] == false) {
        //if (context.mounted) {
        context.showSnackBar(value["message"]);
        Loader.hide();
        //    }
      } else {
        context.showSnackBar(value["message"]);

        Loader.hide();
        emailController.text = "";
        AppEnvironment.navigator.pushReplacementNamed(
          AuthRoutes.loginScreen,
        );
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      context.showSnackBar(error.toString());
      Loader.hide();
      notifyListeners();
    });
  }
}
