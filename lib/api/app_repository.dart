import 'dart:convert';
import 'dart:developer';

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
    final response = await helper.get("api/qr-types", {});

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
    print(body);
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
    var header = {"Authorization": "Bearer $usertoken"};
    print(header);
    final response = await helper.post("api/auth/qrs", body, header);

    return response;
  }

  Future<dynamic> forgotpassword({
    required String email,
  }) async {
    var body = {
      "email": email,
    };
    final response = await helper.post(
      "api/auth/forgot-password",
      body,
      {},
    );

    return response;
  }

  Future<dynamic> getPrivacyPolicy() async {
    final response = await helper.get("api/settings", {});

    return response;
  }

  Future<dynamic> getpastqrs({
    required String usertoken,
  }) async {
    final response = await helper.get(
      "api/auth/qrs",
      {
        "Authorization": "Bearer $usertoken",
      },
    );

    print("response is $response");
    return response;
  }

  Future<dynamic> getqrDetail({
    required String usertoken,
    required String qrid,
  }) async {
    final response = await helper.get(
      "api/auth/qrs/$qrid",
      {
        "Authorization": "Bearer $usertoken",
      },
    );

    log(response.toString());
    return response;
  }

  Future<dynamic> getplans() async {
    final response = await helper.get("api/plans/android", {});

    return response;
  }

  Future<dynamic> postcontactus({
    required String email,
    required String message,
  }) async {
    var body = jsonEncode({"email": email, "message": message});
    final response = await helper.post(
      "api/support/mail",
      body,
      {"Content-Type": "application/json"},
    );

    return response;
  }
}
