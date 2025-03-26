import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

class AddImageRequest {
  final File image;
  int position;

  AddImageRequest({
    required this.image,
    required this.position,
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
      'image': MultipartFile.fromFileSync(image.path, filename: image.path.split('/').last),
      'position': position,
    });
  }
}
