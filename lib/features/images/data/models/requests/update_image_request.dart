import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

class UpdateImageRequest {
  final File? newImage;
  final String? oldImageId; 
  final int position;

  UpdateImageRequest({
    this.newImage,
    this.oldImageId,
    required this.position,
  });

  Map<String, dynamic> toJson() {
    String? base64Image;
    if(newImage!=null){
      final bytes = newImage!.readAsBytesSync();
      base64Image = base64Encode(bytes);
    }

    return {
      'image': base64Image,
      'oldImageId': oldImageId,
      'position': position,
    };
  }


  FormData toFormData() {
    return FormData.fromMap({
      'image':  newImage==null?null:MultipartFile.fromFile(newImage!.path, filename: newImage!.path.split('/').last),
      'position': position,
      'oldImageId':oldImageId,
    });
  }
}
