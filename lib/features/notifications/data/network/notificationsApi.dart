import 'package:dio/dio.dart';
import 'package:mtaa_frontend/core/services/exceptions_service.dart';
import 'package:mtaa_frontend/features/notifications/data/models/responses/notificationResponse.dart';
import 'package:mtaa_frontend/features/notifications/data/models/shared/notificationType.dart';
import 'package:mtaa_frontend/features/shared/data/models/page_parameters.dart';

abstract class NotificationsApi {
  Future<List<NotificationResponse>> getNotifications(PageParameters pageParameters, NotificationType? type);
}

class NotificationsApiImpl extends NotificationsApi {
  final Dio dio;
  final String controllerName = 'Notifications';
  final ExceptionsService exceptionsService;
  CancelToken cancelToken = CancelToken();

  NotificationsApiImpl(this.dio, this.exceptionsService);

  @override
  Future<List<NotificationResponse>> getNotifications(PageParameters pageParameters, NotificationType? type) async {
    final String typeParam = type != null ? '/${_getNotificationTypeString(type)}' : '';
    final fullUrl = '$controllerName/get-notifications$typeParam';
    
    try {
      var res = await dio.post(fullUrl, data: pageParameters.toJson());
      List<dynamic> data = res.data;
      return data.map((item) => NotificationResponse.fromJson(item)).toList();
    } on DioException catch (e) {
      exceptionsService.httpError(e);
      return [];
    }
  }

  String _getNotificationTypeString(NotificationType type) {
    return type.toString().split('.').last;
  }
}