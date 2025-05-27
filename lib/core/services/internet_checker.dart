import 'dart:async';
import 'package:airplane_mode_checker/airplane_mode_checker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
import 'package:mtaa_frontend/features/shared/bloc/exception_type.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_bloc.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_event.dart' show SetExceptionsEvent;

//+-GPT + Doc + myself
/// Manages internet connectivity and airplane mode checks.
class InternetChecker {
  /// Connectivity instance for checking network status.
  static final Connectivity connectivity = Connectivity();
  /// Broadcasts internet connection status changes.
  static final StreamController<bool> connectionController = StreamController<bool>.broadcast();

  /// Stream of internet connection status.
  static Stream<bool> get connectionStream => connectionController.stream;

  /// Initializes connectivity monitoring.
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

  /// Closes the connection stream.
  static void dispose(){
    connectionController.close();
  }

  /// Checks if airplane mode is on and internet is disabled.
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

  /// Checks if internet is available via mobile or Wi-Fi.
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
