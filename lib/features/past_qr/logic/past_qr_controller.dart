import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fox/api/app_repository.dart';
import 'package:fox/models/past_qrs.dart';
import 'package:fox/models/qr_detail.dart';
import 'package:fox/shared/shared.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PastQrController extends ChangeNotifier {
  PastQrs? _pastQrs;
  PastQrs? get pastqrs => _pastQrs;
  QrDetail? _qrDetail;
  QrDetail? get qrdetail => _qrDetail;
  bool isloading = false;

  void saveimage({
    required BuildContext context,
    required String image,
  }) {
    Loader.show(context,
        progressIndicator: CircularProgressIndicator(
          color: AppColors.appColor,
        ));
    GallerySaver.saveImage(image).then((success) {
      context.showSnackBar(
        "Your image has been saved to your photos",
      );
      Loader.hide();
    }).whenComplete(() {
      notifyListeners();
    });
  }

  Future<void> getpastqrs({
    required BuildContext context,
  }) async {
    isloading = true;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // ignore: use_build_context_synchronously

    AppRepository()
        .getpastqrs(usertoken: prefs.getString(Strings.usertoken)!)
        .then((value) async {
      _pastQrs = PastQrs.fromJson(value);
      isloading = false;
      Loader.hide();

      //   AppEnvironment.navigator.pushNamed(AuthRoutes.loginScreen);
      notifyListeners();
    }).onError((error, stackTrace) {
      Loader.hide();

      isloading = false;
      context.showSnackBar(error.toString());
      notifyListeners();
    });
  }

  Future<void> getqrDetail(
      {required BuildContext context, required String qrid}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // ignore: use_build_context_synchronously
    Loader.show(context,
        progressIndicator: CircularProgressIndicator(
          color: AppColors.appColor,
        ));

    AppRepository()
        .getqrDetail(
      usertoken: prefs.getString(Strings.usertoken)!,
      qrid: qrid,
    )
        .then((value) async {
      _qrDetail = QrDetail.fromJson(value);

      Loader.hide();

      //   AppEnvironment.navigator.pushNamed(AuthRoutes.loginScreen);
      notifyListeners();
    }).onError((error, stackTrace) {
      context.showSnackBar(error.toString());
      Loader.hide();
      notifyListeners();
    });
  }
}
