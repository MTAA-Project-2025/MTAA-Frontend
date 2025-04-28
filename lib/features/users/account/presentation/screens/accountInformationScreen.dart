import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mtaa_frontend/core/constants/menu_buttons.dart';
import 'package:mtaa_frontend/core/constants/route_constants.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
import 'package:mtaa_frontend/features/locations/presentation/widgets/saved_location_points_list.dart';
import 'package:mtaa_frontend/features/posts/data/repositories/posts_repository.dart';
import 'package:mtaa_frontend/features/posts/presentation/widgets/account_post_list.dart';
import 'package:mtaa_frontend/features/posts/presentation/widgets/liked_posts_list.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/dotLoader.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/phone_bottom_menu.dart';
import 'package:mtaa_frontend/features/users/account/bloc/account_bloc.dart';
import 'package:mtaa_frontend/features/users/account/bloc/account_events.dart';
import 'package:mtaa_frontend/features/users/account/bloc/account_state.dart';
import 'package:mtaa_frontend/features/users/account/data/repositories/account_repository.dart';
import 'package:mtaa_frontend/features/users/account/presentation/widgets/profileInfoWidget.dart';
import 'package:mtaa_frontend/features/users/account/presentation/widgets/tabNavigation.dart';

class AccountInformationScreen extends StatefulWidget {
  final AccountRepository repository;

  const AccountInformationScreen({super.key, required this.repository});

  @override
  State<AccountInformationScreen> createState() => _AccountInformationScreenState();
}

class _AccountInformationScreenState extends State<AccountInformationScreen> {
  bool isLoading = false;
  AccountTabType activeTab = AccountTabType.Posts;

  void handleTabChange(AccountTabType tabType) {
    if (!mounted) return;
    setState(() {
      activeTab = tabType;
    });
  }

  @override
  void initState() {
    super.initState();

    if (getIt.isRegistered<BuildContext>()) {
      getIt.unregister<BuildContext>();
    }
    getIt.registerSingleton<BuildContext>(context);

    final accountState = context.read<AccountBloc>().state;
    if (accountState.account == null) {
      loadAccount();
    }
  }

  Future loadAccount() async {
    if (isLoading) return;
    if (!mounted) return;
    setState(() {
      isLoading = true;
    });
    var res = await widget.repository.getFullAccount();
    if (res != null) {
      if (!mounted) return;
      if (!context.mounted) return;
      context.read<AccountBloc>().add(LoadAccountEvent(account: res));
    }
    if (!mounted) return;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(builder: (context, accountState) {
      return Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              Container(
                  margin: const EdgeInsets.fromLTRB(0, 0, 21, 0),
                  child: IconButton(
                      icon: const Icon(Icons.search),
                      tooltip: 'Search',
                      onPressed: () {
                        GoRouter.of(context).push(globalSearchScreenRoute);
                      }))
            ],
          ),
          body: isLoading
              ? Padding(padding: const EdgeInsets.all(16.0), child: DotLoader())
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ProfileInfoWidget(
                        avatarUrl: accountState.account!.avatar!.images.first.fullPath,
                        name: accountState.account!.displayName,
                        username: '@${accountState.account!.username}',
                        friends: accountState.account!.friendsCount,
                        followers: accountState.account!.followersCount,
                        likes: accountState.account!.likesCount,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TabNavigation(
                          activeTab: activeTab,
                          onTabChange: handleTabChange,
                        )),
                    const SizedBox(height: 10),
                    if (accountState.account != null && activeTab == AccountTabType.Posts)
                      Expanded(
                          child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: AccountPostListWidget(
                                repository: getIt<PostsRepository>(),
                                userId: accountState.account!.id,
                                isOwner: true,
                              ))),
                    if (accountState.account != null && activeTab == AccountTabType.SavedPosts) SavedLocationsPointsList(repository: getIt<PostsRepository>()),
                    if (accountState.account != null && activeTab == AccountTabType.LikedPosts) LikedPostsList(repository: getIt<PostsRepository>()),
                  ],
                ),
          bottomNavigationBar: PhoneBottomMenu(sellectedType: MenuButtons.Home));
    });
  }
}
