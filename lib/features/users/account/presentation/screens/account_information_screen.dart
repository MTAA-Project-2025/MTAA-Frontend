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

class AccountInformationScreen extends StatefulWidget {
  final AccountRepository repository;

  const AccountInformationScreen({super.key, required this.repository});

  @override
  State<AccountInformationScreen> createState() => _AccountInformationScreenState();
}

class _AccountInformationScreenState extends State<AccountInformationScreen> {
  bool isLoading = false;
  UserFullAccountResponse? user;
  @override
  void initState() {
    super.initState();

    if (getIt.isRegistered<BuildContext>()) {
      getIt.unregister<BuildContext>();
    }
    getIt.registerSingleton<BuildContext>(context);

    if (!mounted) return;
    setState(() {
      isLoading = true;
    });
    Future.microtask(() async {
      if (!mounted) return;

      var res = await widget.repository.getFullAccount();

      if (res != null) {
        if(!mounted)return;
        setState(() {
          user = res;
        });
      }
      if(!mounted)return;
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
                    Row(
                      children: [
                        if (user != null)
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: user?.avatar != null ? NetworkImage(user!.avatar!.images.first.fullPath) : AssetImage('assets/default_avatar.png') as ImageProvider,
                          ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user == null ? '' : user!.displayName,
                              style: Theme.of(context).textTheme.headlineLarge,
                            ),
                            Text(
                              user == null ? '' : '@${user!.username}',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Row(
                              children: [
                                if (user != null) Text('${user!.friendsCount} Friends'),
                                SizedBox(width: 8),
                                if (user != null) Text('${user!.followersCount} Followers'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Change Profile'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Notifications'),
                    ),
                    if (user != null) Expanded(child: AccountPostListWidget(repository: getIt<PostsRepository>(), userId: user!.id, isOwner: true))
                  ],
                ),
        ),
        bottomNavigationBar: PhoneBottomMenu(sellectedType: MenuButtons.Home));
  }
}
