import 'dart:async';
import 'dart:convert';
import 'package:flutter_client_sse/constants/sse_request_type_enum.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:mtaa_frontend/core/config/app_config.dart';
import 'package:mtaa_frontend/core/services/my_toast_service.dart';
import 'package:mtaa_frontend/features/notifications/data/models/responses/notificationResponse.dart';
import 'package:mtaa_frontend/features/synchronization/synchronization_service.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/data/storages/tokenStorage.dart';

abstract class NotificationsService {
  Future startSSE();
  void stopSSE();
}

class NotificationsServiceImpl extends NotificationsService {
  StreamSubscription<SSEModel>? _subscription;
  final MyToastService toastService;
  final SynchronizationService synchronizationService;

  NotificationsServiceImpl(this.toastService,
      this.synchronizationService);

  @override
  Future startSSE() async{
    var token = await TokenStorage.getToken();
    _subscription = SSEClient.subscribeToSSE(
      method: SSERequestType.GET,
      url: '${AppConfig.config.baseUrl}notifications/subscribe',
      header: {
        'Authorization': 'Bearer $token',
        "Accept": "text/event-stream"
      },
    ).listen((event) {
      if (event.data != null) {
        try {
          switch (event.event) {
            case 'notification':
                final data = jsonDecode(event.data!);
                final notification = NotificationResponse.fromJson(data);
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
        startSSE();
      });
    });
  }

  @override
  void stopSSE() {
    _subscription?.cancel();
    _subscription = null;
    print('SSE subscription cancelled');
  }
}
