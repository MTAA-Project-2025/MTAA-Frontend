import 'dart:async';

import 'package:airplane_mode_checker/airplane_mode_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtaa_frontend/core/services/my_toast_service.dart';
import 'package:mtaa_frontend/core/services/time_formating_service.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
import 'package:mtaa_frontend/features/locations/data/repositories/locations_repository.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/full_post_response.dart';
import 'package:mtaa_frontend/features/posts/data/repositories/posts_repository.dart';
import 'package:mtaa_frontend/features/posts/presentation/widgets/full_post_widget.dart';
import 'package:mtaa_frontend/features/shared/bloc/exception_type.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_bloc.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_event.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_state.dart';
import 'package:mtaa_frontend/features/shared/data/controllers/pagination_scroll_controller.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/airmode_error_notification_section.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/dotLoader.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/empty_data_notification_section.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/server_error_notification_section.dart';

class LikedPostsList extends StatefulWidget {
  final PostsRepository repository;

  const LikedPostsList({super.key, required this.repository});

  @override
  State<LikedPostsList> createState() => _LikedPostsListState();
}

class _LikedPostsListState extends State<LikedPostsList> {
  PaginationScrollController paginationScrollController = PaginationScrollController();
  List<FullPostResponse> posts = [];
  late final AppLifecycleListener _listener;

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

  Future loadPosts() async {
    if (!mounted) return;
    var res = await widget.repository.getLikedPosts(paginationScrollController.pageParameters);
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
        posts.addAll(res);
      });
    }
  }

  @override
  void dispose() {
    paginationScrollController.dispose();
    _listener.dispose();

    super.dispose();
  }

  Future loadFirst() async {
    posts.clear();
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

  @override
  Widget build(BuildContext contex) {
    return BlocBuilder<ExceptionsBloc, ExceptionsState>(builder: (context, state) {
      return Expanded(
        child: ListView.builder(
          cacheExtent: 9999,
          itemCount: posts.length + 1,
          controller: paginationScrollController.scrollController,
          itemBuilder: (context, index) {
            if (index < posts.length) {
              return FullPostWidget(
                post: posts[index],
                timeFormatingService: getIt<TimeFormatingService>(),
                isFull: false,
                repository: widget.repository,
                locationsRepository: getIt<LocationsRepository>(),
                toaster: getIt<MyToastService>(),
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
            if (posts.isEmpty) {
              return EmptyErrorNotificationSectionWidget(
                onPressed: null,
                title: 'No liked posts found',
                imgPath: 'assets/svgs/kitsune_with_book.svg',
                aspectRatio: 0.9078,
              );
            }
            return null;
          },
        ),
      );
    });
  }
}
