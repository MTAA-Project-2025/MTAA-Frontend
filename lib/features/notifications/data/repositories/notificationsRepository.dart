import 'package:mtaa_frontend/core/services/internet_checker.dart';
import 'package:mtaa_frontend/features/notifications/data/models/responses/notificationResponse.dart';
import 'package:mtaa_frontend/features/notifications/data/models/shared/notificationType.dart';
import 'package:mtaa_frontend/features/notifications/data/network/notificationsApi.dart';
import 'package:mtaa_frontend/features/shared/data/models/page_parameters.dart';

abstract class NotificationsRepository {
  Future<List<NotificationResponse>> getNotifications(PageParameters pageParameters, NotificationType? type);
}

class NotificationsRepositoryImpl extends NotificationsRepository {
  final NotificationsApi api;

  NotificationsRepositoryImpl(this.api);

  @override
  Future<List<NotificationResponse>> getNotifications(PageParameters pageParameters, NotificationType? type) async {
    if(await InternetChecker.fullIsFlightMode()) return [];
    final notifications = await api.getNotifications(pageParameters, type);
    return notifications;
  }
}