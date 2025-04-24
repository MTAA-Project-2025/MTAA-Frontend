import 'package:mtaa_frontend/features/images/data/models/responses/myImageResponse.dart';
import 'package:mtaa_frontend/features/notifications/data/models/shared/notificationType.dart';
import 'package:uuid/uuid_value.dart';

class NotificationResponse {
  final UuidValue id;
  final String title;
  final String text;
  final MyImageResponse? image;
  final DateTime dataCreationTime;
  final UuidValue? postId;
  final UuidValue? commentId;
  final String userId;
  final NotificationType type;

  NotificationResponse({
    required this.id,
    required this.title,
    required this.text,
    this.image,
    required this.dataCreationTime,
    this.postId,
    this.commentId,
    required this.userId,
    required this.type,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      id: UuidValue.fromString(json['id']),
      title: json['title'],
      text: json['text'],
      image: json['image'] != null ? MyImageResponse.fromJson(json['image']) : null,
      dataCreationTime: DateTime.parse(json['dataCreationTime']),
      postId: json['postId'] != null ? UuidValue.fromString(json['postId']) : null,
      commentId: json['commentId'] != null ? UuidValue.fromString(json['commentId']) : null,
      userId: json['userId'],
      type: NotificationType.values[json['type']],
    );
  }
}