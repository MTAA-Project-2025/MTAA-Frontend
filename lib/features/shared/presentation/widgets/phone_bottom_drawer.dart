import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mtaa_frontend/core/constants/menu_buttons.dart';
import 'package:mtaa_frontend/core/constants/route_constants.dart';

/// A drawer widget for navigation with menu options.
class PhoneBottomDrawer extends StatelessWidget {
  final MenuButtons sellectedType;

  /// Creates a [PhoneBottomDrawer] with a selected menu type.
  const PhoneBottomDrawer({
    super.key,
    required this.sellectedType,
  });

  /// Builds the UI with a list of navigable menu items.
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            leading: SvgPicture.asset('assets/icons/friends.svg'),
            title: Text('Friends'),
            onTap: () => GoRouter.of(context).go(friendsScreenRoute),
          ),
          ListTile(
            leading: SvgPicture.asset('assets/icons/map.svg'),
            title: Text('Map'),
            onTap: () => GoRouter.of(context).go(userMapScreenRoute),
          ),
          ListTile(
            leading: SvgPicture.asset('assets/icons/home.svg'),
            title: Text('Home'),
            onTap: () => GoRouter.of(context).go(userRecommendationsScreenRoute),
          ),
          ListTile(
            leading: SvgPicture.asset('assets/icons/profile.svg'),
            title: Text('Profile'),
            onTap: () => GoRouter.of(context).go(accountProfileScreenRoute),
          ),
          ListTile(
            leading: SvgPicture.asset('assets/icons/settings.svg'),
            title: Text('Settings'),
            onTap: () => GoRouter.of(context).go(userSettingsScreenRoute),
          ),
        ],
      ),
    );
  }
}
