import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:mtaa_frontend/core/constants/storages/storage_boxes.dart';
import 'package:mtaa_frontend/features/notifications/data/network/notificationsService.dart';
import 'package:mtaa_frontend/features/synchronization/synchronization_service.dart';

class TokenStorage {
  static const String tokenKey = "auth_token";
  late SynchronizationService synchronizationService;
  late NotificationsService notificationsService;

  Future<void> initialize(SynchronizationService synchronizationService, NotificationsService notificationsService) async {
    this.synchronizationService = synchronizationService;
    this.notificationsService = notificationsService;
  }

  Future<void> saveToken(String token) async {
    var box = Hive.box(currentUserDataBox);

    await box.put(tokenKey, token);
    await notificationsService.startSSE(token);
    await synchronizationService.synchronize();
  }

  Future<String?> getToken() async {
    var box = Hive.box(currentUserDataBox);
    return box.get(tokenKey);
  }

  Future<void> deleteToken() async {
    var box = Hive.box(currentUserDataBox);
    await box.delete(tokenKey);
    notificationsService.stopSSE();
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

      return decodedPayload['Id']?.toString();
    } catch (e) {
      return null;
    }
  }
}
