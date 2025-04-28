import 'package:mtaa_frontend/features/comments/data/models/responses/full_comment_response.dart';

class CommentController {
  void Function(FullCommentResponse comment)? addComment;

  void add(FullCommentResponse comment) {
    if (addComment != null) {
      addComment!(comment);
    }
  }

  void Function()? closeChildComments;

  void closeChildren() {
    if (closeChildComments != null) {
      closeChildComments!();
    }
  }
}