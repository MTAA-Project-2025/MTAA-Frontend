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
import 'package:mtaa_frontend/features/users/account/presentation/widgets/followersList.dart';

class FollowersScreen extends StatefulWidget {
  final AccountRepository repository;

  const FollowersScreen({super.key, required this.repository});

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
  String filterStr = "";
  List<PublicBaseAccountResponse> followers = [];
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
        message: ''
      )
    );

    _listener = AppLifecycleListener(
      onResume: () async {
        if(!mounted) return;
        final status = await AirplaneModeChecker.instance.checkAirplaneMode();
        if (status == AirplaneModeStatus.off && mounted) {
          context.read<ExceptionsBloc>().add(
            SetExceptionsEvent(
              isException: false, 
              exceptionType: ExceptionTypes.none, 
              message: ''
            )
          );
          await loadFollowers();
        }
      },
    );

    loadFollowers();
  }

  @override
  void dispose() {
    _listener.dispose();
    searchController.dispose();
    super.dispose();
  }

  Future<void> loadFollowers() async {
    setState(() {
      isLoading = true;
    });

    final response = await widget.repository.getFollowers(GlobalSearch(
    filterStr: filterStr,
    pageParameters: PageParameters()));
    
    if (mounted) {
      setState(() {
        followers = response.map((account) => PublicBaseAccountResponse(
          id: account.id,
          avatar: account.avatar,
          username: account.username,
          displayName: account.displayName,
          isFollowing: account.isFollowing)).toList();
        isLoading = false;
      });
    }
  }

  void handleSearch() {
    filterStr = searchController.text;
    loadFollowers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Followers',
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
                  onSearch: handleSearch,
                ),
              ),
              Expanded(
                child: isLoading
                    ? Center(child: DotLoader())
                    : Builder(
                        builder: (context) {
                          if (state.isException && 
                              state.exceptionType == ExceptionTypes.flightMode) {
                            return AirModeErrorNotificationSectionWidget(
                              onPressed: loadFollowers,
                            );
                          }
                          
                          if (state.isException && 
                              state.exceptionType == ExceptionTypes.serverError) {
                            return ServerErrorNotificationSectionWidget(
                              onPressed: loadFollowers,
                            );
                          }

                          if (followers.isEmpty) {
                            return EmptyErrorNotificationSectionWidget(
                              onPressed: loadFollowers,
                              title: 'No followers found',
                            );
                          }

                          return FollowersList(
                            followers: followers,
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
      bottomNavigationBar: const PhoneBottomMenu(sellectedType: MenuButtons.Friends),
    );
  }
}
