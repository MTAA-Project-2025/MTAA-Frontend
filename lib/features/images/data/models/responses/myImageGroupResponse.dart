import 'package:mtaa_frontend/domain/hive_data/posts/my_image_group_hive.dart';
import 'package:mtaa_frontend/features/images/data/models/responses/myImageResponse.dart';
import 'package:uuid/uuid.dart';

class MyImageGroupResponse {
  final UuidValue id;
  final String title;
  final int position;
  final List<MyImageResponse> images;

  MyImageGroupResponse({
    required this.id,
    required this.title,
    required this.position,
    this.images = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id.uuid,
      'title': title,
      'images': images.map((image) => image.toJson()).toList(),
    };
  }

  factory MyImageGroupResponse.fromJson(Map<String, dynamic> json) {
    return MyImageGroupResponse(
      id: UuidValue.fromString(json['id']),
      title: json['title'],
      images: (json['images'] as List)
          .map((image) => MyImageResponse.fromJson(image))
          .toList(),
      position: json['position'],
    );
  }

  factory MyImageGroupResponse.fromHive(MyImageGroupHive hive){
    return MyImageGroupResponse(
      id: UuidValue.fromString(hive.id),
      title: hive.title,
      position: hive.position,
      images: hive.images.map((image) => MyImageResponse.fromHive(image)).toList(),
    );
  }
}
