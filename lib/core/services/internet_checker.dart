import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

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
