import 'dart:async';
import 'package:flutter_client_sse/constants/sse_request_type_enum.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:mtaa_frontend/core/config/app_config.dart';
import 'package:mtaa_frontend/core/services/my_toast_service.dart';
import 'package:mtaa_frontend/features/synchronization/synchronization_service.dart';

abstract class NotificationsService {
  Future startSSE(String token);
  void stopSSE();
}

class NotificationsServiceImpl extends NotificationsService {
  StreamSubscription<SSEModel>? _subscription;
  final MyToastService toastService;
  final SynchronizationService synchronizationService;

  NotificationsServiceImpl(this.toastService, this.synchronizationService);

  bool isSSEStarted = false;

  @override
  Future startSSE(String token) async {
    if (isSSEStarted) return;
    isSSEStarted = true;

    _subscription = SSEClient.subscribeToSSE(
      method: SSERequestType.GET,
      url: '${AppConfig.config.baseUrl}notifications/subscribe',
      header: {'Authorization': 'Bearer $token', "Accept": "text/event-stream"},
    ).listen((event) {
      if (event.data != null) {
        try {
          switch (event.event) {
            case 'notification':
              //final data = jsonDecode(event.data!);
              //final lowerData = lowercaseKeys(data);
              //final notification = custom.NotificationResponse.fromJson(lowerData);
              toastService.showMsg("You have new notification!");
              break;
            case 'error':
              print('Error event received: ${event.data}');
              break;
            case 'version':
              synchronizationService.synchronize();
              break;
            default:
              print('Unknown event type: ${event.event}');
          }
        } catch (e) {
          print('Failed to decode SSE data: $e');
        }
      }
    }, onError: (error) {
      print('SSE error: $error');

      Future.delayed(const Duration(seconds: 5), () {
        print('Reconnecting to SSE...');
        startSSE(token);
      });
    });
  }

  //GPT
  Map<String, dynamic> lowercaseKeys(Map<String, dynamic> input) {
    final result = <String, dynamic>{};

    input.forEach((key, value) {
      final lowercaseKey = key.substring(0, 1).toLowerCase() + key.substring(1);
      if (value is Map<String, dynamic>) {
        result[lowercaseKey] = lowercaseKeys(value);
      } else {
        result[lowercaseKey] = value;
      }
    });

    return result;
  }

  @override
  void stopSSE() {
    _subscription?.cancel();
    _subscription = null;
    isSSEStarted=false;
    print('SSE subscription cancelled');
  }
}
