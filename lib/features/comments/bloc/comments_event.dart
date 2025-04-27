import 'package:mtaa_frontend/features/comments/data/models/responses/full_comment_response.dart';

abstract class CommentsEvent {}

class ClearCommentsEvent extends CommentsEvent {}

class AddMultipleCommentsEvent extends CommentsEvent {
  final List<FullCommentResponse> comments;

  AddMultipleCommentsEvent({required this.comments});
}

class RemoveCommentEvent extends CommentsEvent {
  final FullCommentResponse comment;

  RemoveCommentEvent({required this.comment});
}

class AddNextCommentEvent extends CommentsEvent {
  final FullCommentResponse comment;
  final FullCommentResponse commentToPlace;

  AddNextCommentEvent({required this.comment, required this.commentToPlace});
}

class RemoveNextCommentsEvent extends CommentsEvent {
  final FullCommentResponse comment;

  RemoveNextCommentsEvent({required this.comment});
}

class AddFirstCommentEvent extends CommentsEvent {
  final FullCommentResponse comment;

  AddFirstCommentEvent({required this.comment});
}