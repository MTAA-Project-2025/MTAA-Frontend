import 'package:uuid/uuid_value.dart';

class UpdateCommentRequest {
  final UuidValue commentId;
  final String text;

  UpdateCommentRequest({
    required this.commentId,
    required this.text,
  });

  Map<String, dynamic> toJson() {
    return {
      'commentId': commentId.uuid,
      'text': text,
    };
  }
}
