import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mtaa_frontend/core/config/app_config.dart';
import 'package:mtaa_frontend/features/authentication/sign-up/data/models/requests/StartSignUpEmailVerificationRequest.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class IdentityApi {
  Future<bool> signUpStartEmailVerification(StartSignUpEmailVerificationRequest request);
}


class IdentityImplApi extends IdentityApi {
  final Dio dio;
  final String controllerName = 'Identity';
  CancelToken cancelToken = CancelToken();

  IdentityImplApi(this.dio);

  @override
  Future<bool> signUpStartEmailVerification(StartSignUpEmailVerificationRequest request) async {
    final fullUrl = controllerName + '/sign-up-start-email-verification';
    try {
      await dio.post(fullUrl,data: request.toJson());
      return true;
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
        print(e.response?.requestOptions);
        Fluttertoast.showToast(
          msg: "Error sending request: $e",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
        );
        return false;
      } else {
        print(e);
        return false;
      }
    }
  }
}
