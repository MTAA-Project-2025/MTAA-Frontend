import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:mtaa_frontend/core/services/exceptions_service.dart';
import 'package:mtaa_frontend/features/posts/data/models/requests/add_post_request.dart';
import 'package:mtaa_frontend/features/posts/data/models/requests/get_global_posts_request.dart';
import 'package:mtaa_frontend/features/posts/data/models/requests/update_post_request.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/full_post_response.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/schedule_post_response.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/simple_post_response.dart';
import 'package:mtaa_frontend/features/shared/data/models/page_parameters.dart';
import 'package:mtaa_frontend/features/synchronization/data/version_post_item_response.dart';
import 'package:uuid/uuid.dart';

abstract class PostsApi {
  Future<UuidValue?> addPost(AddPostRequest request);
  Future<bool> updatePost(UpdatePostRequest request);
  Future<List<FullPostResponse>> getRecommendedPosts(PageParameters request);
  Future<List<FullPostResponse>> getGlobalPosts(GetGLobalPostsRequest request);
  Future<List<FullPostResponse>> getLiked(PageParameters request);
  Future<FullPostResponse?> getFullPostById(UuidValue id);
  Future<List<SimplePostResponse>> getAccountPosts(String userId, PageParameters pageParameters);
  Future<bool> deletePost(UuidValue id);
  Future<bool> likePost(UuidValue id);
  Future<bool> removePostLike(UuidValue id);

  Future<List<VersionPostItemResponse>> getVersionPostItems(PageParameters pageParameters);

  Future<List<SchedulePostResponse>> getSchedulePosts(PageParameters pageParameters);
  Future<SchedulePostResponse?> getSchedulePostById(UuidValue id);
}

class PostsApiImpl extends PostsApi {
  final Dio dio;
  final String controllerName = 'Posts';
  final ExceptionsService exceptionsService;
  CancelToken cancelToken = CancelToken();
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  PostsApiImpl(this.dio, this.exceptionsService);

  @override
  Future<UuidValue?> addPost(AddPostRequest request) async {
    final fullUrl = '$controllerName/add';
    try {
      var res = await dio.post(fullUrl,data: request.toFormData());

      var id = UuidValue.fromString(res.data);

      await analytics.logEvent(name: 'add_post', parameters: {
        'postId': id.uuid,
      });
      return id;
    } on DioException catch (e) {
      exceptionsService.httpError(e);
      return null;
    }
  }

  @override
  Future<bool> updatePost(UpdatePostRequest request) async {
    final fullUrl = '$controllerName/update';
    try {
      await dio.put(fullUrl,data: request.toFormData());

      await analytics.logEvent(name: 'update_post');
      return true;
    } on DioException catch (e) {
      exceptionsService.httpError(e);
      return false;
    }
  }

  @override
  Future<List<FullPostResponse>> getRecommendedPosts(PageParameters request) async {
    final fullUrl = '$controllerName/get-recommendations';
    try {
      var res = await dio.post(fullUrl,data: request.toJson());
      List<dynamic> data = res.data;
      return data.map((item) => FullPostResponse.fromJson(item)).toList();
    } on DioException catch (e) {
      exceptionsService.httpError(e);
      return [];
    }
  }

  @override
  Future<List<FullPostResponse>> getGlobalPosts(GetGLobalPostsRequest request) async {
    final fullUrl = '$controllerName/get-global';
    try {
      var res = await dio.post(fullUrl,data: request.toJson());
      List<dynamic> data = res.data;
      return data.map((item) => FullPostResponse.fromJson(item)).toList();
    } on DioException catch (e) {
      exceptionsService.httpError(e);
      return [];
    }
  }

  @override
  Future<List<FullPostResponse>> getLiked(PageParameters request) async {
    final fullUrl = '$controllerName/get-liked';
    try {
      var res = await dio.post(fullUrl,data: request.toJson());
      List<dynamic> data = res.data;
      return data.map((item) => FullPostResponse.fromJson(item)).toList();
    } on DioException catch (e) {
      exceptionsService.httpError(e);
      return [];
    }
  }

  @override
  Future<FullPostResponse?> getFullPostById(UuidValue id) async {
    final fullUrl = '$controllerName/get-by-id/${id.uuid}';
    try {
      var res = await dio.get(fullUrl);
      return FullPostResponse.fromJson(res.data);
    } on DioException catch (e) {
      exceptionsService.httpError(e);
      return null;
    }
  }

  @override
  Future<List<SimplePostResponse>> getAccountPosts(String userId, PageParameters pageParameters) async {
    final fullUrl = '$controllerName/get-from-account/$userId';
    try {
      var res = await dio.post(fullUrl,data:pageParameters.toJson());
      List<dynamic> data = res.data;
      return data.map((item) => SimplePostResponse.fromJson(item)).toList();
    } on DioException catch (e) {
      exceptionsService.httpError(e);
      return [];
    }
  }

  @override
  Future<List<SchedulePostResponse>> getSchedulePosts(PageParameters pageParameters) async {
    final fullUrl = '$controllerName/get-scheduled-posts';
    try {
      var res = await dio.post(fullUrl,data:pageParameters.toJson());
      List<dynamic> data = res.data;
      return data.map((item) => SchedulePostResponse.fromJson(item)).toList();
    } on DioException catch (e) {
      exceptionsService.httpError(e);
      return [];
    }
  }

  @override
  Future<SchedulePostResponse?> getSchedulePostById(UuidValue id) async{
    final fullUrl = '$controllerName/get-scheduled-post/${id.uuid}';
    try {
      var res = await dio.get(fullUrl);
      return SchedulePostResponse.fromJson(res.data);
    } on DioException catch (e) {
      exceptionsService.httpError(e);
      return null;
    }
  }

  @override
  Future<List<VersionPostItemResponse>> getVersionPostItems(PageParameters pageParameters) async{
    final fullUrl = '$controllerName/get-post-version-items';
    try {
      var res = await dio.post(fullUrl,data:pageParameters.toJson());
      List<dynamic> data = res.data;
      return data.map((item) => VersionPostItemResponse.fromJson(item)).toList();
    } on DioException catch (e) {
      exceptionsService.httpError(e);
      return [];
    }
  }

  @override
  Future<bool> deletePost(UuidValue id) async {
    final fullUrl = '$controllerName/${id.uuid}';
    try {
      await dio.delete(fullUrl);

      await analytics.logEvent(name: 'delete_post', parameters: {
        'postId': id.uuid,
      });
      return true;
    } on DioException catch (e) {
      exceptionsService.httpError(e);
      return false;
    }
  }

  @override
  Future<bool> likePost(UuidValue id) async {
    final fullUrl = '$controllerName/add-like/${id.uuid}';
    try {
      await dio.post(fullUrl);

      await analytics.logEvent(name: 'like_post', parameters: {
        'postId': id.uuid,
      });
      return true;
    } on DioException catch (e) {
      exceptionsService.httpError(e);
      return false;
    }
  }

  @override
  Future<bool> removePostLike(UuidValue id) async {
    final fullUrl = '$controllerName/remove-like/${id.uuid}';
    try {
      await dio.delete(fullUrl);

      await analytics.logEvent(name: 'like_post', parameters: {
        'postId': id.uuid,
      });
      return true;
    } on DioException catch (e) {
      exceptionsService.httpError(e);
      return false;
    }
  }
}
