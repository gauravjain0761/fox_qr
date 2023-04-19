import 'package:fox/api/api_base_helper.dart';
import 'package:fox/models/login.dart';
import 'package:fox/models/qr_types.dart';

class AppRepository {
  ApiBaseHelper helper = ApiBaseHelper();

  Future<Login> userlogin({
    required String email,
    required String password,
  }) async {
    final response = await helper.post("api/auth/login", {
      "email": email,
      "password": password,
    }, {});

    return Login.fromJson(response);
  }

  Future<dynamic> userregister({
    required String email,
    required String password,
  }) async {
    final response = await helper.post("api/auth/register", {
      "email": email,
      "password": password,
    }, {});

    return response;
  }

  Future<dynamic> userlogout({
    required String usertoken,
  }) async {
    final response = await helper.post(
      "api/auth/logout",
      {},
      {
        "Authorization": "Bearer $usertoken",
      },
    );

    return response;
  }

  Future<QrTypes> getqrtypes() async {
    final response = await helper.get(
      "api/qr-types",
    );

    return QrTypes.fromJson(response);
  }

  Future<dynamic> createqrwithoutauth({
    required String qrstyle,
    required String qrtype,
    required String qrsize,
    required String qrtext,
    required String qrcolor,
    required String qrimage,
  }) async {
    var body = {
      "qr_style": qrstyle,
      "qr_type": qrtype,
      "qr_size": qrsize,
      "qr_text": qrtext,
      "qr_color": qrcolor,
      "qr_image": qrimage,
    };
    final response = await helper.post(
      "api/qrs",
      body,
      {},
    );

    return response;
  }

  Future<dynamic> createqrwithauth({
    required String qrstyle,
    required String qrtype,
    required String qrsize,
    required String qrtext,
    required String usertoken,
    required String qrcolor,
    required String qrname,
    required String qrimage,
  }) async {
    var body = {
      "qr_name": qrname,
      "qr_style": qrstyle,
      "qr_type": qrtype,
      "qr_size": qrsize,
      "qr_text": qrtext,
      "qr_color": qrcolor,
      "qr_image": qrimage,
    };
    final response = await helper.post(
      "api/auth/qrs",
      body,
      {
        "Authorization": "Bearer $usertoken",
      },
    );

    return response;
  }
}
