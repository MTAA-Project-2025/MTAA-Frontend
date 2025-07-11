import 'dart:async';

import 'package:airplane_mode_checker/airplane_mode_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:mtaa_frontend/features/shared/presentation/widgets/dotLoader.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/empty_data_notification_section.dart';

/// Displays a list of saved location posts with pagination.
class SavedLocationsPointsList extends StatefulWidget {
  final PostsRepository repository;

  /// Creates a [SavedLocationsPointsList] with required dependencies.
  const SavedLocationsPointsList({super.key, required this.repository});

  @override
  State<SavedLocationsPointsList> createState() => _SavedLocationsPointsListState();
}

/// Manages the state and pagination of saved location posts.
class _SavedLocationsPointsListState extends State<SavedLocationsPointsList> {
  PaginationScrollController paginationScrollController = PaginationScrollController();
  List<LocationPostResponse> points = [];
  late final AppLifecycleListener _listener;

  /// Initializes state, pagination, and airplane mode checking.
  @override
  void initState() {
    super.initState();
    paginationScrollController.init(loadAction: () => loadPosts());

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

  /// Loads additional saved location posts for pagination.
  Future loadPosts() async {
    if (!mounted) return;
    var res = await widget.repository.getSavedLocationPosts(paginationScrollController.pageParameters);
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

  /// Resets and loads the first page of saved location posts.
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

  /// Builds the UI with a paginated list of saved location posts.
  @override
  Widget build(BuildContext contex) {
    return BlocBuilder<ExceptionsBloc, ExceptionsState>(builder: (context, state) {
      return ListView.builder(
        cacheExtent: 9999,
        itemCount: points.length + 1,
        controller: paginationScrollController.scrollController,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          if (index < points.length) {
            return LocationPostWidget(
              post: points[index],
              timeFormatingService: getIt<TimeFormatingService>(),
              postsRepository: widget.repository,
              locationsRepository: getIt<LocationsRepository>(),
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
          if (points.isEmpty) {
            return EmptyErrorNotificationSectionWidget(
              onPressed: null,
              title: 'No saved locations found',
              imgPath: 'assets/svgs/kitsune_with_book.svg',
              aspectRatio: 0.9078,
            );
          }
          return null;
        },
      );
    });
  }
}
