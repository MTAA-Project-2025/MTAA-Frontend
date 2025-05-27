import 'package:airplane_mode_checker/airplane_mode_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtaa_frontend/core/constants/menu_buttons.dart';
import 'package:mtaa_frontend/core/services/time_formating_service.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
import 'package:mtaa_frontend/features/locations/data/repositories/locations_repository.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/location_post_response.dart';
import 'package:mtaa_frontend/features/posts/data/repositories/posts_repository.dart';
import 'package:mtaa_frontend/features/posts/presentation/widgets/location_post_widget.dart';
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
import 'package:uuid/uuid.dart';

/// Displays a list of location posts for a specific cluster.
class LocationClusterPointsScreen extends StatefulWidget {
  final LocationsRepository repository;
  final UuidValue clusterId;

  /// Creates a [LocationClusterPointsScreen] with required dependencies.
  const LocationClusterPointsScreen({super.key, required this.repository, required this.clusterId});

  @override
  State<LocationClusterPointsScreen> createState() => _LocationClusterPointsScreenState();
}

/// Manages the state and pagination of location posts.
class _LocationClusterPointsScreenState extends State<LocationClusterPointsScreen> {
  PaginationScrollController paginationScrollController = PaginationScrollController();
  List<LocationPostResponse> points = [];
  late final AppLifecycleListener _listener;

  /// Initializes state, pagination, and airplane mode checking.
  @override
  void initState() {
    paginationScrollController.init(loadAction: () => loadPosts());
    super.initState();

    context.read<ExceptionsBloc>().add(SetExceptionsEvent(isException: false, exceptionType: ExceptionTypes.none, message: ''));

    Future.microtask(() async {
      if (!mounted) return;
      final status = await AirplaneModeChecker.instance.checkAirplaneMode();
      if (status == AirplaneModeStatus.on && mounted) {
        context.read<ExceptionsBloc>().add(SetExceptionsEvent(isException: true, exceptionType: ExceptionTypes.flightMode, message: 'Flight mode is enabled'));
      }
    });

    _listener = AppLifecycleListener(
      onResume: () async {
        if (!mounted) return;
        Future.microtask(() async {
          if (context.mounted && mounted) {
            final status = await AirplaneModeChecker.instance.checkAirplaneMode();
            if (status == AirplaneModeStatus.off && mounted) {
              context.read<ExceptionsBloc>().add(SetExceptionsEvent(isException: false, exceptionType: ExceptionTypes.none, message: ''));
              loadFirst();
            }
          }
        });
      },
    );

    loadFirst();
  }

  /// Loads additional location posts for pagination.
  Future loadPosts() async {
    if (!mounted) return;
    var res = await widget.repository.getClusterLocationPoints(widget.clusterId, paginationScrollController.pageParameters);
    if (!mounted) return;
    paginationScrollController.pageParameters.pageNumber++;
    if (res.length < paginationScrollController.pageParameters.pageSize) {
      if (!mounted) return false;
      setState(() {
        paginationScrollController.stopLoading = true;
      });
    }
    if (res.isNotEmpty) {
      if (!mounted) return;
      setState(() {
        points.addAll(res);
      });
    }
  }

  /// Disposes controllers and listeners to prevent memory leaks.
  @override
  void dispose() {
    paginationScrollController.dispose();
    _listener.dispose();
    super.dispose();
  }

  /// Resets and loads the first page of location posts.
  Future loadFirst() async {
    points.clear();
    paginationScrollController.dispose();
    paginationScrollController.init(loadAction: () => loadPosts());
    if (!mounted) return;
    setState(() {
      paginationScrollController.isLoading = true;
    });
    if (!mounted) return;
    await loadPosts();
    if (!mounted) return;
    setState(() {
      paginationScrollController.isLoading = false;
    });
  }

  /// Builds the UI with a paginated list of location posts.
  @override
  Widget build(BuildContext contex) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<ExceptionsBloc, ExceptionsState>(builder: (context, state) {
          return Column(children: [
            Expanded(
              child: ListView.builder(
                cacheExtent: 9999,
                itemCount: points.length + 1,
                controller: paginationScrollController.scrollController,
                itemBuilder: (context, index) {
                  if (index < points.length) {
                    return LocationPostWidget(
                      post: points[index],
                      timeFormatingService: getIt<TimeFormatingService>(),
                      postsRepository: getIt<PostsRepository>(),
                      locationsRepository: widget.repository,
                    );
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
                  if (points.isEmpty) {
                    return EmptyErrorNotificationSectionWidget(
                      onPressed: () {
                        loadFirst();
                      },
                      title: 'No locations found',
                    );
                  }
                  return null;
                },
              ),
            ),
          ]);
        }),
        bottomNavigationBar: PhoneBottomMenu(sellectedType: MenuButtons.Home));
  }
}
