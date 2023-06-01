import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fox/api/app_repository.dart';
import 'package:fox/models/privacypolicy.dart';
import 'package:fox/shared/shared.dart';

class DrawerProvider extends ChangeNotifier {
  PrivacyPolicy? _privacyPolicy;

  PrivacyPolicy? get privacypolicy => _privacyPolicy;

  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  // Fetch QR Types from API
  void getprivacypolicy({
    required BuildContext context,
  }) {
    AppRepository().getPrivacyPolicy().then((value) async {
      _privacyPolicy = PrivacyPolicy.fromJson(value);

      notifyListeners();
    });
  }

  void postcontactus({
    required BuildContext context,
  }) {
    Loader.show(context,
        progressIndicator: CircularProgressIndicator(
          color: AppColors.appColor,
        ));
    AppRepository()
        .postcontactus(
      email: emailController.text,
      message: messageController.text,
    )
        .then((value) async {
      if (value["status"] == false) {
        context.showSnackBar(value["message"]);
        Loader.hide();
      } else {
        context.showSnackBar(value["message"]);

        Loader.hide();
        emailController.text = "";
        messageController.text = "";

        notifyListeners();
      }
    }).onError((error, stackTrace) {
      context.showSnackBar(error.toString());
      Loader.hide();
      notifyListeners();
    });
  }
}
