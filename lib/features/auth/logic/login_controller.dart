import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fox/api/app_repository.dart';
import 'package:fox/models/login.dart';
import 'package:fox/routes/routes.dart';
import 'package:fox/shared/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends ChangeNotifier {
  late Login _login;

  get login => _login;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void reset() {
    emailController.clear();
    passwordController.clear();
    notifyListeners();
  }

  void douserlogin({
    required BuildContext context,
  }) {
    Loader.show(context,
        progressIndicator: CircularProgressIndicator(
          color: AppColors.appColor,
        ));
    AppRepository()
        .userlogin(
      email: emailController.text,
      password: passwordController.text,
    )
        .then((value) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if (value.status == false) {
        //if (context.mounted) {
        context.showSnackBar(value.message);
        Loader.hide();
        //    }
      } else {
        _login = value;

        Loader.hide();
        prefs.setString(Strings.usertoken, _login.token!);
        prefs.setBool(Strings.isskipped, false);
        //  formKey.currentState!.reset();

        emailController.text = "";
        passwordController.text = "";
        AppEnvironment.navigator.pushReplacementNamed(
          GeneralRoutes.homePageScreen,
        );
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      context.showSnackBar(error.toString());
      Loader.hide();
      notifyListeners();
    });
  }

  Future<void> douserlogout({required BuildContext context}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String usertoken = prefs.getString(Strings.usertoken)!;
    //   if (context.mounted) {
    Loader.show(context,
        progressIndicator: CircularProgressIndicator(
          color: AppColors.appColor,
        ));
    //   }
    AppRepository().userlogout(usertoken: usertoken).then((value) async {
      await prefs.remove(Strings.usertoken);
      // formKey.currentState!.reset();

      AppEnvironment.navigator.pushReplacementNamed(AuthRoutes.loginScreen);
      //    if (context.mounted) {
      Loader.hide();
      //  }
      notifyListeners();
    }).onError((error, stackTrace) {
      context.showSnackBar(error.toString());
      Loader.hide();
      notifyListeners();
    });
  }
}
