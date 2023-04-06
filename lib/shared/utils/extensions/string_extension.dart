import 'package:flutter/material.dart';

import '../../shared.dart';

extension StringExtension on String {
  /// Method used to precache the asset image into engine
  Future<void> preCacheLocalImages(BuildContext context) async {
    try {
      await precacheImage(AssetImage(this), context);
    } catch (e, st) {
      Logger.logError('CommonUtils', e, stackTrace: st);
    }
  }

  bool get isNetworkUrl {
    return contains('http');
  }

  bool get isVideo {
    var path = toLowerCase();
    return path.contains('.mp4') ||
        path.contains('.avi') ||
        path.contains('.mov') ||
        path.contains('.mkv') ||
        path.contains('.webm');
  }

  String get inCaps {
    if (isEmpty) {
      return '';
    }

    if (length < 2) {
      return this[0].toUpperCase();
    }
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String get capitalizeFirstOfEach {
    if (isEmpty) {
      return '';
    }
    return toLowerCase().split(' ').map((str) => str.inCaps).join(' ');
  }

  String getFileWithFileExtension(String filePath) {
    try {
      return '$this.${filePath.split('.').last}';
    } catch (e) {
      return this;
    }
  }
}
