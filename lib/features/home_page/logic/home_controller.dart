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
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends ChangeNotifier {
  QrTypes? _qrTypes;
  QrTypes? get qrtypes => _qrTypes;
  late CreateQr _createQr;
  File? fileimage;
  double? latitude;
  double? longitude;
  Uint8List? byteimage;

  String qrtext = "";
  // late CreateQrAuth _createQrAuth;
  // CreateQrAuth get createqrauth => _createQrAuth;
  CreateQr get createQr => _createQr;

  TextEditingController qrSizeController = TextEditingController();
  String qrsize = "600";
  TextEditingController emailController = TextEditingController();
  TextEditingController webisteController = TextEditingController();
  TextEditingController emailSubjectController = TextEditingController();
  TextEditingController emailMessageController = TextEditingController();
  TextEditingController socialProfileController = TextEditingController();
  TextEditingController whatsAppController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController longitudeController = TextEditingController();
  TextEditingController eventtitle = TextEditingController();
  TextEditingController eventlocation = TextEditingController();
  TextEditingController eventstarttime = TextEditingController();
  TextEditingController eventendTime = TextEditingController();
  TextEditingController cardfirstname = TextEditingController();
  TextEditingController cardlastname = TextEditingController();
  TextEditingController cardphone = TextEditingController();
  TextEditingController cardemail = TextEditingController();
  TextEditingController cardorg = TextEditingController();
  TextEditingController cardjob = TextEditingController();
  TextEditingController cardstreet = TextEditingController();
  TextEditingController cardcity = TextEditingController();
  TextEditingController cardzip = TextEditingController();
  TextEditingController cardstate = TextEditingController();
  TextEditingController cardcountry = TextEditingController();
  TextEditingController cardurl = TextEditingController();
  TextEditingController networkname = TextEditingController();
  TextEditingController wifipassword = TextEditingController();

  TextEditingController colorcodecontroller =
      TextEditingController(text: "FFFFFFFF");
  bool hidenetwork = true;

  String? securitytype;
  String qrStyle = "halftone";
  int selectedbutton = 0;
  bool iscolorpickervisible = false;
  File? imageFile;
  // String qrcolor = const Color(0xffffffff).toHex();
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

  void fetchuserlocation() async {
    // Get the current location
    Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

// Access the latitude and longitude properties
    latitude = position.latitude;
    longitude = position.longitude;
    latitudeController.text = position.latitude.toString();
    longitudeController.text = position.longitude.toString();
    notifyListeners();
  }

// For Change Location by Drag Marker
  void ondrag(LatLng latLng) {
    latitude = latLng.latitude;
    longitude = latLng.longitude;
    // latitudeController.text = latitude.toString();
    // longitudeController.text = longitude.toString();
    notifyListeners();
  }

  // Change Color Tone on click of tab
  void changecolortone({required int index}) {
    if (index == 0) {
      qrStyle = "halftone";
    } else {
      qrStyle = "fullcolor";
    }
    notifyListeners();
  }

// Fetch QR Types from API
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

  // void oncolorChange({required Color color}) {
  //   qrcolor = color.toHex();
  //   notifyListeners();
  // }

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
    eventstarttime.text =
        '${timeOfDay.hour.toString()} : ${timeOfDay.minute.toString()}';
    notifyListeners();
  }

  void selectEndTime({required TimeOfDay timeOfDay}) {
    eventendTime.text =
        '${timeOfDay.hour.toString()} : ${timeOfDay.minute.toString()}';
    notifyListeners();
  }

  void assignSecuerityType({
    required String securityType,
  }) {
    securitytype = securityType;
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

  String getSize() {
    if (selectedbutton == 0) {
      return qrsize = "600";
    } else if (selectedbutton == 1) {
      return qrsize = "1200";
    } else {
      return qrsize = qrSizeController.text;
    }
  }

  Future<void> createqr({
    required int qrtype,
    required String qrname,
    required BuildContext context,
  }) async {
    if (context.mounted) {
      Loader.show(
        context,
        progressIndicator: CircularProgressIndicator(
          color: AppColors.appColor,
        ),
      );
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (qrname == "Website") {
      qrtext = webisteController.text;
    } else if (qrname == "Email") {
      qrtext =
          "mailto:${emailController.text}?subject=${emailSubjectController.text}&body=${emailMessageController.text}";
    } else if (qrname == "Social Media") {
      qrtext = socialProfileController.text;
    } else if (qrname == "Whatsapp") {
      qrtext = "https://wa.me/+${whatsAppController.text}";
    } else if (qrname == "Location") {
      qrtext = "http://maps.google.com/maps?q=$longitude,$latitude";
    } else if (qrname == "Event") {
      qrtext =
          "title=${eventtitle.text}&location=${eventlocation.text}&startTime=${eventstarttime.text}&endTime=${eventendTime.text}";
    } else if (qrname == "Virtual Card") {
      qrtext =
          "firstName=${cardfirstname.text}&lastName=${cardlastname.text}&phoneNumber=${cardphone.text}&email=${cardemail.text}&org=${cardorg.text}&job=${cardjob.text}&street=${cardstreet.text}&city=${cardcity.text}&zip=${cardzip.text}&state=${cardstate.text}&country=${cardcountry.text}&url=${cardurl.text}";
    } else if (qrname == "Wi-Fi") {
      qrtext =
          "WIFI:T:$securitytype;S:${networkname.text};P:${wifipassword.text};H:$hidenetwork;";
    } else {
      qrtext = "Other 3 Types";
    }
    notifyListeners();
    // if (condition) {}9

    final String istokenavailable = prefs.getString(Strings.usertoken) ?? "";
    if (istokenavailable == "") {
      AppRepository()
          .createqrwithoutauth(
              qrstyle: qrStyle,
              qrtype: qrtype.toString(),
              qrsize: getSize.call(),
              qrtext: qrtext,
              qrcolor: "#${colorcodecontroller.text.substring(2)}",
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
              qrsize: getSize.call(),
              qrtext: qrtext,
              qrcolor: "#${colorcodecontroller.text.substring(2)}",
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
