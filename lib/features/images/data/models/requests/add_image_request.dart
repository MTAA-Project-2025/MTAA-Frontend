import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mtaa_frontend/features/images/domain/utils/cropAspectRatioPresetCustom.dart';

class AddImageRequest {
  final File image;
  int position;
  bool isAspectRatioError;
  CropAspectRatioPresetCustom? aspectRatioPreset=CropAspectRatioPresetCustom(1, 1, '1x1');

  AddImageRequest({
    required this.image,
    required this.position,
    this.aspectRatioPreset,
    this.isAspectRatioError=false,
  });

  Map<String, dynamic> toJson() {
    final bytes = image.readAsBytesSync();
    final base64Image = base64Encode(bytes);

    return {
      'image': base64Image,
      'position': position,
    };
  }

  FormData toFormData() {
    return FormData.fromMap({
      'image':  MultipartFile.fromFile(image.path, filename: image.path.split('/').last),
      'position': position,
    });
  }
}
