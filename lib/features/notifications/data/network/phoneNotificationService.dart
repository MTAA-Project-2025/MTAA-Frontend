import 'dart:async';
import 'dart:math';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart';
import 'package:timezone/timezone.dart' as tz;

abstract class PhoneNotificationsService {
  Future<int> scheduleNotification(String title, String description, DateTime time);
  Future removeNotification(int id);
}

class PhoneNotificationsServiceImpl extends PhoneNotificationsService {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  PhoneNotificationsServiceImpl();

  bool isSSEStarted = false;

  @override
  Future removeNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  @override
  Future<int> scheduleNotification(String title, String description, DateTime time) async {
    int id = generateRandomId();

    if (time.isBefore(DateTime.now())) {
      return -1;
    }

    bool? granted = await requestPermissions();
    if (granted == null || !granted) {
      return -1;
    }

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      description,
      TZDateTime.from(time.toUtc(), tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName'),
      ),
      androidScheduleMode: AndroidScheduleMode.exact,
    );
    return id;
  }

  //GPT
  Future<bool?> requestPermissions() async {
    final bool? iosGranted =
        await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(alert: true, badge: true, sound: true);

    final bool? macOsGranted =
        await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<MacOSFlutterLocalNotificationsPlugin>()?.requestPermissions(alert: true, badge: false, sound: true);

    final bool? androidGranted = await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestExactAlarmsPermission();

    return iosGranted ?? macOsGranted ?? androidGranted ?? true;
  }

  //GPT
  final _random = Random();
  int generateRandomId() {
    return _random.nextInt(9999999);
  }
}
