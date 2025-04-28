import 'package:airplane_mode_checker/airplane_mode_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
import 'package:mtaa_frontend/domain/hive_data/add-posts/add_post_hive.dart';
import 'package:mtaa_frontend/features/locations/data/models/requests/add_location_request.dart';
import 'package:mtaa_frontend/features/posts/data/models/requests/add_post_request.dart';
import 'package:mtaa_frontend/features/posts/data/models/requests/get_global_posts_request.dart';
import 'package:mtaa_frontend/features/posts/data/models/requests/update_post_request.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/full_post_response.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/location_post_response.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/simple_post_response.dart';
import 'package:mtaa_frontend/features/posts/data/network/posts_api.dart';
import 'package:mtaa_frontend/features/posts/data/storages/posts_storage.dart';
import 'package:mtaa_frontend/features/posts/presentation/screens/add_post_screen.dart';
import 'package:mtaa_frontend/features/posts/presentation/widgets/add_post_form.dart';
import 'package:mtaa_frontend/features/shared/bloc/exception_type.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_bloc.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_event.dart';
import 'package:mtaa_frontend/features/shared/data/models/page_parameters.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/data/storages/tokenStorage.dart';
import 'package:uuid/uuid.dart';

abstract class PostsRepository {
  Future<UuidValue?> addPost(AddPostRequest request);
  Future<bool> updatePost(UpdatePostRequest request);
  Future<List<FullPostResponse>> getRecommendedPosts(PageParameters request);

  Future<List<FullPostResponse>> getPreviousRecommendedPosts();
  Future setPreviousRecommendedPosts(List<FullPostResponse> posts);

  Future<List<FullPostResponse>> getGlobalPosts(GetGLobalPostsRequest request);
  Future<List<FullPostResponse>> getLikedPosts(PageParameters pageParameters);
  
  Future<FullPostResponse?> getFullPostById(UuidValue id);
  Future<List<SimplePostResponse>> getAccountPosts(String userId, PageParameters pageParameters);
  Future<bool> deletePost(UuidValue id);
  Future<bool> likePost(UuidValue id);
  Future<bool> removePostLike(UuidValue id);

  Future<AddPostHive?> getTempPostAddForm();
  Future setTempPostAddForm(List<AddPostImageScreenDTO> images, List<ImageDTO> imageDTOs, String text, AddLocationRequest? addLocation);
  Future deleteTempPostAddForm();

  Future saveLocationPost(LocationPostResponse post);
  Future removeLocationPost(LocationPostResponse post);
  Future<List<LocationPostResponse>> getSavedLocationPosts(PageParameters pageParameteres);
  Future<bool> isLocationPostSaved(UuidValue postId);
}

class PostsRepositoryImpl extends PostsRepository {
  final PostsApi postsApi;
  final PostsStorage postsStorage;

  PostsRepositoryImpl(this.postsApi, this.postsStorage);

  @override
  Future<UuidValue?> addPost(AddPostRequest request) async {
    final status = await AirplaneModeChecker.instance.checkAirplaneMode();
    if (status == AirplaneModeStatus.on) {
      if (getIt.isRegistered<BuildContext>()) {
        var context = getIt.get<BuildContext>();
        if (context.mounted) {
          context.read<ExceptionsBloc>().add(SetExceptionsEvent(isException: true, exceptionType: ExceptionTypes.flightMode, message: 'Flight mode is enabled'));
        }
        return null;
      }
    }
    return await postsApi.addPost(request);
  }

  @override
  Future<bool> updatePost(UpdatePostRequest request) async {
    final status = await AirplaneModeChecker.instance.checkAirplaneMode();
    if (status == AirplaneModeStatus.on) {
      if (getIt.isRegistered<BuildContext>()) {
        var context = getIt.get<BuildContext>();
        if (context.mounted) {
          context.read<ExceptionsBloc>().add(SetExceptionsEvent(isException: true, exceptionType: ExceptionTypes.flightMode, message: 'Flight mode is enabled'));
        }
        return false;
      }
    }
    return await postsApi.updatePost(request);
  }

  @override
  Future<List<FullPostResponse>> getRecommendedPosts(PageParameters request) async {
    final status = await AirplaneModeChecker.instance.checkAirplaneMode();
    if (status == AirplaneModeStatus.on) {
      if (getIt.isRegistered<BuildContext>()) {
        var context = getIt.get<BuildContext>();
        context.read<ExceptionsBloc>().add(SetExceptionsEvent(isException: true, exceptionType: ExceptionTypes.flightMode, message: 'Flight mode is enabled'));
        return [];
      }
    }
    return await postsApi.getRecommendedPosts(request);
  }

  @override
  Future<List<FullPostResponse>> getPreviousRecommendedPosts() async {
    return await postsStorage.getRecommended();
  }

