import 'package:dio/dio.dart';
import 'package:mtaa_frontend/core/services/exceptions_service.dart';
import 'package:mtaa_frontend/features/images/data/models/responses/myImageGroupResponse.dart';
import 'package:mtaa_frontend/features/shared/data/models/global_search.dart';
import 'package:mtaa_frontend/features/users/account/data/models/requests/customUpdateAccountAvatarRequest.dart';
import 'package:mtaa_frontend/features/users/account/data/models/requests/follow.dart';
import 'package:mtaa_frontend/features/users/account/data/models/requests/presetUpdateAccountAvatarRequest.dart';
import 'package:mtaa_frontend/features/users/account/data/models/requests/unfollow.dart';
import 'package:mtaa_frontend/features/users/account/data/models/requests/updateAccountBirthDateRequest.dart';
import 'package:mtaa_frontend/features/users/account/data/models/requests/updateAccountDisplayNameRequest.dart';
import 'package:mtaa_frontend/features/users/account/data/models/requests/updateAccountUsernameRequest.dart';
import 'package:mtaa_frontend/features/users/account/data/models/responses/publicBaseAccountResponse.dart';
import 'package:mtaa_frontend/features/users/account/data/models/responses/publicFullAccountResponse.dart';
import 'package:mtaa_frontend/features/users/account/data/models/responses/userFullAccountResponse.dart';

abstract class AccountApi {
  Future<UserFullAccountResponse?> getFullAccount();
  Future<PublicFullAccountResponse?> getPublicFullAccount(String userId);

  Future<List<PublicBaseAccountResponse>> getFollowers(GlobalSearch request);
  Future<List<PublicBaseAccountResponse>> getFriends(GlobalSearch request);
  Future<bool> follow(Follow request);
  Future<bool> unfollow(Unfollow request);
  //get all versions

  Future<MyImageGroupResponse?> customUpdateAccountAvatar(CustomUpdateAccountAvatarRequest request);
  Future<MyImageGroupResponse?> presetUpdateAccountAvatar(PresetUpdateAccountAvatarRequest request);
  Future<bool> updateAccountBirthDate(UpdateAccountBirthDateRequest request);
  Future<bool> updateAccountDisplayName(UpdateAccountDisplayNameRequest request);
  Future<bool> updateAccountUsername(UpdateAccountUsernameRequest request);
}

class AccountApiImpl extends AccountApi {
  final Dio dio;
  final String controllerName = 'Account';
  final String userControllerName = 'Users';
  CancelToken cancelToken = CancelToken();
  final ExceptionsService exceptionsService;

  AccountApiImpl(this.dio, this.exceptionsService);

  @override
  Future<UserFullAccountResponse?> getFullAccount() async {
    final fullUrl = '$controllerName/full-account';
    try {
      var res = await dio.get(fullUrl);
      return UserFullAccountResponse.fromJson(res.data);
    } on DioException catch (e) {
      exceptionsService.httpError(e);
      return null;
    }
  }

  @override
  Future<PublicFullAccountResponse?> getPublicFullAccount(String userId) async {
    final fullUrl = '$userControllerName/public-full-account/$userId';
    try {
      var res = await dio.get(fullUrl);
      return PublicFullAccountResponse.fromJson(res.data);
    } on DioException catch (e) {
      exceptionsService.httpError(e);
      return null;
    }
  }

  @override
  Future<List<PublicBaseAccountResponse>> getFollowers(GlobalSearch request) async {
    final fullUrl = '$controllerName/get-followers';
    try {
      var res = await dio.post(fullUrl, data: request.toJson());
      List<dynamic> data = res.data;
      return data.map((item) => PublicBaseAccountResponse.fromJson(item)).toList();
    } on DioException catch (e) {
      exceptionsService.httpError(e);
      return [];
    }
  }

  @override
  Future<List<PublicBaseAccountResponse>> getFriends(GlobalSearch request) async {
    final fullUrl = '$controllerName/get-friends';
    try {
      var res = await dio.post(fullUrl, data: request.toJson());
      List<dynamic> data = res.data;
      return data.map((item) => PublicBaseAccountResponse.fromJson(item)).toList();
    } on DioException catch (e) {
      exceptionsService.httpError(e);
      return [];
    }
  }

  @override
  Future<bool> follow(Follow request) async {
    final fullUrl = '$userControllerName/follow';
    try {
      await dio.post(fullUrl, data: request.toJson());
      return true;
    } on DioException catch (e) {
      exceptionsService.httpError(e);
      return false;
    }
  }

  @override
  Future<bool> unfollow(Unfollow request) async {
    final fullUrl = '$userControllerName/unfollow';
    try {
      await dio.post(fullUrl, data: request.toJson());
      return true;
    } on DioException catch (e) {
      exceptionsService.httpError(e);
      return false;
    }
  }

  @override
  Future<MyImageGroupResponse?> customUpdateAccountAvatar(CustomUpdateAccountAvatarRequest request) async {
    final fullUrl = '$controllerName/custom-update-account-avatar';
    try {
      FormData formData = FormData.fromMap({
        'avatar': await MultipartFile.fromFile(request.avatar.path, filename: request.avatar.path.split('/').last),
      });
      var res = await dio.put(fullUrl, data: formData);
      return MyImageGroupResponse.fromJson(res.data);
    } on DioException catch (e) {
      exceptionsService.httpError(e);
      return null;
    }
  }

  @override
  Future<MyImageGroupResponse?> presetUpdateAccountAvatar(PresetUpdateAccountAvatarRequest request) async {
    final fullUrl = '$controllerName/preset-update-account-avatar';
    try {
      var res = await dio.put(fullUrl, data: request.toJson());
      return MyImageGroupResponse.fromJson(res.data);
    } on DioException catch (e) {
      exceptionsService.httpError(e);
      return null;
    }
  }

  @override
  Future<bool> updateAccountBirthDate(UpdateAccountBirthDateRequest request) async {
    final fullUrl = '$controllerName/update-account-birth-date';
    try {
      await dio.put(fullUrl, data: request.toJson());
      return true;
    } on DioException catch (e) {
      exceptionsService.httpError(e);
      return false;
    }
  }

  @override
  Future<bool> updateAccountDisplayName(UpdateAccountDisplayNameRequest request) async {
    final fullUrl = '$controllerName/update-account-display-name';
    try {
      await dio.put(fullUrl, data: request.toJson());
      return true;
    } on DioException catch (e) {
      exceptionsService.httpError(e);
      return false;
    }
  }

  @override
  Future<bool> updateAccountUsername(UpdateAccountUsernameRequest request) async {
    final fullUrl = '$controllerName/update-account-username';
    try {
      await dio.put(fullUrl, data: request.toJson());
      return true;
    } on DioException catch (e) {
      exceptionsService.httpError(e);
      return false;
    }
  }
}
