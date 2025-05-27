import 'dart:io';

import 'package:airplane_mode_checker/airplane_mode_checker.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mtaa_frontend/core/constants/colors.dart';
import 'package:mtaa_frontend/core/constants/route_constants.dart';
import 'package:mtaa_frontend/features/images/data/models/responses/myImageResponse.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/simple_post_response.dart';
import 'package:mtaa_frontend/features/posts/data/repositories/posts_repository.dart';
import 'package:mtaa_frontend/features/shared/bloc/exception_type.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_bloc.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_event.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_state.dart';
import 'package:mtaa_frontend/features/shared/data/controllers/pagination_scroll_controller.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/airmode_error_notification_section.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/dotLoader.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/server_error_notification_section.dart';

/// Displays a grid of posts for a user's account.
class AccountPostListWidget extends StatefulWidget {
  final PostsRepository repository;
  final String userId;
  final bool isOwner;

  /// Creates an [AccountPostListWidget] with required dependencies and user context.
  const AccountPostListWidget({super.key, required this.repository, required this.userId, required this.isOwner});

  @override
  State<AccountPostListWidget> createState() => _AccountPostListWidgetState();
}

/// Manages the state for loading and displaying account posts with pagination.
class _AccountPostListWidgetState extends State<AccountPostListWidget> {
  PaginationScrollController paginationScrollController = PaginationScrollController();
  List<SimplePostResponse> posts = [];
  late final AppLifecycleListener _listener;

  /// Initializes state, sets up pagination, and checks airplane mode.
  @override
  void initState() {
    paginationScrollController.init(loadAction: () => loadPosts());
    super.initState();

    context.read<ExceptionsBloc>().add(SetExceptionsEvent(isException: false, exceptionType: ExceptionTypes.none, message: ''));

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

  /// Loads additional posts for the account using pagination.
  Future loadPosts() async {
    var res = await widget.repository.getAccountPosts(widget.userId, paginationScrollController.pageParameters);
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

  /// Disposes controllers and cleans up resources.
  @override
  void dispose() {
    paginationScrollController.dispose();
    _listener.dispose();
    super.dispose();
  }

  /// Resets and loads the first page of account posts.
  Future loadFirst() async {
    posts.clear();
    paginationScrollController.dispose();
    paginationScrollController.init(loadAction: () => loadPosts());
    if (!mounted) return;
    setState(() {
      paginationScrollController.isLoading = true;
    });
    await loadPosts();
    if (!mounted) return;
    setState(() {
      paginationScrollController.isLoading = false;
    });
  }

  /// Retrieves the appropriate image widget based on ownership and availability.
  Widget getImage(MyImageResponse img) {
    if (!widget.isOwner) {
      return CachedNetworkImage(
        imageUrl: img.fullPath,
        errorWidget: (context, url, error) => Image(image: AssetImage('assets/images/kistune_server_error.png')),
        fit: BoxFit.cover,
      );
    }
    File file = File(img.localPath);
    if (file.existsSync()) {
      return Image(image: FileImage(file));
    }
    return Image(image: AssetImage('assets/images/kistune_server_error.png'));
  }

  /// Builds the UI with a grid of posts and optional add post button for owners.
  @override
  Widget build(BuildContext contex) {
    return BlocBuilder<ExceptionsBloc, ExceptionsState>(builder: (context, state) {
      return CustomScrollView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        controller: paginationScrollController.scrollController,
        slivers: [
          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              childCount: posts.length + (widget.isOwner ? 1 : 0),
              (context, index) {
                if (widget.isOwner && index == 0) {
                  return AspectRatio(
                      aspectRatio: 1,
                      child: GestureDetector(
                          onTap: () {
                            GoRouter.of(context).push(addPostScreenRoute);
                          },
                          child: IconButton(
                            onPressed: () {
                              GoRouter.of(context).push(addPostScreenRoute);
                            },
                            style: IconButton.styleFrom(
                              backgroundColor: Theme.of(context).secondaryHeaderColor.withAlpha(25),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            icon: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: secondary1InvincibleColor,
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Icon(Icons.add_rounded, color: whiteColor, size: 36),
                            ),
                          )));
                }
                return GestureDetector(
                  onTap: () {
                    GoRouter.of(context).push('$fullPostScreenRoute/${posts[index - (widget.isOwner ? 1 : 0)].id}');
                  },
                  child: getImage(posts[index - (widget.isOwner ? 1 : 0)].smallFirstImage),
                );
              },
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
            ),
          ),
          if (paginationScrollController.isLoading)
            SliverToBoxAdapter(
                child: Column(
              children: [
                const SizedBox(height: 20),
                DotLoader(),
              ],
            )),
          if (!paginationScrollController.isLoading && state.isException && state.exceptionType == ExceptionTypes.flightMode)
            SliverToBoxAdapter(child: AirModeErrorNotificationSectionWidget(
              onPressed: () {
                loadFirst();
              },
            )),
          if (!paginationScrollController.isLoading && state.isException && state.exceptionType == ExceptionTypes.serverError)
            SliverToBoxAdapter(child: ServerErrorNotificationSectionWidget(
              onPressed: () {
                loadFirst();
              },
            )),
          if (!paginationScrollController.isLoading && !state.isException && posts.isEmpty)
            SliverToBoxAdapter(
              child: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Center(child: Text('No posts found', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).textTheme.bodySmall?.color)))),
            )
        ],
      );
    });
  }
}
