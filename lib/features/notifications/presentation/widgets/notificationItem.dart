import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mtaa_frontend/core/constants/route_constants.dart';
import 'package:mtaa_frontend/features/notifications/data/models/responses/notificationResponse.dart';
import 'package:mtaa_frontend/features/notifications/data/models/shared/notificationType.dart';
import 'package:mtaa_frontend/core/constants/colors.dart';

class NotificationItem extends StatelessWidget {
  final NotificationResponse notification;

  const NotificationItem({
    super.key,
    required this.notification,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final iconColor = Theme.of(context).iconTheme.color ?? lightPrimarily1Color;

    return InkWell(
      onTap: () {
        if (notification.postId != null) {
          GoRouter.of(context).push('$fullPostScreenRoute/${notification.postId}');
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _getNotificationIcon(notification.type, iconColor),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                          notification.title,
                          style: textTheme.labelSmall?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      const SizedBox(width: 4),
                      Text(
                        _getTimeAgo(notification.dataCreationTime),
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    notification.text,
                    style: textTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getNotificationIcon(NotificationType type, Color iconColor) {
    IconData iconData;

    switch (type) {
      case NotificationType.LikePost:
      case NotificationType.LikeComment:
        iconData = Icons.favorite;
        break;
      case NotificationType.WriteCommentOnPost:
      case NotificationType.WriteCommentAsAnswer:
        iconData = Icons.chat_bubble_outline;
        break;
      case NotificationType.System:
        iconData = Icons.settings;
        break;
    }

    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: lightThird1Color.withOpacity(0.3)),
      ),
      child: Icon(
        iconData,
        color: iconColor,
        size: 30,
      ),
    );
  }

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }
}
