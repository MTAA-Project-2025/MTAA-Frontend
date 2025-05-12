import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:mtaa_frontend/core/services/internet_checker.dart';
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
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  CommentsRepositoryImpl(this.api);

  @override
  Future<UuidValue?> addComment(AddCommentRequest request) async {
    if(await InternetChecker.fullIsFlightMode()) return null;
    await analytics.logEvent(name: 'add_comment', parameters: {
      'postId': request.postId.uuid,
      'text': request.text,
    });
    return await api.addComment(request);
  }

  @override
  Future<bool> updateComment(UpdateCommentRequest request) async {
    if(await InternetChecker.fullIsFlightMode()) return false;
    await analytics.logEvent(name: 'update_comment', parameters: {
      'commentId': request.commentId.uuid,
      'text': request.text,
    });
    return await api.updateComment(request);
  }

  @override
  Future<bool> deleteComment(UuidValue id) async {
    if(await InternetChecker.fullIsFlightMode()) return false;
    await analytics.logEvent(name: 'delete_comment', parameters: {
      'commentId': id.uuid,
    });
    return await api.deleteComment(id);
  }

  @override
  Future<bool> likeComment(UuidValue id) async {
    if(await InternetChecker.fullIsFlightMode()) return false;
    await analytics.logAdImpression(adPlatform: 'like_comment', parameters: {
      'commentId': id.uuid,
    });
    return await api.likeComment(id);
  }

  @override
  Future<bool> dislikeComment(UuidValue id) async {
    if(await InternetChecker.fullIsFlightMode()) return false;
    await analytics.logAdImpression(adPlatform: 'dislike_comment', parameters: {
      'commentId': id.uuid,
    });
    return await api.dislikeComment(id);
  }

  @override
  Future<bool> setInteractionToNone(UuidValue id) async {
    if(await InternetChecker.fullIsFlightMode()) return false;
    await analytics.logAdImpression(adPlatform: 'set_interaction_to_none_comment', parameters: {
      'commentId': id.uuid,
    });
    return await api.setInteractionToNone(id);
  }

  @override
  Future<FullCommentResponse?> getCommentById(UuidValue id) async {
    if(await InternetChecker.fullIsFlightMode()) return null;
    return await api.getCommentById(id);
  }

  @override
  Future<List<FullCommentResponse>> getPostComments(UuidValue postId, PageParameters pageParameters) async {
    if(await InternetChecker.fullIsFlightMode()) return [];
    return await api.getPostComments(postId, pageParameters);
  }

  @override
  Future<List<FullCommentResponse>> getChildComments(UuidValue parentCommentId, PageParameters pageParameters) async {
    if(await InternetChecker.fullIsFlightMode()) return [];
    return await api.getChildComments(parentCommentId, pageParameters);
  }
}
