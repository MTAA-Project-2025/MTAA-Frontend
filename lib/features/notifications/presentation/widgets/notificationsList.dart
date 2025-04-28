import 'package:flutter/material.dart';
import 'package:mtaa_frontend/features/notifications/data/models/responses/notificationResponse.dart';
import 'package:mtaa_frontend/features/notifications/presentation/widgets/notificationItem.dart';

class NotificationsList extends StatelessWidget {
  final List<NotificationResponse> notifications;

  const NotificationsList({
    super.key,
    required this.notifications,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return NotificationItem(notification: notification);
      },
    );
  }
}