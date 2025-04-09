import 'package:mtaa_frontend/features/images/data/models/responses/myImageResponse.dart';
import 'package:uuid/uuid.dart';

class SimplePostResponse {
  final UuidValue id;
  final MyImageResponse smallFirstImage;
  final DateTime dataCreationTime;

  bool isLocal;

  SimplePostResponse({
    required this.id,
    required this.smallFirstImage,
    required this.dataCreationTime,
    this.isLocal = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id.uuid,
      'smallFirstImage': smallFirstImage.toJson(),
      'dataCreationTime': dataCreationTime.toIso8601String(),
    };
  }

  factory SimplePostResponse.fromJson(Map<String, dynamic> json) {
    return SimplePostResponse(
      id: UuidValue.fromString(json['id']),
      smallFirstImage: MyImageResponse.fromJson(json['smallFirstImage']),
      dataCreationTime: DateTime.parse(json['dataCreationTime']),
    );
  }
}
