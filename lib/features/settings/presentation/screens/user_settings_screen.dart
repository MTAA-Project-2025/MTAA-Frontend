import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mtaa_frontend/core/constants/menu_buttons.dart';
import 'package:mtaa_frontend/core/constants/route_constants.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/phone_bottom_menu.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/data/storages/tokenStorage.dart';
import 'package:mtaa_frontend/themes/bloc/theme_bloc.dart';
import 'package:mtaa_frontend/themes/bloc/theme_event.dart';

class UserSettingsScreen extends StatefulWidget {
  const UserSettingsScreen({super.key});

  @override
  State<UserSettingsScreen> createState() => _UserSettingsScreenState();
}

class _UserSettingsScreenState extends State<UserSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 21, 0),
                child: IconButton(
                  icon: const Icon(Icons.dark_mode),
                  tooltip: 'Change theme',
                  onPressed: () {
                    context.read<ThemeBloc>().add(ToggleThemeEvent());
                  },
                ))
          ],
        ),
        body: Column(
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints.tightFor(width: 300),
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    TokenStorage.deleteToken();
                    GoRouter.of(context).go('/');
                  },
                  style: Theme.of(context).textButtonTheme.style,
                  child: Text(
                    'Log out',
                  ),
                ),
              ),
            ),
            ConstrainedBox(
              constraints: const BoxConstraints.tightFor(width: 300),
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    GoRouter.of(context).push(addPostScreenRoute);
                  },
                  style: Theme.of(context).textButtonTheme.style,
                  child: Text(
                    'Add Post',
                  ),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: PhoneBottomMenu(sellectedType: MenuButtons.Settings));
  }
}
