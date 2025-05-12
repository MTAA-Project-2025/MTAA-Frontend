import 'package:airplane_mode_checker/airplane_mode_checker.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtaa_frontend/core/services/my_toast_service.dart';
import 'package:mtaa_frontend/core/services/time_formating_service.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
import 'package:mtaa_frontend/features/locations/data/repositories/locations_repository.dart';
import 'package:mtaa_frontend/features/posts/data/models/requests/get_global_posts_request.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/full_post_response.dart';
import 'package:mtaa_frontend/features/posts/data/repositories/posts_repository.dart';
import 'package:mtaa_frontend/features/posts/presentation/widgets/full_post_widget.dart';
import 'package:mtaa_frontend/features/shared/bloc/exception_type.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_bloc.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_event.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_state.dart';
import 'package:mtaa_frontend/features/shared/data/controllers/pagination_scroll_controller.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/airmode_error_notification_section.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/customSearchInput.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/dotLoader.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/empty_data_notification_section.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/server_error_notification_section.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/data/storages/tokenStorage.dart';

class PostsGlobalSearchScreen extends StatefulWidget {
  final PostsRepository repository;
  final TokenStorage tokenStorage;

  const PostsGlobalSearchScreen({super.key, required this.repository, required this.tokenStorage});

  @override
  State<PostsGlobalSearchScreen> createState() => _PostsGlobalSearchScreenState();
}

class _PostsGlobalSearchScreenState extends State<PostsGlobalSearchScreen> {
  PaginationScrollController paginationScrollController = PaginationScrollController();
  List<FullPostResponse> posts = [];
  bool isLoading = false;
  final searchController = TextEditingController();
  String filterStr = '';
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  void initState() {
    paginationScrollController.init(loadAction: () => loadPosts());
    super.initState();

    context.read<ExceptionsBloc>().add(SetExceptionsEvent(isException: false, exceptionType: ExceptionTypes.none, message: ''));

    Future.microtask(() async {
      if (!context.mounted || !mounted) return;
      final status = await AirplaneModeChecker.instance.checkAirplaneMode();
      if (status == AirplaneModeStatus.on) {
        context.read<ExceptionsBloc>().add(SetExceptionsEvent(isException: true, exceptionType: ExceptionTypes.flightMode, message: 'Flight mode is enabled'));
      }
    });

    AppLifecycleListener(
      onResume: () async {
        Future.microtask(() async {
          if (mounted && context.mounted) {
            final status = await AirplaneModeChecker.instance.checkAirplaneMode();
            if (status == AirplaneModeStatus.off) {
              if (mounted && context.mounted) {
                context.read<ExceptionsBloc>().add(SetExceptionsEvent(isException: false, exceptionType: ExceptionTypes.none, message: ''));
              }
              loadFirst();
            }
          }
        });
      },
    );

    loadFirst();
  }

  Future<bool> loadPosts() async {
    var res = await widget.repository.getGlobalPosts(GetGLobalPostsRequest(filterStr: filterStr, pageParameters: paginationScrollController.pageParameters));
    paginationScrollController.pageParameters.pageNumber++;
    if (res.length < paginationScrollController.pageParameters.pageSize) {
      if (!mounted) return false;
      setState(() {
        paginationScrollController.stopLoading = true;
      });
    }
    if (res.isNotEmpty) {
      if (!mounted) return false;
      setState(() {
        posts.addAll(res);
      });
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    paginationScrollController.dispose();
    searchController.dispose();
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
    await loadPosts();
    if (!mounted) return;
    setState(() {
      paginationScrollController.isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExceptionsBloc, ExceptionsState>(builder: (context, state) {
          return Column(children: [
            Expanded(
              child: ListView.builder(
                cacheExtent: 9999,
                itemCount: posts.length + 2,
                controller: paginationScrollController.scrollController,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: CustomSearchInput(
                        controller: searchController,
                        textInputType: TextInputType.text,
                        onSearch: () {
                          analytics.logSearch(searchTerm: searchController.text);
                          filterStr = searchController.text;
                          loadFirst();
                        },
                      ),
                    );
                  }
                  if (index - 1 < posts.length) {
                    return FullPostWidget(
                      post: posts[index - 1],
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
                        const SizedBox(height: 20),
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
        });
  }
}
