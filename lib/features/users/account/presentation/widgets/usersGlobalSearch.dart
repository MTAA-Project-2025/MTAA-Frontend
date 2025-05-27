import 'package:airplane_mode_checker/airplane_mode_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtaa_frontend/features/shared/bloc/exception_type.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_bloc.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_event.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_state.dart';
import 'package:mtaa_frontend/features/shared/data/controllers/pagination_scroll_controller.dart';
import 'package:mtaa_frontend/features/shared/data/models/global_search.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/airmode_error_notification_section.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/customSearchInput.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/dotLoader.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/server_error_notification_section.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/users_empty_data_notifications_section.dart';
import 'package:mtaa_frontend/features/users/account/data/models/responses/publicBaseAccountResponse.dart';
import 'package:mtaa_frontend/features/users/account/data/repositories/account_repository.dart';
import 'package:mtaa_frontend/features/users/account/presentation/widgets/friendItem.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/data/storages/tokenStorage.dart';

/// Widget for global search of users with pagination and error handling.
class UsersGlobalSearch extends StatefulWidget {
  final AccountRepository repository;
  final TokenStorage tokenStorage;

  /// Creates a [UsersGlobalSearch] with required dependencies.
  const UsersGlobalSearch({super.key, required this.repository, required this.tokenStorage});

  @override
  State<UsersGlobalSearch> createState() => _UsersGlobalSearchState();
}

/// Manages the state for user search, pagination, and lifecycle events.
class _UsersGlobalSearchState extends State<UsersGlobalSearch> {
  PaginationScrollController paginationScrollController = PaginationScrollController();
  List<PublicBaseAccountResponse> users = [];
  bool isLoading = false;
  final searchController = TextEditingController();
  String filterStr = '';

  /// Initializes state, sets up pagination, and checks airplane mode.
  @override
  void initState() {
    paginationScrollController.init(loadAction: () => loadUsers());
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

  /// Loads users with pagination based on search filter.
  Future<bool> loadUsers() async {
    var res = await widget.repository.getGlobalUsers(GlobalSearch(filterStr: filterStr, pageParameters: paginationScrollController.pageParameters));
    paginationScrollController.pageParameters.pageNumber++;
    if (res.length < paginationScrollController.pageParameters.pageSize) {
      if (!mounted) return false;
      setState(() {
        paginationScrollController.stopLoading = true;
      });
    }
    if (res.isNotEmpty) {
      setState(() {
        users.addAll(res);
      });
      return true;
    }
    return false;
  }

  /// Cleans up resources on widget disposal.
  @override
  void dispose() {
    paginationScrollController.dispose();
    searchController.dispose();
    super.dispose();
  }

  /// Resets and loads the first page of users.
  Future loadFirst() async {
    users.clear();
    paginationScrollController.dispose();
    paginationScrollController.init(loadAction: () => loadUsers());
    if (!mounted) return;
    setState(() {
      paginationScrollController.isLoading = true;
    });
    await loadUsers();
    if (!mounted) return;
    setState(() {
      paginationScrollController.isLoading = false;
    });
  }

  /// Builds the UI with search input, user list, and error notifications.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExceptionsBloc, ExceptionsState>(builder: (context, state) {
          return Column(children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10),
                cacheExtent: 9999,
                itemCount: users.length + 2,
                controller: paginationScrollController.scrollController,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: CustomSearchInput(
                        controller: searchController,
                        textInputType: TextInputType.text,
                        onSearch: () {
                          filterStr = searchController.text;
                          loadFirst();
                        },
                      ),
                    );
                  }
                  if (index - 1 < users.length) {
                    return FriendItem(
                      friend: users[index - 1],
                      repository: widget.repository,
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
                  if (users.isEmpty) {
                    return UsersEmptyErrorNotificationSectionWidget(
                      onPressed: null,
                      imgPath: 'assets/svgs/kitsune_mask.svg',
                      title: 'No users found',
                    );
                  }
                  return null;
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
