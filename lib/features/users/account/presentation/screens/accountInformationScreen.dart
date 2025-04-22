import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mtaa_frontend/core/constants/menu_buttons.dart';
import 'package:mtaa_frontend/core/constants/route_constants.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
import 'package:mtaa_frontend/features/posts/data/repositories/posts_repository.dart';
import 'package:mtaa_frontend/features/posts/presentation/widgets/account_post_list.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/dotLoader.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/phone_bottom_menu.dart';
import 'package:mtaa_frontend/features/users/account/data/models/responses/userFullAccountResponse.dart';
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
  UserFullAccountResponse? user;
  String activeTab = 'photos';

  void handleTabChange(String tabId) {
    setState(() {
      activeTab = tabId;
    });
  }

  @override
  void initState() {
    super.initState();

    if (getIt.isRegistered<BuildContext>()) {
      getIt.unregister<BuildContext>();
    }
    getIt.registerSingleton<BuildContext>(context);

    setState(() {
      isLoading = true;
    });
    Future.microtask(() async {
      if (!mounted) return;

      var res = await widget.repository.getFullAccount();

      if (res != null) {
        setState(() {
          user = res;
        });
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: isLoading
              ? DotLoader()
              : Column(
                  children: [
                    ProfileInfoWidget(
                      avatarUrl: user!.avatar!.images.first.fullPath,
                      name: user!.displayName,
                      username: '@${user!.username}',
                      friends: user!.friendsCount,
                      followers: user!.followersCount,
                      likes: user!.likesCount,
                    ),
                    TabNavigation(
                      activeTab: activeTab,
                      onTabChange: handleTabChange,
                    ),
                    const SizedBox(height: 10),
                    if (user != null) Expanded(child: AccountPostListWidget(repository: getIt<PostsRepository>(), userId: user!.id))
                  ],
                ),
        ),
        bottomNavigationBar: PhoneBottomMenu(sellectedType: MenuButtons.Home));
  }
}
