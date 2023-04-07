import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fox/shared/shared.dart';
import 'package:fox/themes/app_text.dart';

extension BuildContextExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;

  double get inset => MediaQuery.of(this).viewInsets.bottom;

  bool get isIOS => Platform.isIOS;

  void showErrorSnackBar(
    String msg, {
    Toast toastLength = Toast.LENGTH_SHORT,
  }) =>
      showSnackBar(msg, toastLength: toastLength);

  /// shows alert dialog with circular progressbar along with given text
  void showLoadingIndicator({
    String text = Strings.processing,
    bool isBarrierDismissible = false,
  }) {
    showDialog(
      context: this,
      barrierDismissible: isBarrierDismissible,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.r))),
            backgroundColor: AppColors.scaffoldColor,
            content: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircularProgressIndicator(color: AppColors.appColor),
                sizedBoxWithWidth(16),
                Expanded(child: Text(text, style: AppText.text14w500)),
              ],
            ),
          ),
        );
      },
    );
  }

  /// hides processing
  void removeLoadingIndicator() {
    AppEnvironment.navigator.pop();
  }

  void copyClipboard(String msg) async {
    await Clipboard.setData(ClipboardData(text: msg))
        .whenComplete(() => showSnackBar(Strings.codeCopyToClipboard));
  }

  void showSnackBar(
    String msg, {
    Toast toastLength = Toast.LENGTH_SHORT,
  }) {
    Fluttertoast.cancel();

    Fluttertoast.showToast(
      msg: msg,
      toastLength: toastLength,
      backgroundColor: const Color(0xff898989),
    );
  }

  Future<File?> pickFile({
    FileType pickingType = FileType.media,
    List<String>? extensions,
  }) async {
    try {
      var paths = (await FilePicker.platform.pickFiles(
        type: pickingType,
        allowedExtensions: extensions,
      ))
          ?.files;

      if (paths != null && paths.isNotEmpty) {
        return File(paths.first.path!);
      } else {
        Logger.logMsg(this, 'No file selected.');
        return null;
      }
    } catch (ex) {
      Logger.logError(this, 'Unsupported operation$ex');
    }
    return null;
  }

  void showImagePickerDialog({
    bool isBarrierDismissible = true,
    VoidCallback? onFirstCta,
    VoidCallback? onSecondCta,
    String firstCtaTitle = Strings.openCamera,
    String secondCtaTitle = Strings.openGallery,
  }) {
    showModalBottomSheet(
      context: this,
      backgroundColor: AppColors.scaffoldColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.r),
          topRight: Radius.circular(16.r),
        ),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppPill(),
              sizedBoxWithHeight(16),
              Text(Strings.selectOne, style: AppText.text16w600),
              sizedBoxWithHeight(16),
              Divider(thickness: 2.h),
              sizedBoxWithHeight(8),
              ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: onFirstCta,
                title: Text(
                  firstCtaTitle,
                  style: AppText.text14w400,
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: onSecondCta,
                title: Text(
                  secondCtaTitle,
                  style: AppText.text14w400,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Future<Uint8List?> launchImageEditor({required File imageData}) async {
    // final data = imageData.readAsBytesSync();
    // final result = await AppEnvironment.navigator
    //     .pushNamed(GeneralRoutes.imageEditor, arguments: data);
    // return result as Uint8List?;
  }

  void showAlertDialog({
    bool isBarrierDismissible = true,
    String title = '',
    String positiveText = 'Yes',
    String negativeText = 'No',
    VoidCallback? onPositiveTap,
    VoidCallback? onNegativeTap,
  }) {
    showDialog(
      context: this,
      barrierDismissible: isBarrierDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          backgroundColor: AppColors.scaffoldColor,
          title: Text(title, style: AppText.text16w600),
          actions: <Widget>[
            TextButton(
              onPressed: onPositiveTap,
              child: Text('YES', style: AppText.text14w400),
            ),
            TextButton(
              onPressed: onNegativeTap ?? () => AppEnvironment.navigator.pop(),
              child: Text('NO', style: AppText.text14w400),
            ),
          ],
        );
      },
    );
  }
}
