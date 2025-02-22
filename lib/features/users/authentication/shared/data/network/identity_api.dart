import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mtaa_frontend/features/users/authentication/log-in/data/models/requests/logInRequest.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/data/models/token.dart';
import 'package:mtaa_frontend/features/users/authentication/sign-up/data/models/requests/StartSignUpEmailVerificationRequest.dart';
import 'package:mtaa_frontend/features/users/authentication/sign-up/data/models/requests/signUpByEmailRequest.dart';
import 'package:mtaa_frontend/features/users/authentication/sign-up/data/models/requests/signUpVerifyEmailRequest.dart';

abstract class IdentityApi {
  Future<bool> signUpStartEmailVerification(StartSignUpEmailVerificationRequest request);
  Future<bool> signUpVerifyEmail(SignUpVerifyEmailRequest request);
  Future<Token?> signUpByEmail(SignUpByEmailRequest request);
  Future<Token?> logIn(LogInRequest request);
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
        String? msg = e.response?.data['Message'];

        if(msg!=null){
          Fluttertoast.showToast(
            msg: msg,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
          );
        }
        return false;
      } else {
        print(e);
        return false;
      }
    }
  }

  @override
  Future<bool> signUpVerifyEmail(SignUpVerifyEmailRequest request) async {
    final fullUrl = controllerName + '/sign-up-verify-email';
    try {
      var res = await dio.post(fullUrl,data: request.toJson());
      return res.data as bool;
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
        print(e.response?.requestOptions);
        String? msg = e.response?.data['Message'];

        if(msg!=null){
          Fluttertoast.showToast(
            msg: msg,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
          );
        }
        return false;
      } else {
        print(e);
        return false;
      }
    }
  }

  @override
  Future<Token?> signUpByEmail(SignUpByEmailRequest request) async {
    final fullUrl = controllerName + '/sign-up-by-email';
    try {
      var res = await dio.post(fullUrl,data: request.toJson());
      return Token.fromJson(res.data);
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
        print(e.response?.requestOptions);
        String? msg = e.response?.data['Message'];

        if(msg!=null){
          Fluttertoast.showToast(
            msg: msg,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
          );
        }
        return null;
      } else {
        print(e);
        return null;
      }
    }
  }

  @override
  Future<Token?> logIn(LogInRequest request) async {
    final fullUrl = controllerName + '/log-in';
    try {
      var res = await dio.post(fullUrl,data: request.toJson());
      return Token.fromJson(res.data);
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
        print(e.response?.requestOptions);
        String? msg = e.response?.data['Message'];

        if(msg!=null){
          Fluttertoast.showToast(
            msg: msg,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
          );
        }
        return null;
      } else {
        print(e);
        return null;
      }
    }
  }
}
