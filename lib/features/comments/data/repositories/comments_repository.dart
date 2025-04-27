import 'package:mtaa_frontend/features/comments/data/models/requests/add_comment_request.dart';
import 'package:mtaa_frontend/features/comments/data/models/requests/update_comment_request.dart';
import 'package:mtaa_frontend/features/comments/data/models/responses/full_comment_response.dart';
import 'package:mtaa_frontend/features/comments/data/networks/comments_api.dart';
import 'package:mtaa_frontend/features/shared/data/models/page_parameters.dart';
import 'package:uuid/uuid.dart';

abstract class CommentsRepository {
  Future<UuidValue?> addComment(AddCommentRequest request);
  Future<bool> updateComment(UpdateCommentRequest request);
  Future<bool> deleteComment(UuidValue id);

  Future<List<FullCommentResponse>> getPostComments(UuidValue postId, PageParameters pageParameters);
  Future<List<FullCommentResponse>> getChildComments(UuidValue parentCommentId, PageParameters pageParameters);
  Future<FullCommentResponse?> getCommentById(UuidValue id);

  Future<bool> likeComment(UuidValue id);
  Future<bool> dislikeComment(UuidValue id);
  Future<bool> setInteractionToNone(UuidValue id);
}

class CommentsRepositoryImpl extends CommentsRepository {
  final CommentsApi api;
  CommentsRepositoryImpl(this.api);

  @override
  Future<UuidValue?> addComment(AddCommentRequest request) async {
    return await api.addComment(request);
  }

  @override
  Future<bool> updateComment(UpdateCommentRequest request) async {
    return await api.updateComment(request);
  }

  @override
  Future<bool> deleteComment(UuidValue id) async {
    return await api.deleteComment(id);
  }

  @override
  Future<bool> likeComment(UuidValue id) async {
    return await api.likeComment(id);
  }

  @override
  Future<bool> dislikeComment(UuidValue id) async {
    return await api.dislikeComment(id);
  }

  @override
  Future<bool> setInteractionToNone(UuidValue id) async {
    return await api.setInteractionToNone(id);
  }

  @override
  Future<FullCommentResponse?> getCommentById(UuidValue id) async {
    return await api.getCommentById(id);
  }

  @override
  Future<List<FullCommentResponse>> getPostComments(UuidValue postId, PageParameters pageParameters) async {
    return await api.getPostComments(postId, pageParameters);
  }

  @override
  Future<List<FullCommentResponse>> getChildComments(UuidValue parentCommentId, PageParameters pageParameters) async {
    return await api.getChildComments(parentCommentId, pageParameters);
  }
}
