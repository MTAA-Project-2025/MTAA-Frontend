import 'package:airplane_mode_checker/airplane_mode_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mtaa_frontend/core/constants/menu_buttons.dart';
import 'package:mtaa_frontend/core/constants/route_constants.dart';
import 'package:mtaa_frontend/core/services/internet_checker.dart';
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
import 'package:mtaa_frontend/features/shared/presentation/widgets/phone_bottom_drawer.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/phone_bottom_menu.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/server_error_notification_section.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/data/storages/tokenStorage.dart';

/// Displays a screen with recommended posts using pagination.
class PostRecommendationsScreen extends StatefulWidget {
  final PostsRepository repository;
  final TokenStorage tokenStorage;

  /// Creates a [PostRecommendationsScreen] with required dependencies.
  const PostRecommendationsScreen({super.key, required this.repository, required this.tokenStorage});

  @override
  State<PostRecommendationsScreen> createState() => _PostRecommendationsScreenState();
}

/// Manages the state for loading and displaying recommended posts.
class _PostRecommendationsScreenState extends State<PostRecommendationsScreen> {
  PaginationScrollController paginationScrollController = PaginationScrollController();
  List<FullPostResponse> posts = [];
  late final AppLifecycleListener _listener;

  /// Initializes state, registers context, and checks airplane mode.
  @override
  void initState() {
    if (getIt.isRegistered<BuildContext>()) {
      getIt.unregister<BuildContext>();
    }
    getIt.registerSingleton<BuildContext>(context);

    paginationScrollController.init(loadAction: () => loadPosts());
    super.initState();

    context.read<ExceptionsBloc>().add(SetExceptionsEvent(isException: false, exceptionType: ExceptionTypes.none, message: ''));

    Future.microtask(() async {
      if (!mounted) return;
      posts.addAll(await widget.repository.getPreviousRecommendedPosts());
      if (!mounted) return;
      final status = await InternetChecker.fullIsFlightMode();
      if (status) {
        if (!mounted) return;
        context.read<ExceptionsBloc>().add(SetExceptionsEvent(isException: true, exceptionType: ExceptionTypes.flightMode, message: 'Flight mode is enabled'));
      }
      if (posts.length < paginationScrollController.pageParameters.pageSize) {
        loadPosts();
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
  }

  /// Loads additional recommended posts for pagination.
  Future loadPosts() async {
    if (!mounted) return;
    var res = await widget.repository.getRecommendedPosts(paginationScrollController.pageParameters);
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

  /// Disposes controllers, saves recent posts, and cleans up resources.
  @override
  void dispose() {
    paginationScrollController.dispose();
    widget.repository.setPreviousRecommendedPosts(posts.reversed.take(paginationScrollController.pageParameters.pageSize).toList());
    _listener.dispose();
    super.dispose();
  }

  /// Resets and loads the first page of recommended posts.
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

  /// Builds the UI with a paginated list of recommended posts and navigation.
  @override
  Widget build(BuildContext contex) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 21, 0),
                child: IconButton(
                  icon: const Icon(Icons.search),
                  tooltip: 'Search',
                  onPressed: () {
                    GoRouter.of(context).push(globalSearchScreenRoute).then(
                      (value) {
                        if (posts.isEmpty && !paginationScrollController.isLoading) loadPosts();
                      },
                    );
                  },
                ))
          ],
        ),
        body: BlocBuilder<ExceptionsBloc, ExceptionsState>(builder: (context, state) {
          return Column(children: [
            Expanded(
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
                      tokenStorage: widget.tokenStorage,
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
                      onPressed: () {
                        loadFirst();
                      },
                      title: 'No posts found',
                    );
                  }
                  return null;
                },
              ),
            ),
          ]);
        }),
        drawer: isPortrait ? null : PhoneBottomDrawer(sellectedType: MenuButtons.Home),
        bottomNavigationBar: isPortrait ? PhoneBottomMenu(sellectedType: MenuButtons.Home) : null);
  }
}
