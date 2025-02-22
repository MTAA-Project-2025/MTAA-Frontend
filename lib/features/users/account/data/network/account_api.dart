import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mtaa_frontend/features/images/data/models/responses/myImageGroupResponse.dart';
import 'package:mtaa_frontend/features/users/account/data/models/requests/customUpdateAccountAvatarRequest.dart';
import 'package:mtaa_frontend/features/users/account/data/models/requests/presetUpdateAccountAvatarRequest.dart';
import 'package:mtaa_frontend/features/users/account/data/models/requests/updateAccountBirthDateRequest.dart';
import 'package:mtaa_frontend/features/users/account/data/models/requests/updateAccountDisplayNameRequest.dart';
import 'package:mtaa_frontend/features/users/account/data/models/requests/updateAccountUsernameRequest.dart';
import 'package:mtaa_frontend/features/users/account/data/models/responses/publicFullAccountResponse.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class AccountApi {
  Future<PublicFullAccountResponse?> publicGetFullAccount(String id);
  Future<MyImageGroupResponse?> customUpdateAccountAvatar(CustomUpdateAccountAvatarRequest request);
  Future<MyImageGroupResponse?> presetUpdateAccountAvatar(PresetUpdateAccountAvatarRequest request);
  Future<bool> updateAccountBirthDate(UpdateAccountBirthDateRequest request);
  Future<bool> updateAccountDisplayName(UpdateAccountDisplayNameRequest request);
  Future<bool> updateAccountUsername(UpdateAccountUsernameRequest request);
}

class AccountImplApi extends AccountApi {
  final Dio dio;
  final String controllerName = 'Account';
  CancelToken cancelToken = CancelToken();

  AccountImplApi(this.dio);

  @override
  Future<MyImageGroupResponse?> customUpdateAccountAvatar(CustomUpdateAccountAvatarRequest request) async {
    final fullUrl = controllerName + '/custom-update-account-avatar';
    try {
      FormData formData = FormData.fromMap({
        'avatar': await MultipartFile.fromFile(request.avatar.path, filename: request.avatar.path.split('/').last),
      });
      var res = await dio.put(fullUrl, data: formData);
      return MyImageGroupResponse.fromJson(res.data);
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
        print(e.response?.requestOptions);
        String? msg = e.response?.data['Message'];

        if (msg != null) {
          Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 1, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0);
        }
        return null;
      } else {
        print(e);
        return null;
      }
    }
  }

  @override
  Future<MyImageGroupResponse?> presetUpdateAccountAvatar(PresetUpdateAccountAvatarRequest request) async {
    final fullUrl = controllerName + '/preset-update-account-avatar';
    try {
      var res = await dio.put(fullUrl, data: request.toJson());
      return MyImageGroupResponse.fromJson(res.data);
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
        print(e.response?.requestOptions);
        String? msg = e.response?.data['Message'];

        if (msg != null) {
          Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 1, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0);
        }
        return null;
      } else {
        print(e);
        return null;
      }
    }
  }

  @override
  Future<PublicFullAccountResponse?> publicGetFullAccount(String id) async {
    final fullUrl = controllerName + '/public-full-account/'+id;
    try {
      var res = await dio.get(fullUrl);
      return PublicFullAccountResponse.fromJson(res.data);
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
        print(e.response?.requestOptions);
        String? msg = e.response?.data['Message'];

        if (msg != null) {
          Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 1, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0);
        }
        return null;
      } else {
        print(e);
        return null;
      }
    }
  }

  @override
  Future<bool> updateAccountBirthDate(UpdateAccountBirthDateRequest request) async {
    final fullUrl = controllerName + '/update-account-birth-date';
    try {
      await dio.put(fullUrl, data: request.toJson());
      return true;
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
        print(e.response?.requestOptions);
        String? msg = e.response?.data['Message'];

        if (msg != null) {
          Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 1, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0);
        }
        return false;
      } else {
        print(e);
        return false;
      }
    }
  }

  @override
  Future<bool> updateAccountDisplayName(UpdateAccountDisplayNameRequest request) async {
    final fullUrl = controllerName + '/update-account-display-name';
    try {
      await dio.put(fullUrl, data: request.toJson());
      return true;
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
        print(e.response?.requestOptions);
        String? msg = e.response?.data['Message'];

        if (msg != null) {
          Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 1, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0);
        }
        return false;
      } else {
        print(e);
        return false;
      }
    }
  }

  @override
  Future<bool> updateAccountUsername(UpdateAccountUsernameRequest request) async {
    final fullUrl = controllerName + '/update-account-username';
    try {
      await dio.put(fullUrl, data: request.toJson());
      return true;
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
        print(e.response?.requestOptions);
        String? msg = e.response?.data['Message'];

        if (msg != null) {
          Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 1, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0);
        }
        return false;
      } else {
        print(e);
        return false;
      }
    }
  }
}
