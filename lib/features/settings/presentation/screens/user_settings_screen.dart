import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mtaa_frontend/core/constants/colors.dart';
import 'package:mtaa_frontend/core/constants/menu_buttons.dart';
import 'package:mtaa_frontend/core/constants/route_constants.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/phone_bottom_drawer.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/phone_bottom_menu.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/data/storages/tokenStorage.dart';
import 'package:mtaa_frontend/themes/bloc/theme_bloc.dart';
import 'package:mtaa_frontend/themes/bloc/theme_event.dart';
import 'package:mtaa_frontend/themes/bloc/theme_state.dart';

/// Displays the user settings screen with options for logout, scheduled posts, and theme selection.
class UserSettingsScreen extends StatefulWidget {
  final TokenStorage tokenStorage;

  /// Creates a [UserSettingsScreen] with required dependencies.
  const UserSettingsScreen({super.key, required this.tokenStorage});

  @override
  State<UserSettingsScreen> createState() => _UserSettingsScreenState();
}

/// Manages the state for the user settings screen.
class _UserSettingsScreenState extends State<UserSettingsScreen> {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  /// Changes the app theme by dispatching a theme change event.
  void _changeTheme(AppThemeMode mode) {
    context.read<ThemeBloc>().add(ChangeThemeEvent(mode));
  }

  /// Initializes state and registers the current context in the dependency injector.
  @override
  void initState() {
    super.initState();
    if (getIt.isRegistered<BuildContext>()) {
      getIt.unregister<BuildContext>();
    }
    getIt.registerSingleton<BuildContext>(context);
  }

  /// Builds the UI with settings options and theme toggle buttons.
  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Text(
              'Settings',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 10),
            ConstrainedBox(
              constraints: const BoxConstraints.tightFor(width: 300),
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    analytics.logEvent(name: 'logout');
                    widget.tokenStorage.deleteToken();
                    GoRouter.of(context).go('/');
                  },
                  style: Theme.of(context).textButtonTheme.style,
                  child: Text(
                    'Log out',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ConstrainedBox(
              constraints: const BoxConstraints.tightFor(width: 300),
              child: SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    GoRouter.of(context).push(schedulePostsScreenRoute);
                  },
                  style: Theme.of(context).textButtonTheme.style,
                  child: Text(
                    'Scheduled Posts',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    style: Theme.of(context).textButtonTheme.style!.copyWith(
                          minimumSize: WidgetStateProperty.all(const Size(0, 0)),
                          padding: WidgetStateProperty.all(const EdgeInsets.all(10)),
                          shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          )),
                          backgroundColor:
                              state.appThemeMode == AppThemeMode.light ? WidgetStateProperty.all(secondary1InvincibleColor) : WidgetStateProperty.all(Theme.of(context).scaffoldBackgroundColor),
                        ),
                    child: Icon(
                      Icons.light_mode,
                      color: state.appThemeMode == AppThemeMode.light ? whiteColor : Theme.of(context).iconTheme.color,
                      size: Theme.of(context).iconTheme.size,
                    ),
                    onPressed: () => _changeTheme(AppThemeMode.light),
                  ),
                  TextButton(
                    style: Theme.of(context).textButtonTheme.style!.copyWith(
                          minimumSize: WidgetStateProperty.all(const Size(0, 0)),
                          padding: WidgetStateProperty.all(const EdgeInsets.all(10)),
                          shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          )),
                          backgroundColor:
                              state.appThemeMode == AppThemeMode.dark ? WidgetStateProperty.all(secondary1InvincibleColor) : WidgetStateProperty.all(Theme.of(context).scaffoldBackgroundColor),
                        ),
                    child: Icon(
                      Icons.dark_mode,
                      color: state.appThemeMode == AppThemeMode.dark ? whiteColor : Theme.of(context).iconTheme.color,
                      size: Theme.of(context).iconTheme.size,
                    ),
                    onPressed: () => _changeTheme(AppThemeMode.dark),
                  ),
                  TextButton(
                    style: Theme.of(context).textButtonTheme.style!.copyWith(
                          minimumSize: WidgetStateProperty.all(const Size(0, 0)),
                          shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(999),
                          )),
                          padding: WidgetStateProperty.all(const EdgeInsets.all(10)),
                          backgroundColor:
                              state.appThemeMode == AppThemeMode.inclusive ? WidgetStateProperty.all(secondary1InvincibleColor) : WidgetStateProperty.all(Theme.of(context).scaffoldBackgroundColor),
                        ),
                    child: Icon(
                      Icons.color_lens,
                      color: state.appThemeMode == AppThemeMode.inclusive ? whiteColor : Theme.of(context).iconTheme.color,
                      size: Theme.of(context).iconTheme.size,
                    ),
                    onPressed: () => _changeTheme(AppThemeMode.inclusive),
                  ),
                ],
              );
            }),
          ],
        ),
        drawer: isPortrait ? null : PhoneBottomDrawer(sellectedType: MenuButtons.Settings),
        bottomNavigationBar: isPortrait ? PhoneBottomMenu(sellectedType: MenuButtons.Settings) : null);
  }
}
