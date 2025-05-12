import 'package:mtaa_frontend/core/services/internet_checker.dart';
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
import 'package:mtaa_frontend/features/users/account/data/network/account_api.dart';
import 'package:mtaa_frontend/features/users/account/data/storages/account_storage.dart';

abstract class AccountRepository {
  Future<UserFullAccountResponse?> getFullAccount();
  
  Future<UserFullAccountResponse?> getFullLocalAccount();
  Future setFullLocalAccount(UserFullAccountResponse account);
  
  Future<PublicFullAccountResponse?> getPublicFullAccount(String userId);

  Future<List<PublicBaseAccountResponse>> getFollowers(GlobalSearch request);
  Future<List<PublicBaseAccountResponse>> getFriends(GlobalSearch request);
  Future<List<PublicBaseAccountResponse>> getGlobalUsers(GlobalSearch request);
  Future<bool> follow(Follow request);
  Future<bool> unfollow(Unfollow request);
  
  Future<MyImageGroupResponse?> customUpdateAccountAvatar(CustomUpdateAccountAvatarRequest request);
  Future<MyImageGroupResponse?> presetUpdateAccountAvatar(PresetUpdateAccountAvatarRequest request);
  Future<bool> updateAccountBirthDate(UpdateAccountBirthDateRequest request);
  Future<bool> updateAccountDisplayName(UpdateAccountDisplayNameRequest request);
  Future<bool> updateAccountUsername(UpdateAccountUsernameRequest request);
}

class AccountRepositoryImpl extends AccountRepository {
  final AccountApi accountApi;
  final AccountStorage accountStorage;

  AccountRepositoryImpl(this.accountApi, this.accountStorage);

  @override
  Future<UserFullAccountResponse?> getFullAccount() async {
    if(await InternetChecker.fullIsFlightMode()) return null;
    return await accountApi.getFullAccount();
  }


  @override
  Future<UserFullAccountResponse?> getFullLocalAccount() async {
    return await accountStorage.getFullLocalAccount();
  }

  @override
  Future setFullLocalAccount(UserFullAccountResponse account) async {
    await accountStorage.setFullLocalAccount(account);
  }

  @override
  Future<PublicFullAccountResponse?> getPublicFullAccount(String userId) async {
    if(await InternetChecker.fullIsFlightMode()) return null;
    return await accountApi.getPublicFullAccount(userId);
  }

  @override
  Future<List<PublicBaseAccountResponse>> getFollowers(GlobalSearch request) async {
    if(await InternetChecker.fullIsFlightMode()) return [];
    return await accountApi.getFollowers(request);
  }

  @override
  Future<List<PublicBaseAccountResponse>> getFriends(GlobalSearch request) async {
    if(await InternetChecker.fullIsFlightMode()) return [];
    return await accountApi.getFriends(request);
  }

  @override
  Future<List<PublicBaseAccountResponse>> getGlobalUsers(GlobalSearch request) async {
    if(await InternetChecker.fullIsFlightMode()) return [];
    return await accountApi.getGlobalUsers(request);
  }

  @override
  Future<bool> follow(Follow request) async {
    if(await InternetChecker.fullIsFlightMode()) return false;
    await accountApi.follow(request);
    return true;
  }

  @override
  Future<bool> unfollow(Unfollow request) async {
    if(await InternetChecker.fullIsFlightMode()) return false;
    await accountApi.unfollow(request);
    return true;
  }

  @override
  Future<MyImageGroupResponse?> customUpdateAccountAvatar(CustomUpdateAccountAvatarRequest request) async {
    if(await InternetChecker.fullIsFlightMode()) return null;
    return await accountApi.customUpdateAccountAvatar(request);
  }

  @override
  Future<MyImageGroupResponse?> presetUpdateAccountAvatar(PresetUpdateAccountAvatarRequest request) async {
    if(await InternetChecker.fullIsFlightMode()) return null;
    return await accountApi.presetUpdateAccountAvatar(request);
  }

  @override
  Future<bool> updateAccountBirthDate(UpdateAccountBirthDateRequest request) async {
    if(await InternetChecker.fullIsFlightMode()) return false;
    return await accountApi.updateAccountBirthDate(request);
  }

  @override
  Future<bool> updateAccountDisplayName(UpdateAccountDisplayNameRequest request) async {
    if(await InternetChecker.fullIsFlightMode()) return false;
    return await accountApi.updateAccountDisplayName(request);
  }

  @override
  Future<bool> updateAccountUsername(UpdateAccountUsernameRequest request) async {
    if(await InternetChecker.fullIsFlightMode()) return false;
    return await accountApi.updateAccountUsername(request);
  }
}
