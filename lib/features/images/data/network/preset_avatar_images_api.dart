import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mtaa_frontend/core/services/internet_checker.dart';
import 'package:mtaa_frontend/features/images/data/models/responses/myImageGroupResponse.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class PresetAvatarImagesApi {
  Future<List<MyImageGroupResponse>> getAllPresetImages();
}

class PresetAvatarImagesApiImpl extends PresetAvatarImagesApi {
  final Dio dio;
  final String controllerName = 'PresetAvatarImages';
  CancelToken cancelToken = CancelToken();

  PresetAvatarImagesApiImpl(this.dio);

  @override
  Future<List<MyImageGroupResponse>> getAllPresetImages() async {
    if(await InternetChecker.fullIsFlightMode()) return [];
    final fullUrl = '$controllerName/get-all';
    try {
      var res = await dio.get(fullUrl);
      List<dynamic> data = res.data;
      return data.map((item) => MyImageGroupResponse.fromJson(item)).toList();
    } on DioException catch (e) {
      if (e.response != null) {
        print(e.response?.data);
        print(e.response?.headers);
        print(e.response?.requestOptions);
        String? msg = e.response?.data['Message'];

        if (msg != null) {
          Fluttertoast.showToast(msg: msg, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 1, backgroundColor: Colors.red, textColor: Colors.white, fontSize: 16.0);
        }
        return List.empty();
      } else {
        print(e);
        return List.empty();
      }
    }
  }
}
