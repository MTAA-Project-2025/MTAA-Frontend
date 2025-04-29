import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter_client_sse/constants/sse_request_type_enum.dart';
import 'package:flutter_client_sse/flutter_client_sse.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mtaa_frontend/core/config/app_config.dart';
import 'package:mtaa_frontend/core/services/my_toast_service.dart';
import 'package:mtaa_frontend/features/notifications/data/models/responses/notificationResponse.dart' as custom;
import 'package:mtaa_frontend/features/synchronization/synchronization_service.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/data/storages/tokenStorage.dart';
import 'package:timezone/timezone.dart';
import 'package:timezone/timezone.dart' as tz;

abstract class NotificationsService {
  Future startSSE();
  void stopSSE();
  Future<int> scheduleNotification(String title, String description, DateTime time);
  Future removeNotification(int id);
}

class NotificationsServiceImpl extends NotificationsService {
  StreamSubscription<SSEModel>? _subscription;
  final MyToastService toastService;
  final SynchronizationService synchronizationService;
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  NotificationsServiceImpl(this.toastService, this.synchronizationService);

  bool isSSEStarted = false;

  @override
  Future startSSE() async {
    if (isSSEStarted) return;
    isSSEStarted = true;
    
    var token = await TokenStorage.getToken();
    _subscription = SSEClient.subscribeToSSE(
      method: SSERequestType.GET,
      url: '${AppConfig.config.baseUrl}notifications/subscribe',
      header: {'Authorization': 'Bearer $token', "Accept": "text/event-stream"},
    ).listen((event) {
      if (event.data != null) {
        try {
          switch (event.event) {
            case 'notification':
              final data = jsonDecode(event.data!);
              final notification = custom.NotificationResponse.fromJson(data);
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
  Future removeNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  @override
  Future<int> scheduleNotification(String title, String description, DateTime time) async {
    int id = generateRandomId();
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      description,
      TZDateTime.from(time, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName'),
      ),
      androidScheduleMode: AndroidScheduleMode.exact,
    );
    return id;
  }

//GPT
  final _random = Random();
  int generateRandomId() {
    return _random.nextInt(9999999);
  }

  @override
  void stopSSE() {
    _subscription?.cancel();
    _subscription = null;
    print('SSE subscription cancelled');
  }
}
