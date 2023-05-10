import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fox/api/app_repository.dart';
import 'package:fox/models/register.dart';
import 'package:fox/routes/routes.dart';
import 'package:fox/shared/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterController extends ChangeNotifier {
  late RegisterSuccess _registerSuccess;
  bool isloading = false;
  bool ispasswordvisible = false;
  bool iscpasswordvisible = false;

  RegisterSuccess get registersuccess => _registerSuccess;

  bool tncchecked = false;
  bool ppchecked = false;

  TextEditingController password = TextEditingController();
  TextEditingController emailController = TextEditingController();

  void changetnc() {
    tncchecked = !tncchecked;
    notifyListeners();
  }

  void changepasswordvisiblity() {
    ispasswordvisible = !ispasswordvisible;
    notifyListeners();
  }

  void changecpasswordvisiblity() {
    iscpasswordvisible = !iscpasswordvisible;
    notifyListeners();
  }

  void changepp() {
    ppchecked = !ppchecked;
    notifyListeners();
  }

  void douserRegistration(
      {required BuildContext context, required GlobalKey<FormState> formkey}) {
    Loader.show(context,
        progressIndicator: CircularProgressIndicator(
          color: AppColors.appColor,
        ));

    AppRepository()
        .userregister(
      email: emailController.text,
      password: password.text,
    )
        .then((value) async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      if (value["status"] == false) {
        Loader.hide();

        showSnackBar(value["errors"]["email"][0].toString());
      } else {
        _registerSuccess = RegisterSuccess.fromJson(value);
        showSnackBar(_registerSuccess.message);

        Loader.hide();

        prefs.setString(Strings.usertoken, _registerSuccess.token);
        formkey.currentState!.reset();
        emailController.text = "";
        password.text = '';

        AppEnvironment.navigator.pushNamed(AuthRoutes.loginScreen);
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      context.showSnackBar(error.toString());
      Loader.hide();
      notifyListeners();
    });
  }
}
