import 'package:airplane_mode_checker/airplane_mode_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
import 'package:mtaa_frontend/features/images/data/models/responses/myImageGroupResponse.dart';
import 'package:mtaa_frontend/features/shared/bloc/exception_type.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_bloc.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_event.dart';
import 'package:mtaa_frontend/features/shared/data/models/global_search.dart';
import 'package:mtaa_frontend/features/users/account/data/models/requests/customUpdateAccountAvatarRequest.dart';
import 'package:mtaa_frontend/features/users/account/data/models/requests/presetUpdateAccountAvatarRequest.dart';
import 'package:mtaa_frontend/features/users/account/data/models/requests/updateAccountBirthDateRequest.dart';
import 'package:mtaa_frontend/features/users/account/data/models/requests/updateAccountDisplayNameRequest.dart';
import 'package:mtaa_frontend/features/users/account/data/models/requests/updateAccountUsernameRequest.dart';
import 'package:mtaa_frontend/features/users/account/data/models/responses/publicBaseAccountResponse.dart';
import 'package:mtaa_frontend/features/users/account/data/models/responses/userFullAccountResponse.dart';
import 'package:mtaa_frontend/features/users/account/data/network/account_api.dart';

abstract class AccountRepository {
  Future<UserFullAccountResponse?> getFullAccount();

  Future<List<PublicBaseAccountResponse>> getFollowers(GlobalSearch request);
  Future<List<PublicBaseAccountResponse>> getFriends(GlobalSearch request);
  
  Future<MyImageGroupResponse?> customUpdateAccountAvatar(CustomUpdateAccountAvatarRequest request);
  Future<MyImageGroupResponse?> presetUpdateAccountAvatar(PresetUpdateAccountAvatarRequest request);
  Future<bool> updateAccountBirthDate(UpdateAccountBirthDateRequest request);
  Future<bool> updateAccountDisplayName(UpdateAccountDisplayNameRequest request);
  Future<bool> updateAccountUsername(UpdateAccountUsernameRequest request);
}

class AccountRepositoryImpl extends AccountRepository {
  final AccountApi accountApi;

  AccountRepositoryImpl(this.accountApi);

  @override
  Future<UserFullAccountResponse?> getFullAccount() async {
    final status = await AirplaneModeChecker.instance.checkAirplaneMode();
    if (status == AirplaneModeStatus.on) {
      if (getIt.isRegistered<BuildContext>()) {
        var context = getIt.get<BuildContext>();
        if(context.mounted){
          context.read<ExceptionsBloc>().add(SetExceptionsEvent(isException: true, exceptionType: ExceptionTypes.flightMode, message: 'Flight mode is enabled'));
        }
        return null;
      }
    }
    return await accountApi.getFullAccount();
  }

  @override
  Future<List<PublicBaseAccountResponse>> getFollowers(GlobalSearch request) async {
    final status = await AirplaneModeChecker.instance.checkAirplaneMode();
    if (status == AirplaneModeStatus.on) {
      if (getIt.isRegistered<BuildContext>()) {
        var context = getIt.get<BuildContext>();
        if(context.mounted){
          context.read<ExceptionsBloc>().add(SetExceptionsEvent(isException: true, exceptionType: ExceptionTypes.flightMode, message: 'Flight mode is enabled'));
        }
        return [];
      }
    }
    return await accountApi.getFollowers(request);
  }

  @override
  Future<List<PublicBaseAccountResponse>> getFriends(GlobalSearch request) async {
    final status = await AirplaneModeChecker.instance.checkAirplaneMode();
    if (status == AirplaneModeStatus.on) {
      if (getIt.isRegistered<BuildContext>()) {
        var context = getIt.get<BuildContext>();
        if(context.mounted){
          context.read<ExceptionsBloc>().add(SetExceptionsEvent(isException: true, exceptionType: ExceptionTypes.flightMode, message: 'Flight mode is enabled'));
        }
        return [];
      }
    }
    return await accountApi.getFriends(request);
  }

  @override
  Future<MyImageGroupResponse?> customUpdateAccountAvatar(CustomUpdateAccountAvatarRequest request) async {
    final status = await AirplaneModeChecker.instance.checkAirplaneMode();
    if (status == AirplaneModeStatus.on) {
      if (getIt.isRegistered<BuildContext>()) {
        var context = getIt.get<BuildContext>();
        if(context.mounted){
          context.read<ExceptionsBloc>().add(SetExceptionsEvent(isException: true, exceptionType: ExceptionTypes.flightMode, message: 'Flight mode is enabled'));
        }
        return null;
      }
    }
    return await accountApi.customUpdateAccountAvatar(request);
  }

  @override
  Future<MyImageGroupResponse?> presetUpdateAccountAvatar(PresetUpdateAccountAvatarRequest request) async {
    final status = await AirplaneModeChecker.instance.checkAirplaneMode();
    if (status == AirplaneModeStatus.on) {
      if (getIt.isRegistered<BuildContext>()) {
        var context = getIt.get<BuildContext>();
        if(context.mounted){
          context.read<ExceptionsBloc>().add(SetExceptionsEvent(isException: true, exceptionType: ExceptionTypes.flightMode, message: 'Flight mode is enabled'));
        }
        return null;
      }
    }
    return await accountApi.presetUpdateAccountAvatar(request);
  }

  @override
  Future<bool> updateAccountBirthDate(UpdateAccountBirthDateRequest request) async {
    final status = await AirplaneModeChecker.instance.checkAirplaneMode();
    if (status == AirplaneModeStatus.on) {
      if (getIt.isRegistered<BuildContext>()) {
        var context = getIt.get<BuildContext>();
        if(context.mounted){
          context.read<ExceptionsBloc>().add(SetExceptionsEvent(isException: true, exceptionType: ExceptionTypes.flightMode, message: 'Flight mode is enabled'));
        }
        return false;
      }
    }
    return await accountApi.updateAccountBirthDate(request);
  }

  @override
  Future<bool> updateAccountDisplayName(UpdateAccountDisplayNameRequest request) async {
    final status = await AirplaneModeChecker.instance.checkAirplaneMode();
    if (status == AirplaneModeStatus.on) {
      if (getIt.isRegistered<BuildContext>()) {
        var context = getIt.get<BuildContext>();
        if(context.mounted){
          context.read<ExceptionsBloc>().add(SetExceptionsEvent(isException: true, exceptionType: ExceptionTypes.flightMode, message: 'Flight mode is enabled'));
        }
        return false;
      }
    }
    return await accountApi.updateAccountDisplayName(request);
  }

  @override
  Future<bool> updateAccountUsername(UpdateAccountUsernameRequest request) async {
    final status = await AirplaneModeChecker.instance.checkAirplaneMode();
    if (status == AirplaneModeStatus.on) {
      if (getIt.isRegistered<BuildContext>()) {
        var context = getIt.get<BuildContext>();
        if(context.mounted){
          context.read<ExceptionsBloc>().add(SetExceptionsEvent(isException: true, exceptionType: ExceptionTypes.flightMode, message: 'Flight mode is enabled'));
        }
        return false;
      }
    }
    return await accountApi.updateAccountUsername(request);
  }
}
