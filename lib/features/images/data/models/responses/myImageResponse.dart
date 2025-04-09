import 'package:mtaa_frontend/core/constants/images/image_size_type.dart';
import 'package:mtaa_frontend/domain/hive_data/posts/my_image_hive.dart';

class MyImageResponse {
  final String id;
  final String shortPath;
  final String fullPath;
  String localPath;
  final String fileType;
  final int height;
  final int width;
  final double aspectRatio;
  final ImageSizeType type;

  MyImageResponse({
    required this.id,
    required this.shortPath,
    required this.fullPath,
    required this.fileType,
    required this.height,
    required this.width,
    required this.aspectRatio,
    required this.type,
    this.localPath=''
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shortPath': shortPath,
      'fullPath': fullPath,
      'fileType': fileType,
      'height': height,
      'width': width,
      'aspectRatio': aspectRatio,
      'type': type
    };
  }

  factory MyImageResponse.fromJson(Map<String, dynamic> json) {
    return MyImageResponse(
      id: json['id'],
      shortPath: json['shortPath'],
      fullPath: json['fullPath'],
      fileType: json['fileType'],
      height: json['height'],
      width: json['width'],
      aspectRatio:(json['aspectRatio'] as num).toDouble(),
      type: ImageSizeType.values[json['type']]
    );
  }

  
  factory MyImageResponse.fromHive(MyImageHive hive){
    return MyImageResponse(
      id: hive.id,
      shortPath: hive.shortPath,
      fullPath: hive.fullPath,
      fileType: hive.fileType,
      height: hive.height,
      width: hive.width,
      aspectRatio: hive.aspectRatio,
      type: ImageSizeType.values[hive.type],
      localPath: hive.localPath
    );
  }
}