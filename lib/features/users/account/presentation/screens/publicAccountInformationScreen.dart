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
import 'package:mtaa_frontend/features/users/account/presentation/widgets/publicTabNavigation.dart';

/// Screen displaying public account information and posts.
class PublicAccountInformationScreen extends StatefulWidget {
  final AccountRepository repository;
  final String userId;

  /// Creates a [PublicAccountInformationScreen] with required dependencies and user ID.
  const PublicAccountInformationScreen({
    super.key,
    required this.repository,
    required this.userId,
  });

  @override
  State<PublicAccountInformationScreen> createState() => _PublicAccountInformationScreenState();
}

/// Manages the state for loading public account data and handling follow actions.
class _PublicAccountInformationScreenState extends State<PublicAccountInformationScreen> {
  bool isLoading = false;
  PublicFullAccountResponse? user;

  /// Initializes state and loads user data.
  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  /// Loads public account data from the repository.
  Future<void> _loadUser() async {
    if (!mounted) return;
    setState(() => isLoading = true);
    final res = await widget.repository.getPublicFullAccount(widget.userId);
    if (!mounted) return;
    setState(() {
      user = res;
      isLoading = false;
    });
  }

  /// Toggles follow/unfollow status for the user.
  Future<void> _toggleFollow() async {
    if (user == null) return;
    final wasFollowing = user!.isFollowing;
    if (!mounted) return;
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
      if (!mounted) return;
      setState(() {
        user?.isFollowing = wasFollowing;
      });
    }
  }

  /// Builds the UI with app bar, profile info, tabs, and post list.
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
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      if (user != null)
                        PublicProfileInfoWidget(
                          user: user!,
                          onFollowToggle: _toggleFollow,
                        ),
                      PublicTabNavigation(),
                      const SizedBox(height: 10),
                      if (user != null)
                        AccountPostListWidget(
                          repository: getIt<PostsRepository>(),
                          userId: user!.id,
                          isOwner: false,
                        ),
                    ],
                  ),
                )),
      bottomNavigationBar: const PhoneBottomMenu(sellectedType: MenuButtons.Home),
    );
  }
}
