import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mtaa_frontend/core/constants/colors.dart';
import 'package:mtaa_frontend/core/constants/menu_buttons.dart';
import 'package:mtaa_frontend/core/constants/route_constants.dart';

/// A bottom navigation menu with icon buttons for app navigation.
class PhoneBottomMenu extends StatelessWidget {
  final MenuButtons sellectedType;

  /// Creates a [PhoneBottomMenu] with a selected menu type.
  const PhoneBottomMenu({
    super.key,
    required this.sellectedType,
  });

  /// Builds the UI with a row of icon buttons for navigation.
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: Column(
            children: [
              SvgPicture.asset(
                'assets/icons/friends.svg',
                colorFilter: sellectedType == MenuButtons.Friends ? ColorFilter.mode(white2InvincibleColor, BlendMode.srcIn) : ColorFilter.mode(whiteColor, BlendMode.srcIn),
              ),
              Text(
                'Friends',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: sellectedType == MenuButtons.Friends ? white2InvincibleColor : whiteColor,
                    ),
              ),
            ],
          ),
          onPressed: () {
            GoRouter.of(context).go(friendsScreenRoute);
          },
        ),
        IconButton(
          icon: Column(
            children: [
              SvgPicture.asset(
                'assets/icons/map.svg',
                colorFilter: sellectedType == MenuButtons.Map ? ColorFilter.mode(white2InvincibleColor, BlendMode.srcIn) : ColorFilter.mode(whiteColor, BlendMode.srcIn),
              ),
              Text(
                'Map',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: sellectedType == MenuButtons.Map ? white2InvincibleColor : whiteColor,
                    ),
              ),
            ],
          ),
          onPressed: () {
            GoRouter.of(context).go(userMapScreenRoute);
          },
        ),
        IconButton(
          icon: Column(
            children: [
              SvgPicture.asset(
                'assets/icons/home.svg',
                colorFilter: sellectedType == MenuButtons.Home ? ColorFilter.mode(white2InvincibleColor, BlendMode.srcIn) : ColorFilter.mode(whiteColor, BlendMode.srcIn),
                height: 36,
                width: 36,
              ),
            ],
          ),
          onPressed: () {
            GoRouter.of(context).go(userRecommendationsScreenRoute);
          },
        ),
        IconButton(
          icon: Column(
            children: [
              SvgPicture.asset(
                'assets/icons/profile.svg',
                colorFilter: sellectedType == MenuButtons.Profile ? ColorFilter.mode(white2InvincibleColor, BlendMode.srcIn) : ColorFilter.mode(whiteColor, BlendMode.srcIn),
              ),
              Text(
                'Profile',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: sellectedType == MenuButtons.Profile ? white2InvincibleColor : whiteColor,
                    ),
              ),
            ],
          ),
          onPressed: () {
            GoRouter.of(context).go(accountProfileScreenRoute);
          },
        ),
        IconButton(
          icon: Column(
            children: [
              SvgPicture.asset(
                'assets/icons/settings.svg',
                colorFilter: sellectedType == MenuButtons.Settings ? ColorFilter.mode(white2InvincibleColor, BlendMode.srcIn) : ColorFilter.mode(whiteColor, BlendMode.srcIn),
              ),
              Text(
                'Settings',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: sellectedType == MenuButtons.Settings ? white2InvincibleColor : whiteColor,
                    ),
              ),
            ],
          ),
          onPressed: () {
            GoRouter.of(context).go(userSettingsScreenRoute);
          },
        ),
      ],
    ));
  }
}
