import 'package:uuid/uuid_value.dart';

class AddCommentRequest {
  final UuidValue postId;
  final String text;
  final UuidValue? parentCommentId;

  AddCommentRequest({
    required this.postId,
    required this.text,
    this.parentCommentId,
  });

  Map<String, dynamic> toJson() {
    return {
      'postId': postId.uuid,
      'text': text,
      'parentCommentId': parentCommentId==null? null:parentCommentId!.uuid,
    };
  }
}
