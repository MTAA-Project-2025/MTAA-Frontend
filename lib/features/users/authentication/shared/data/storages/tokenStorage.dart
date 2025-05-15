import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hive/hive.dart';
import 'package:mtaa_frontend/core/constants/storages/storage_boxes.dart';
import 'package:mtaa_frontend/features/notifications/data/network/notificationsService.dart';
import 'package:mtaa_frontend/features/synchronization/synchronization_service.dart';

class TokenStorage {
  static const String tokenKey = "auth_token";
  late SynchronizationService synchronizationService;
  late NotificationsService notificationsService;
  Dio? dio;
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  Future<void> initialize(SynchronizationService synchronizationService, NotificationsService notificationsService) async {
    this.synchronizationService = synchronizationService;
    this.notificationsService = notificationsService;
  }

  Future<void> saveToken(String token) async {
    var box = Hive.box(currentUserDataBox);

    await box.put(tokenKey, token);
    if(token.isEmpty) return;
    await notificationsService.startSSE(token);
    await synchronizationService.synchronize();

    await saveFirebaseToken();

    await analytics.logEvent(name: 'save_token');
  }
  Future saveFirebaseToken() async{
    if(dio == null)return;
    String? token = await FirebaseMessaging.instance.getToken();
    if(token == null)return;

    final fullUrl = 'Account/save-firebase-token';
    try {
      await dio!.post(fullUrl, data: {
        'token' : token
      });

      await analytics.logEvent(name: 'save_firebase_token');
    } catch (e) {
      print('Error saving Firebase token: $e');
    }
  }

  Future initializeDio(Dio dio) async {
    this.dio = dio;
  }

  Future<String?> getToken() async {
    var box = Hive.box(currentUserDataBox);
    return box.get(tokenKey);
  }

  Future<void> deleteToken() async {
    var box = Hive.box(currentUserDataBox);
    await box.delete(tokenKey);
    notificationsService.stopSSE();
    await analytics.logEvent(name: 'delete_token');
  }

  Future<String?> getUserId() async {
    try {
      var token = await getToken();
      if (token == null) return null;

      final parts = token.split('.');
      if (parts.length != 3) {
        return null;
      }

      final payload = utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
      final Map<String, dynamic> decodedPayload = jsonDecode(payload);

      var id = decodedPayload['Id']?.toString();
      if(id == null) return null;
      return id;
    } catch (e) {
      return null;
    }
  }
}
