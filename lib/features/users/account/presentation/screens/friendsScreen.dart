import 'package:airplane_mode_checker/airplane_mode_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtaa_frontend/core/constants/menu_buttons.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
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
import 'package:mtaa_frontend/features/shared/presentation/widgets/phone_bottom_menu.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/server_error_notification_section.dart';
import 'package:mtaa_frontend/features/users/account/data/models/responses/publicBaseAccountResponse.dart';
import 'package:mtaa_frontend/features/users/account/data/repositories/account_repository.dart';
import 'package:mtaa_frontend/features/users/account/presentation/widgets/friendsList.dart';

class FriendsScreen extends StatefulWidget {
  final AccountRepository repository;

  const FriendsScreen({super.key, required this.repository});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  String filterStr = "";
  List<PublicBaseAccountResponse> friends = [];
  bool isLoading = false;
  final searchController = TextEditingController();
  late final AppLifecycleListener _listener;

  @override
  void initState() {
    super.initState();

    if (getIt.isRegistered<BuildContext>()) {
      getIt.unregister<BuildContext>();
    }
    getIt.registerSingleton<BuildContext>(context);

    context.read<ExceptionsBloc>().add(
      SetExceptionsEvent(
        isException: false,
        exceptionType: ExceptionTypes.none,
        message: '',
      ),
    );

    _listener = AppLifecycleListener(
      onResume: () async {
        if (!mounted) return;
        final status = await AirplaneModeChecker.instance.checkAirplaneMode();
        if (status == AirplaneModeStatus.off && mounted) {
          context.read<ExceptionsBloc>().add(
            SetExceptionsEvent(
              isException: false,
              exceptionType: ExceptionTypes.none,
              message: '',
            ),
          );
          await loadFriends();
        }
      },
    );

    loadFriends();
  }

  @override
  void dispose() {
    _listener.dispose();
    searchController.dispose();
    super.dispose();
  }

  Future<void> loadFriends() async {
    setState(() {
      isLoading = true;
    });

    final response = await widget.repository.getFriends(GlobalSearch(
      filterStr: filterStr,
      pageParameters: PageParameters(),
    ));

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

  Future<void> loadFilteredFriends() async {
    setState(() {
      isLoading = true;
    });

    final response = await widget.repository.getFriends(GlobalSearch(
      filterStr: filterStr,
      pageParameters: PageParameters(),
    ));

    if (mounted) {
      setState(() {
        friends = response;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Friends',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
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
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar:
          const PhoneBottomMenu(sellectedType: MenuButtons.Friends),
    );
  }
}
