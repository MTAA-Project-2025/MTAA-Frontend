import 'package:mtaa_frontend/features/comments/data/models/responses/comment_interaction_type.dart';
import 'package:mtaa_frontend/features/users/account/data/models/responses/publicBaseAccountResponse.dart';
import 'package:uuid/uuid.dart';

class FullCommentResponse {
  final UuidValue id;
  String text;
  final PublicBaseAccountResponse owner;
  int likesCount;
  int dislikesCount;
  final DateTime dataCreationTime;

  final UuidValue? parentCommentId;
  int childCommentsCount;
  bool isEdited;
  bool isMovedToTop=false;

  CommentInteractionType type;
  
  FullCommentResponse({required this.id,
  required this.text,
  required this.owner,
  required this.likesCount,
  required this.dislikesCount,
  required this.dataCreationTime,
  required this.parentCommentId,
  required this.childCommentsCount,
  required this.isEdited,
  required this.type});

  factory FullCommentResponse.fromJson(Map<String, dynamic> json) {
    return FullCommentResponse(
      id: UuidValue.fromString(json['id']),
      text: json['text'],
      owner: PublicBaseAccountResponse.fromJson(json['owner']),
      likesCount: json['likesCount'],
      dislikesCount: json['dislikesCount'],
      dataCreationTime: DateTime.parse(json['dataCreationTime']),
      parentCommentId: json['parentCommentId'] == null ? null : UuidValue.fromString(json['parentCommentId']),
      childCommentsCount: json['childCommentsCount'],
      isEdited: json['isEdited'],
      type: CommentInteractionType.values[json['type']],
    );
  }
}
