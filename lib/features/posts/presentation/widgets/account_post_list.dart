import 'package:airplane_mode_checker/airplane_mode_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
import 'package:mtaa_frontend/features/posts/data/models/responses/simple_post_response.dart';
import 'package:mtaa_frontend/features/posts/data/repositories/posts_repository.dart';
import 'package:mtaa_frontend/features/shared/bloc/exception_type.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_bloc.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_event.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_state.dart';
import 'package:mtaa_frontend/features/shared/data/controllers/pagination_scroll_controller.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/airmode_error_notification_section.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/dotLoader.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/empty_data_notification_section.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/server_error_notification_section.dart';

class AccountPostListWidget extends StatefulWidget {
  final PostsRepository repository;
  final String userId;

  const AccountPostListWidget({super.key, required this.repository, required this.userId});

  @override
  State<AccountPostListWidget> createState() => _AccountPostListWidgetState();
}

class _AccountPostListWidgetState extends State<AccountPostListWidget> {
  PaginationScrollController paginationScrollController = PaginationScrollController();
  List<SimplePostResponse> posts = [];
  late final AppLifecycleListener _listener;

  @override
  void initState() {
    if (getIt.isRegistered<BuildContext>()) {
      getIt.unregister<BuildContext>();
    }
    getIt.registerSingleton<BuildContext>(context);

    paginationScrollController.init(loadAction: () => loadPosts());
    super.initState();

    context.read<ExceptionsBloc>().add(SetExceptionsEvent(isException: false, exceptionType: ExceptionTypes.none, message: ''));

    /*Future.microtask(() async {
      if (!mounted) return;
      posts.addAll(await widget.repository.getPreviousRecommendedPosts());
      if (!mounted) return;
      final status = await AirplaneModeChecker.instance.checkAirplaneMode();
      if (status == AirplaneModeStatus.on && mounted) {
        context.read<ExceptionsBloc>().add(SetExceptionsEvent(isException: true, exceptionType: ExceptionTypes.flightMode, message: 'Flight mode is enabled'));
      }
    });*/

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
    var res = await widget.repository.getAccountPosts(widget.userId, paginationScrollController.pageParameters);
    if (res.length < paginationScrollController.pageParameters.pageSize) {
      paginationScrollController.stopLoading = true;
    }
    if (res.isNotEmpty) {
      setState(() {
        posts.addAll(res);
      });
    }
  }

  @override
  void dispose() {
    paginationScrollController.dispose();
    //widget.repository.setPreviousRecommendedPosts(posts.reversed.take(paginationScrollController.pageParameters.pageSize).toList());
    _listener.dispose();

    super.dispose();
  }

  Future loadFirst() async {
    posts.clear();
    paginationScrollController.dispose();
    paginationScrollController.init(loadAction: () => loadPosts());

    setState(() {
      paginationScrollController.isLoading = true;
    });
    await loadPosts();
    setState(() {
      paginationScrollController.isLoading = false;
    });
  }

  @override
  Widget build(BuildContext contex) {
    return BlocBuilder<ExceptionsBloc, ExceptionsState>(builder: (context, state) {
      return Column(
        children: [
          GridView.count(
            crossAxisCount: 2,
            children: List.generate(posts.length, (index) {
              return GestureDetector(
                onTap:() {
                  context.pushNamed('fullPostScreenRoute/${posts[index].id}',);
                },
                child: Image(image: NetworkImage(posts[index].smallFirstImage.fullPath))
              );
            }),
          ),
          if (paginationScrollController.isLoading)
            Column(
              children: [
                const SizedBox(height: 20),
                DotLoader(),
              ],
            ),
          if (state.isException && state.exceptionType == ExceptionTypes.flightMode)
            AirModeErrorNotificationSectionWidget(
              onPressed: () {
                loadFirst();
              },
            ),
          if (state.isException && state.exceptionType == ExceptionTypes.serverError)
            ServerErrorNotificationSectionWidget(
              onPressed: () {
                loadFirst();
              },
            ),
          if (posts.isEmpty)
            EmptyErrorNotificationSectionWidget(
              onPressed: () {
                loadFirst();
              },
              title: 'No posts found',
            ),
        ],
      );
    });
  }
}
