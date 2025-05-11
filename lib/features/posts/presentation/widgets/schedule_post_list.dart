import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtaa_frontend/core/services/time_formating_service.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
import 'package:mtaa_frontend/features/locations/data/repositories/locations_repository.dart';
import 'package:mtaa_frontend/features/posts/bloc/scheduled_posts_bloc.dart';
import 'package:mtaa_frontend/features/posts/bloc/scheduled_posts_state.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/schedule_post_response.dart';
import 'package:mtaa_frontend/features/posts/data/repositories/posts_repository.dart';
import 'package:mtaa_frontend/features/posts/presentation/widgets/schedule_post_card.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_bloc.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_state.dart';
import 'package:mtaa_frontend/features/shared/data/controllers/pagination_scroll_controller.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/dotLoader.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/empty_data_notification_section.dart';

class SchedulePostList extends StatefulWidget {
  final PostsRepository repository;

  const SchedulePostList({super.key, required this.repository});

  @override
  State<SchedulePostList> createState() => _SchedulePostListState();
}

class _SchedulePostListState extends State<SchedulePostList> {
  PaginationScrollController paginationScrollController = PaginationScrollController();
  List<SchedulePostResponse> posts = [];

  @override
  void initState() {
    super.initState();
    paginationScrollController.init(loadAction: () => loadPosts());

    loadFirst();
  }

  Future loadPosts() async {
    if (!mounted) return;
    var res = await widget.repository.getSavedSchedulePosts(paginationScrollController.pageParameters);
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
      return Column(
        children: [
          BlocBuilder<ScheduledPostsBloc, ScheduledPostsState>(builder: (context, state) {
            return ListView.builder(
              cacheExtent: 9999,
              itemCount: state.notSyncedPosts.length + 1,
              controller: paginationScrollController.scrollController,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                if (index < state.notSyncedPosts.length) {
                  return SchedulePostCardWidget(
                    post: state.notSyncedPosts[index],
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
                return null;
              },
            );
          }),
          ListView.builder(
            cacheExtent: 9999,
            itemCount: posts.length + 1,
            controller: paginationScrollController.scrollController,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              if (index < posts.length) {
                return SchedulePostCardWidget(
                  post: posts[index],
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
              if (posts.isEmpty) {
                return EmptyErrorNotificationSectionWidget(
                  onPressed: null,
                  title: 'No scheduled posts found',
                  imgPath: 'assets/svgs/kitsune_with_book.svg',
                  aspectRatio: 0.9078,
                );
              }
              return null;
            },
          )
        ],
      );
    });
  }
}
