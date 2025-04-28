import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:airplane_mode_checker/airplane_mode_checker.dart';
import 'package:mtaa_frontend/core/constants/colors.dart';
import 'package:mtaa_frontend/core/constants/menu_buttons.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
import 'package:mtaa_frontend/features/notifications/data/models/responses/notificationResponse.dart';
import 'package:mtaa_frontend/features/notifications/data/models/shared/notificationType.dart';
import 'package:mtaa_frontend/features/notifications/data/repositories/notificationsRepository.dart';
import 'package:mtaa_frontend/features/notifications/presentation/widgets/notificationsList.dart';
import 'package:mtaa_frontend/features/shared/bloc/exception_type.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_bloc.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_event.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_state.dart';
import 'package:mtaa_frontend/features/shared/data/models/page_parameters.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/airmode_error_notification_section.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/dotLoader.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/empty_data_notification_section.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/phone_bottom_menu.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/server_error_notification_section.dart';

class NotificationsScreen extends StatefulWidget {
  final NotificationsRepository repository;

  const NotificationsScreen({super.key, required this.repository});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<NotificationResponse> notifications = [];
  bool isLoading = false;
  late final AppLifecycleListener _listener;

  final Map<String, NotificationType?> tabs = {
    'All': null,
    'Comments': NotificationType.WriteCommentOnPost,
    'System': NotificationType.System,
  };

  late String activeTab;

  @override
  void initState() {
    super.initState();
    activeTab = tabs.keys.first;

    if (getIt.isRegistered<BuildContext>()) {
      getIt.unregister<BuildContext>();
    }
    getIt.registerSingleton<BuildContext>(context);

    context.read<ExceptionsBloc>().add(
      SetExceptionsEvent(
        isException: false,
        exceptionType: ExceptionTypes.none,
        message: '',
      ),
    );

    _listener = AppLifecycleListener(
      onResume: () async {
        if (!mounted) return;
        final status = await AirplaneModeChecker.instance.checkAirplaneMode();
        if (status == AirplaneModeStatus.off && mounted) {
          context.read<ExceptionsBloc>().add(
            SetExceptionsEvent(
              isException: false,
              exceptionType: ExceptionTypes.none,
              message: '',
            ),
          );
          await loadNotifications();
        }
      },
    );

    loadNotifications();
  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }

  void onTabChange(String tab) {
    setState(() {
      activeTab = tab;
    });
    loadNotifications();
  }

  Widget _buildTab(String tabId) {
    final isActive = activeTab == tabId;
    return GestureDetector(
      onTap: () => onTabChange(tabId),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              tabId,
              style: TextStyle(
                color: isActive
                    ? secondary1InvincibleColor
                    : Theme.of(context).textTheme.bodyMedium!.color,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 5),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 3,
              width: 40,
              decoration: BoxDecoration(
                color: isActive ? secondary1InvincibleColor : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> loadNotifications() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await widget.repository.getNotifications(
        PageParameters(),
        tabs[activeTab],
      );

      if (mounted) {
        setState(() {
          notifications = response;
          isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        context.read<ExceptionsBloc>().add(
          SetExceptionsEvent(
            isException: true,
            exceptionType: ExceptionTypes.serverError,
            message: 'Failed to load notifications',
          ),
        );
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: tabs.keys.map(_buildTab).toList(),
          ),
          Expanded(
            child: BlocBuilder<ExceptionsBloc, ExceptionsState>(
              builder: (context, state) {
                if (isLoading) return const Center(child: DotLoader());

                if (state.isException &&
                    state.exceptionType == ExceptionTypes.flightMode) {
                  return AirModeErrorNotificationSectionWidget(
                    onPressed: loadNotifications,
                  );
                }

                if (state.isException &&
                    state.exceptionType == ExceptionTypes.serverError) {
                  return ServerErrorNotificationSectionWidget(
                    onPressed: loadNotifications,
                  );
                }

                if (notifications.isEmpty) {
                  return EmptyErrorNotificationSectionWidget(
                    onPressed: loadNotifications,
                    title: 'No notifications found',
                  );
                }

                return NotificationsList(notifications: notifications);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const PhoneBottomMenu(sellectedType: MenuButtons.Profile),
    );
  }
}
