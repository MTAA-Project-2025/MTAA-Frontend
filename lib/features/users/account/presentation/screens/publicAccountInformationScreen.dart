import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mtaa_frontend/core/constants/menu_buttons.dart';
import 'package:mtaa_frontend/core/constants/route_constants.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
import 'package:mtaa_frontend/features/posts/data/repositories/posts_repository.dart';
import 'package:mtaa_frontend/features/posts/presentation/widgets/account_post_list.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/dotLoader.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/phone_bottom_menu.dart';
import 'package:mtaa_frontend/features/users/account/data/models/requests/follow.dart';
import 'package:mtaa_frontend/features/users/account/data/models/requests/unfollow.dart';
import 'package:mtaa_frontend/features/users/account/data/models/responses/publicFullAccountResponse.dart';
import 'package:mtaa_frontend/features/users/account/data/repositories/account_repository.dart';
import 'package:mtaa_frontend/features/users/account/presentation/widgets/publicProfileInfoWidget.dart';

class PublicAccountInformationScreen extends StatefulWidget {
  final AccountRepository repository;
  final PublicFullAccountResponse user;

  const PublicAccountInformationScreen({
    super.key,
    required this.repository,
    required this.user,
  });

  @override
  State<PublicAccountInformationScreen> createState() => _PublicAccountInformationScreenState();
}

class _PublicAccountInformationScreenState extends State<PublicAccountInformationScreen> {
  bool isLoading = false;
  PublicFullAccountResponse? user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    setState(() => isLoading = true);

    final res = await widget.repository.getFullAccount();

    if (!mounted) return;

    setState(() {
      user = res;
      isLoading = false;
    });
  }

  Future<void> _toggleFollow() async {
    if (user == null) return;

    final wasFollowing = user!.isFollowing;

    setState(() {
      user?.isFollowing = !wasFollowing;
    });

    try {
      if (wasFollowing) {
        await widget.repository.unfollow(Unfollow(userId: user!.id));
      } else {
        await widget.repository.follow(Follow(userId: user!.id));
      }
    } catch (e) {
      setState(() {
        user?.isFollowing = wasFollowing;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 21),
            child: IconButton(
              icon: const Icon(Icons.search),
              tooltip: 'Search',
              onPressed: () {
                GoRouter.of(context).push(globalSearchScreenRoute);
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const DotLoader()
            : Column(
                children: [
                  if (user != null)
                    PublicProfileInfoWidget(
                      user: user!,
                      onFollowToggle: _toggleFollow,
                    ),
                  const SizedBox(height: 10),
                  if (user != null)
                    Expanded(
                      child: AccountPostListWidget(
                        repository: getIt<PostsRepository>(),
                        userId: user!.id,
                      ),
                    ),
                ],
              ),
      ),
      bottomNavigationBar: const PhoneBottomMenu(sellectedType: MenuButtons.Home),
    );
  }
}
