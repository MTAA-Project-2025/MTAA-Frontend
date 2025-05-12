import 'dart:core';
import 'dart:io';

import 'package:mtaa_frontend/features/images/data/models/responses/myImageResponse.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/simple_post_response.dart';
import 'package:uuid/uuid.dart';

class SchedulePostResponse extends SimplePostResponse{
  final bool isHidden;
  final DateTime? schedulePublishDate;
  final String? hiddenReason;
  final String description;

  final int version;
  File? imageFile;

  SchedulePostResponse({
    required super.id,
    required super.smallFirstImage,
    required super.dataCreationTime,
    required this.isHidden,
    required this.schedulePublishDate,
    required this.hiddenReason,
    required this.description,
    required this.version,
    super.isLocal = false,
  });

  factory SchedulePostResponse.fromJson(Map<String, dynamic> json) {
    return SchedulePostResponse(
      id: UuidValue.fromString(json['id']),
      description: json['description'],
      smallFirstImage: MyImageResponse.fromJson(json['smallFirstImage']),
      dataCreationTime: DateTime.parse(json['dataCreationTime']),
      isHidden: json['isHidden'] ?? false,
      schedulePublishDate: json['schedulePublishDate'] != null
          ? DateTime.parse(json['schedulePublishDate'])
          : null,
      hiddenReason: json['hiddenReason'] ?? '',
      version: json['version'] ?? 0,
    );
  }
}