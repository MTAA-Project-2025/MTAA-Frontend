import 'package:airplane_mode_checker/airplane_mode_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtaa_frontend/core/constants/menu_buttons.dart';
import 'package:mtaa_frontend/features/shared/bloc/exception_type.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_bloc.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_event.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_state.dart';
import 'package:mtaa_frontend/features/shared/data/models/global_search.dart';
import 'package:mtaa_frontend/features/shared/data/models/page_parameters.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/airmode_error_notification_section.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/customSearchInput.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/dotLoader.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/empty_data_notification_section.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/phone_bottom_drawer.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/phone_bottom_menu.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/server_error_notification_section.dart';
import 'package:mtaa_frontend/features/users/account/data/models/responses/publicBaseAccountResponse.dart';
import 'package:mtaa_frontend/features/users/account/data/repositories/account_repository.dart';
import 'package:mtaa_frontend/features/users/account/presentation/widgets/friendsList.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/data/storages/tokenStorage.dart';

/// Screen displaying a list of friends with search functionality.
class FriendsScreen extends StatefulWidget {
  final AccountRepository repository;
  final TokenStorage tokenStorage;

  /// Creates a [FriendsScreen] with required dependencies.
  const FriendsScreen({super.key, required this.repository, required this.tokenStorage});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

/// Manages the state for loading and displaying friends.
class _FriendsScreenState extends State<FriendsScreen> {
  String filterStr = "";
  List<PublicBaseAccountResponse> friends = [];
  bool isLoading = false;
  final searchController = TextEditingController();
  late final AppLifecycleListener _listener;

  /// Initializes state, sets up lifecycle listener, and loads friends.
  @override
  void initState() {
    super.initState();
    context.read<ExceptionsBloc>().add(
          SetExceptionsEvent(isException: false, exceptionType: ExceptionTypes.none, message: ''),
        );
    _listener = AppLifecycleListener(
      onResume: () async {
        if (!mounted) return;
        final status = await AirplaneModeChecker.instance.checkAirplaneMode();
        if (status == AirplaneModeStatus.off && mounted) {
          context.read<ExceptionsBloc>().add(
                SetExceptionsEvent(isException: false, exceptionType: ExceptionTypes.none, message: ''),
              );
          await loadFriends();
        }
      },
    );
    loadFriends();
  }

  /// Cleans up resources on widget disposal.
  @override
  void dispose() {
    _listener.dispose();
    searchController.dispose();
    super.dispose();
  }

  /// Loads friends from the repository based on search filter.
  Future<void> loadFriends() async {
    setState(() {
      isLoading = true;
    });
    final response = await widget.repository.getFriends(
      GlobalSearch(filterStr: filterStr, pageParameters: PageParameters()),
    );
    if (mounted) {
      setState(() {
        friends = response
            .map((account) => PublicBaseAccountResponse(
                  id: account.id,
                  avatar: account.avatar,
                  username: account.username,
                  displayName: account.displayName,
                  isFollowing: account.isFollowing,
                ))
            .toList();
        isLoading = false;
      });
    }
  }

  /// Loads filtered friends based on search query.
  Future<void> loadFilteredFriends() async {
    setState(() {
      isLoading = true;
    });
    final response = await widget.repository.getFriends(
      GlobalSearch(filterStr: filterStr, pageParameters: PageParameters()),
    );
    if (mounted) {
      setState(() {
        friends = response;
        isLoading = false;
      });
    }
  }

  /// Builds the UI with search bar, friends list, and error handling.
  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Friends',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<ExceptionsBloc, ExceptionsState>(
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CustomSearchInput(
                  controller: searchController,
                  textInputType: TextInputType.text,
                  onSearch: () {
                    filterStr = searchController.text;
                    loadFilteredFriends();
                  },
                ),
              ),
              Expanded(
                child: isLoading
                    ? const Center(child: DotLoader())
                    : Builder(
                        builder: (context) {
                          if (state.isException &&
                              state.exceptionType ==
                                  ExceptionTypes.flightMode) {
                            return AirModeErrorNotificationSectionWidget(
                              onPressed: loadFriends,
                            );
                          }

                          if (state.isException &&
                              state.exceptionType ==
                                  ExceptionTypes.serverError) {
                            return ServerErrorNotificationSectionWidget(
                              onPressed: loadFriends,
                            );
                          }
                          if (friends.isEmpty) {
                            return EmptyErrorNotificationSectionWidget(
                              onPressed: loadFriends,
                              title: 'No friends found',
                            );
                          }
                          return FriendsList(
                            friends: friends,
                            searchQuery: filterStr,
                            repository: widget.repository,
                            tokenStorage: widget.tokenStorage,
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
      drawer: isPortrait ? null : PhoneBottomDrawer(sellectedType: MenuButtons.Friends),
      bottomNavigationBar: isPortrait ? const PhoneBottomMenu(sellectedType: MenuButtons.Friends) : null,
    );
  }
}
