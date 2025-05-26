import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:airplane_mode_checker/airplane_mode_checker.dart';
import 'package:mtaa_frontend/core/constants/colors.dart';
import 'package:mtaa_frontend/core/constants/menu_buttons.dart';
import 'package:mtaa_frontend/features/notifications/data/models/responses/notificationResponse.dart';
import 'package:mtaa_frontend/features/notifications/data/models/shared/notificationType.dart';
import 'package:mtaa_frontend/features/notifications/data/repositories/notificationsRepository.dart';
import 'package:mtaa_frontend/features/notifications/presentation/widgets/notificationItem.dart';
import 'package:mtaa_frontend/features/shared/bloc/exception_type.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_bloc.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_event.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_state.dart';
import 'package:mtaa_frontend/features/shared/data/controllers/pagination_scroll_controller.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/airmode_error_notification_section.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/dotLoader.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/empty_data_notification_section.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/phone_bottom_menu.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/server_error_notification_section.dart';

/// Displays a screen for viewing notifications with tabbed filtering.
class NotificationsScreen extends StatefulWidget {
  final NotificationsRepository repository;

  /// Creates a [NotificationsScreen] with required dependencies.
  const NotificationsScreen({super.key, required this.repository});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

/// Manages the state, pagination, and tabbed navigation for notifications.
class _NotificationsScreenState extends State<NotificationsScreen> {
  List<NotificationResponse> notifications = [];
  PaginationScrollController paginationScrollController = PaginationScrollController();
  bool isLoading = false;
  late final AppLifecycleListener _listener;

  final Map<String, NotificationType?> tabs = {
    'All': null,
    'Comments': NotificationType.WriteCommentOnPost,
    'System': NotificationType.System,
  };

  late String activeTab;

  /// Initializes state, pagination, and airplane mode checking.
  @override
  void initState() {
    super.initState();
    activeTab = tabs.keys.first;
    paginationScrollController.init(loadAction: () => loadNotifications());

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

  /// Resets and loads the first page of notifications.
  Future loadFirst() async {
    notifications.clear();
    paginationScrollController.dispose();
    paginationScrollController.init(loadAction: () => loadNotifications());

    if (!mounted) return;
    setState(() {
      paginationScrollController.isLoading = true;
    });
    if (!mounted) return;
    await loadNotifications();
    if (!mounted) return;
    setState(() {
      paginationScrollController.isLoading = false;
    });
  }

  /// Disposes controllers and listeners to prevent memory leaks.
  @override
  void dispose() {
    paginationScrollController.dispose();
    _listener.dispose();
    super.dispose();
  }

  /// Handles tab changes and reloads notifications.
  void onTabChange(String tab) {
    setState(() {
      activeTab = tab;
    });
    loadFirst();
  }

  /// Builds a tab widget for filtering notifications.
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
                color: isActive ? secondary1InvincibleColor : Theme.of(context).textTheme.bodyMedium!.color,
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

  /// Loads additional notifications for pagination.
  Future loadNotifications() async {
    if (!mounted) return;
    var res = await widget.repository.getNotifications(paginationScrollController.pageParameters, tabs[activeTab]);
    if (!mounted) return;
    paginationScrollController.pageParameters.pageNumber++;
    if (res.length < paginationScrollController.pageParameters.pageSize) {
      if (!mounted) return;
      setState(() {
        paginationScrollController.stopLoading = true;
      });
    }
    if (res.isNotEmpty) {
      if (!mounted) return;
      setState(() {
        notifications.addAll(res);
      });
    }
  }

  /// Builds the UI with tabbed navigation and a paginated list of notifications.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: tabs.keys.map(_buildTab).toList(),
        ),
        Expanded(child: BlocBuilder<ExceptionsBloc, ExceptionsState>(builder: (context, state) {
          return ListView.builder(
            cacheExtent: 9999,
            itemCount: notifications.length + 1,
            controller: paginationScrollController.scrollController,
            itemBuilder: (context, index) {
              if (index < notifications.length) {
                return NotificationItem(notification: notifications[index]);
              }
              if (paginationScrollController.isLoading) {
                return Column(
                  children: [
                    const SizedBox(height: 20),
                    DotLoader(),
                  ],
                );
              }
              if (state.isException && state.exceptionType == ExceptionTypes.flightMode) {
                return AirModeErrorNotificationSectionWidget(
                  onPressed: () {
                    loadFirst();
                  },
                );
              }
              if (state.isException && state.exceptionType == ExceptionTypes.serverError) {
                return ServerErrorNotificationSectionWidget(
                  onPressed: () {
                    loadFirst();
                  },
                );
              }
              if (notifications.isEmpty) {
                return EmptyErrorNotificationSectionWidget(
                  onPressed: () {
                    loadFirst();
                  },
                  title: 'No notifications found',
                );
              }
              return null;
            },
          );
        }))
      ]),
      bottomNavigationBar: const PhoneBottomMenu(sellectedType: MenuButtons.Profile),
    );
  }
}