  @override
  Future setPreviousRecommendedPosts(List<FullPostResponse> posts) async {
    await postsStorage.setRecommended(posts);
  }

  @override
  Future<List<FullPostResponse>> getGlobalPosts(GetGLobalPostsRequest request) async {
    final status = await AirplaneModeChecker.instance.checkAirplaneMode();
    if (status == AirplaneModeStatus.on) {
      if (getIt.isRegistered<BuildContext>()) {
        var context = getIt.get<BuildContext>();
        context.read<ExceptionsBloc>().add(SetExceptionsEvent(isException: true, exceptionType: ExceptionTypes.flightMode, message: 'Flight mode is enabled'));
        return [];
      }
    }
    return await postsApi.getGlobalPosts(request);
  }

  @override
  Future<List<FullPostResponse>> getLikedPosts(PageParameters pageParameters) async {
    final status = await AirplaneModeChecker.instance.checkAirplaneMode();
    if (status == AirplaneModeStatus.on) {
      if (getIt.isRegistered<BuildContext>()) {
        var context = getIt.get<BuildContext>();
        context.read<ExceptionsBloc>().add(SetExceptionsEvent(isException: true, exceptionType: ExceptionTypes.flightMode, message: 'Flight mode is enabled'));
        return [];
      }
    }
    return await postsApi.getLiked(pageParameters);
  }

  @override
  Future<FullPostResponse?> getFullPostById(UuidValue id) async {
    final status = await AirplaneModeChecker.instance.checkAirplaneMode();
    if (status == AirplaneModeStatus.on) {
      if (getIt.isRegistered<BuildContext>()) {
        var context = getIt.get<BuildContext>();
        context.read<ExceptionsBloc>().add(SetExceptionsEvent(isException: true, exceptionType: ExceptionTypes.flightMode, message: 'Flight mode is enabled'));
        return null;
      }
    }
    return await postsApi.getFullPostById(id);
  }

  @override
  Future<List<SimplePostResponse>> getAccountPosts(String userId, PageParameters pageParameters) async {
    final status = await AirplaneModeChecker.instance.checkAirplaneMode();
    if (status == AirplaneModeStatus.on) {
      if (getIt.isRegistered<BuildContext>()) {
        var context = getIt.get<BuildContext>();
        context.read<ExceptionsBloc>().add(SetExceptionsEvent(isException: true, exceptionType: ExceptionTypes.flightMode, message: 'Flight mode is enabled'));
        return [];
      }
    }
    if(userId==await TokenStorage.getUserId()) {
      return await postsStorage.getAccountPosts(pageParameters);
    }
    
    return await postsApi.getAccountPosts(userId, pageParameters);
  }

  @override
  Future<bool> deletePost(UuidValue id) async {
    final status = await AirplaneModeChecker.instance.checkAirplaneMode();
    if (status == AirplaneModeStatus.on) {
      if (getIt.isRegistered<BuildContext>()) {
        var context = getIt.get<BuildContext>();
        if (context.mounted) {
          context.read<ExceptionsBloc>().add(SetExceptionsEvent(isException: true, exceptionType: ExceptionTypes.flightMode, message: 'Flight mode is enabled'));
        }
        return false;
      }
    }
    var res = await postsApi.deletePost(id);
    if (res) {
      //Todo: implement deleting of local posts
      return true;
    }
    return false;
  }

  @override
  Future<bool> likePost(UuidValue id) async {
    return await postsApi.likePost(id);
  }

  @override
  Future<bool> removePostLike(UuidValue id) async {
    return await postsApi.removePostLike(id);
  }

  @override
  Future<AddPostHive?> getTempPostAddForm() async {
    return await postsStorage.getTempPostAddForm();
  }

  @override
  Future setTempPostAddForm(List<AddPostImageScreenDTO> images, List<ImageDTO> imageDTOs, String text, AddLocationRequest? addLocation) async {
    return await postsStorage.setTempPostAddForm(images, imageDTOs, text, addLocation);
  }

  @override
  Future deleteTempPostAddForm() async {
    return await postsStorage.deleteTempPostAddForm();
  }

  @override
  Future saveLocationPost(LocationPostResponse post) async {
    await postsStorage.saveLocationPost(post);
  }

  @override
  Future removeLocationPost(LocationPostResponse post) async {
    return await postsStorage.removeLocationPost(post);
  }

  @override
  Future<List<LocationPostResponse>> getSavedLocationPosts(PageParameters pageParameteres) async {
    return await postsStorage.getSavedLocationPosts(pageParameteres);
  }

  @override
  Future<bool> isLocationPostSaved(UuidValue postId) async {
    return await postsStorage.isLocationPostSaved(postId);
  }
}
