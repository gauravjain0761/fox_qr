import 'dart:io';

import 'package:flutter/material.dart';

class CreateQrController extends ChangeNotifier {
  File? fileImage;
  void onSetImage(File? file) {
    fileImage = file;
    notifyListeners();
  }
}
