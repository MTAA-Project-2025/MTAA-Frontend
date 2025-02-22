import 'package:mtaa_frontend/features/images/data/models/responses/myImageResponse.dart';

class MyImageGroupResponse {
  final String id;
  final String title;
  final List<MyImageResponse> images;

  MyImageGroupResponse({
    required this.id,
    required this.title,
    this.images = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'images': images.map((image) => image.toJson()).toList(),
    };
  }

  factory MyImageGroupResponse.fromJson(Map<String, dynamic> json) {
    return MyImageGroupResponse(
      id: json['id'],
      title: json['title'],
      images: (json['images'] as List)
          .map((image) => MyImageResponse.fromJson(image))
          .toList(),
    );
  }
}
