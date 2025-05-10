import 'dart:async';
import 'package:airplane_mode_checker/airplane_mode_checker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
import 'package:mtaa_frontend/features/shared/bloc/exception_type.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_bloc.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_event.dart' show SetExceptionsEvent;

class InternetChecker {
  static final Connectivity connectivity = Connectivity();
  static final StreamController<bool> connectionController = StreamController<bool>.broadcast();

  static Stream<bool> get connectionStream => connectionController.stream;

  static void initialize() {
    connectivity.onConnectivityChanged.listen((result) {
      bool hasConnection = false;
      for (var res in result) {
        if (res == ConnectivityResult.mobile || res == ConnectivityResult.wifi) {
          hasConnection = true;
          break;
        }
      }

      connectionController.add(hasConnection);
    });
  }

  static void dispose(){
    connectionController.close();
  }

  static Future<bool> fullIsFlightMode() async{
    final status = await AirplaneModeChecker.instance.checkAirplaneMode();
    if (status == AirplaneModeStatus.on && !await isInternetEnabled()) {
      if (getIt.isRegistered<BuildContext>()) {
        var context = getIt.get<BuildContext>();
        if(!context.mounted)return true;
        context.read<ExceptionsBloc>().add(SetExceptionsEvent(isException: true, exceptionType: ExceptionTypes.flightMode, message: 'Flight mode is enabled'));
      }
      return true;
    }
    return false;
  }

  static Future<bool> isInternetEnabled() async {
    try {
      final List<ConnectivityResult> result = await connectivity.checkConnectivity();

      for (var res in result) {
        if (res == ConnectivityResult.mobile || res == ConnectivityResult.wifi) {
          return true;
        }
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
