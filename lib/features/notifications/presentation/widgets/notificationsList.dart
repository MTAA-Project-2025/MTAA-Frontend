import 'package:flutter/material.dart';
import 'package:mtaa_frontend/features/notifications/data/models/responses/notificationResponse.dart';
import 'package:mtaa_frontend/features/notifications/presentation/widgets/notificationItem.dart';

/// Displays a list of notifications.
class NotificationsList extends StatelessWidget {
  final List<NotificationResponse> notifications;

  /// Creates a [NotificationsList] with required notification data.
  const NotificationsList({
    super.key,
    required this.notifications,
  });

  /// Builds the UI with a scrollable list of notification items.
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
