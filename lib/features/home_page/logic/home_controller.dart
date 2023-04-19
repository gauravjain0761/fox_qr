import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fox/api/app_repository.dart';
import 'package:fox/features/home_page/widgets/downloadqrsheet.dart';
import 'package:fox/models/create_qr.dart';
import 'package:fox/models/qr_types.dart';
import 'package:fox/shared/shared.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends ChangeNotifier {
  QrTypes? _qrTypes;
  QrTypes? get qrtypes => _qrTypes;
  late CreateQr _createQr;
  File? fileimage;
  Uint8List? byteimage;

  CreateQr get createQr => _createQr;

  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController qrSizeController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool hidenetwork = true;
  String? securityType;
  String qrStyle = "halftone";
  int selectedbutton = 0;
  bool iscolorpickervisible = false;
  File? imageFile;
  String qrcolor = const Color(0xffffffff).toHex();
  String? qrImage;
  int selectedicon = 0;
  List<String> icons = [
    "assets/images/insta.svg",
    "assets/images/twitter.svg",
    "assets/images/messenger.svg",
    "assets/images/linkedin.svg",
    "assets/images/facebook.svg",
    "assets/images/tiktok.svg",
    "assets/images/google.svg",
    "assets/images/spotify.png",
  ];

  List<bool> isSelected = [
    true,
    false,
    false,
  ];

  void changecolortone({required int index}) {
    if (index == 0) {
      qrStyle = "halftone";
    } else {
      qrStyle = "fullcolor";
    }
    Logger.logMsg("value", qrStyle);
    notifyListeners();
  }

  void getqrtypes({
    required BuildContext context,
  }) {
    AppRepository().getqrtypes().then((value) async {
      _qrTypes = value;

      notifyListeners();
      //   context.removeLoadingIndicator;
    });
  }

  void chagecolorpickervisiblity() {
    iscolorpickervisible = !iscolorpickervisible;
    notifyListeners();
  }

  void oncolorChange({required Color color}) {
    qrcolor = color.toHex();
    notifyListeners();
  }

  void pickimagefromgallery({required BuildContext context}) {
    context
        .pickFile(
      pickingType: FileType.image,
    )
        .then(
      (value) {
        context.cropImage(value!).then(
          (value) {
            imageFile = File(value.path);
            final bytes = File(imageFile!.path).readAsBytesSync();
            qrImage = base64Encode(bytes);

            notifyListeners();
          },
        );
      },
    );
  }

  void changebuttonindex({required int index}) {
    selectedbutton = index;
    notifyListeners();
  }

  void selectStartTime({required TimeOfDay timeOfDay}) {
    startTimeController.text =
        '${timeOfDay.hour.toString()} : ${timeOfDay.minute.toString()}';
    notifyListeners();
  }

  void selectEndTime({required TimeOfDay timeOfDay}) {
    endTimeController.text =
        '${timeOfDay.hour.toString()} : ${timeOfDay.minute.toString()}';
    notifyListeners();
  }

  void assignSecuerityType({
    required String securityType,
  }) {
    securityType = securityType;
    notifyListeners();
  }

  void showhidenetwork() {
    hidenetwork = !hidenetwork;
    notifyListeners();
  }

  void changeIconindex({required int index}) {
    selectedicon = index;
    notifyListeners();
  }

  void saveimage({
    required BuildContext context,
    required String image,
  }) {
    GallerySaver.saveImage(image).then((success) {
      context.showSnackBar(
        "Your image has been saved to your photos",
      );
    }).whenComplete(() {
      AppEnvironment.navigator.pop();
      emailController.clear();
      qrSizeController.clear();
      imageFile!.path == "";
      notifyListeners();
    });
  }

  Future<void> createqr({
    required int qrtype,
    required BuildContext context,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (context.mounted) {
      Loader.show(context);
    }

    final String istokenavailable = prefs.getString(Strings.usertoken) ?? "";

    if (istokenavailable == "") {
      AppRepository()
          .createqrwithoutauth(
              qrstyle: qrStyle,
              qrtype: qrtype.toString(),
              qrsize: qrSizeController.text,
              qrtext: emailController.text,
              qrcolor: qrcolor,
              qrimage: "data:image/jpeg;base64,$qrImage")
          .then((value) async {
        if (value["status"] == false) {
          Loader.hide();

          if (context.mounted) {
            context.showSnackBar(value["message"].toString());
          }
        } else {
          _createQr = CreateQr.fromJson(value);
          Loader.hide();
          downloadqr(context: context, createQr: createQr);
          Uint8List bytes = base64.decode(createQr.image.split(',').last);
          byteimage = bytes;
          final tempDir = await getTemporaryDirectory();
          File file = await File('${tempDir.path}/image.png').create();
          file.writeAsBytesSync(bytes);
          fileimage = file;
          notifyListeners();
        }
      });
    } else {
      AppRepository()
          .createqrwithauth(
              usertoken: istokenavailable,
              qrname: "Website",
              qrstyle: qrStyle,
              qrtype: qrtype.toString(),
              qrsize: qrSizeController.text,
              qrtext: emailController.text,
              qrcolor: qrcolor,
              qrimage: "data:image/jpeg;base64,$qrImage")
          .then((value) async {
        if (value["status"] == false) {
          Loader.hide();

          if (context.mounted) {
            context.showSnackBar(value["message"].toString());
          }
        } else {
          _createQr = CreateQr.fromJson(value);
          Loader.hide();
          downloadqr(context: context, createQr: createQr);
          Uint8List bytes0 = base64.decode(createQr.image.split(',').last);
          byteimage = bytes0;
          final tempDir = await getTemporaryDirectory();
          File file = await File('${tempDir.path}/image.png').create();
          file.writeAsBytesSync(bytes0);
          fileimage = file;
          notifyListeners();
        }
      });
    }
  }
}
