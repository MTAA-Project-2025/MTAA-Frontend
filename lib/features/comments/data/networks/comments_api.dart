import 'package:dio/dio.dart';
import 'package:mtaa_frontend/core/services/exceptions_service.dart';
import 'package:mtaa_frontend/features/comments/data/models/requests/add_comment_request.dart';
import 'package:mtaa_frontend/features/comments/data/models/requests/update_comment_request.dart';
import 'package:mtaa_frontend/features/comments/data/models/responses/full_comment_response.dart';
import 'package:mtaa_frontend/features/shared/data/models/page_parameters.dart';
import 'package:uuid/uuid.dart';

abstract class CommentsApi {
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

class CommentsApiImpl extends CommentsApi {
  final Dio dio;
  final String controllerName = 'Comments';
  final ExceptionsService exceptionsService;
  CancelToken cancelToken = CancelToken();

  CommentsApiImpl(this.dio, this.exceptionsService);

  @override
  Future<UuidValue?> addComment(AddCommentRequest request) async {
    final fullUrl = '$controllerName/add';
    try {
      var res = await dio.post(fullUrl, data: request.toJson());
      return UuidValue.fromString(res.data);
    } on DioException catch (e) {
      exceptionsService.httpError(e);
      return null;
    }
  }

  @override
  Future<bool> updateComment(UpdateCommentRequest request) async {
    final fullUrl = '$controllerName/edit';
    try {
      await dio.put(fullUrl, data: request.toJson());
      return true;
    } on DioException catch (e) {
      exceptionsService.httpError(e);
      return false;
    }
  }

  @override
  Future<bool> deleteComment(UuidValue id) async {
    final fullUrl = '$controllerName/delete/${id.uuid}';
    try {
      await dio.delete(fullUrl);
      return true;
    } on DioException catch (e) {
      exceptionsService.httpError(e);
      return false;
    }
  }

  @override
  Future<bool> likeComment(UuidValue id) async {
    final fullUrl = '$controllerName/like/${id.uuid}';
    try {
      await dio.post(fullUrl);
      return true;
    } on DioException catch (e) {
      exceptionsService.httpError(e);
      return false;
    }
  }

  @override
  Future<bool> dislikeComment(UuidValue id) async {
    final fullUrl = '$controllerName/dislike/${id.uuid}';
    try {
      await dio.post(fullUrl);
      return true;
    } on DioException catch (e) {
      exceptionsService.httpError(e);
      return false;
    }
  }

  @override
  Future<bool> setInteractionToNone(UuidValue id) async {
    final fullUrl = '$controllerName/set-interaction-to-none/${id.uuid}';
    try {
      await dio.post(fullUrl);
      return true;
    } on DioException catch (e) {
      exceptionsService.httpError(e);
      return false;
    }
  }

  @override
  Future<List<FullCommentResponse>> getPostComments(UuidValue postId, PageParameters pageParameters) async {
    final fullUrl = '$controllerName/get-from-post/${postId.uuid}';
    try {
      var res = await dio.post(fullUrl, data: pageParameters.toJson());
      List<dynamic> data = res.data;
      return data.map((item) => FullCommentResponse.fromJson(item)).toList();
    } on DioException catch (e) {
      exceptionsService.httpError(e);
      return [];
    }
  }

  @override
  Future<FullCommentResponse?> getCommentById(UuidValue id) async {
    final fullUrl = '$controllerName/get-by-id/${id.uuid}';
    try {
      var res = await dio.get(fullUrl);
      return FullCommentResponse.fromJson(res.data);
    } on DioException catch (e) {
      exceptionsService.httpError(e);
      return null;
    }
  }

  @override
  Future<List<FullCommentResponse>> getChildComments(UuidValue parentCommentId, PageParameters pageParameters) async {
    final fullUrl = '$controllerName/get-from-children/${parentCommentId.uuid}';
    try {
      var res = await dio.post(fullUrl, data: pageParameters.toJson());
      List<dynamic> data = res.data;
      return data.map((item) => FullCommentResponse.fromJson(item)).toList();
    } on DioException catch (e) {
      exceptionsService.httpError(e);
      return [];
    }
  }
}
