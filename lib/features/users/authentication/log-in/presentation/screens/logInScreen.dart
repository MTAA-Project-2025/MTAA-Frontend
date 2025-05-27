import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mtaa_frontend/core/constants/route_constants.dart';
import 'package:mtaa_frontend/features/notifications/data/network/notificationsService.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/data/models/token.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/data/network/identity_api.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/data/storages/tokenStorage.dart';
import 'package:mtaa_frontend/features/users/authentication/log-in/data/models/requests/logInRequest.dart';
import 'package:mtaa_frontend/features/users/authentication/log-in/presentation/widgets/StartLogInForm.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/dotLoader.dart';
import 'package:mtaa_frontend/themes/bloc/theme_bloc.dart';
import 'package:mtaa_frontend/themes/bloc/theme_event.dart';

/// Screen for user login with email or phone number.
class LogInScreen extends StatefulWidget {
  final IdentityApi identityApi;
  final NotificationsService notificationsService;
  final TokenStorage tokenStorage;

  /// Creates a [LogInScreen] with required dependencies.
  const LogInScreen({
    super.key,
    required this.identityApi,
    required this.notificationsService,
    required this.tokenStorage,
  });

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

/// Manages the state for the login form and authentication process.
class _LogInScreenState extends State<LogInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final loginController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  /// Cleans up controllers on widget disposal.
  @override
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  /// Navigates to the main recommendations screen after successful login.
  void _navigateToMainScreen() {
    Future.microtask(() async {
      if (!mounted) return;
      GoRouter.of(context).go(userRecommendationsScreenRoute);
    });
  }

  /// Builds the UI with login form, theme toggle, and navigation options.
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
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(28),
            child: Center(
              child: Column(
                children: [
                  Text(
                    'Log In',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(height: 18),
                  StartLogInForm(formKey: _formKey, loginController: loginController, passwordController: passwordController),
                  const SizedBox(height: 19),
                  isLoading
                      ? const DotLoader()
                      : TextButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              if(!mounted)return;
                              setState(() => isLoading = true);

                              String input = loginController.text.trim();
                              String? email;
                              String? phone;

                              // Check if input is an email or phone number
                              if (RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(input)) {
                                email = input; // It's an email
                              } else if (RegExp(r'^\+?\d+$').hasMatch(input)) {
                                phone = input; // It's a phone number
                              }

                              Token? res = await widget.identityApi.logIn(
                                LogInRequest(email: email, phone: phone, password: passwordController.text),
                              );

                              if(!mounted)return;
                              setState(() => isLoading = false);

                              if (res != null) {
                                widget.tokenStorage.saveToken(res.token);
                                await analytics.logLogin(loginMethod: 'email');
                                _navigateToMainScreen();
                              }
                            }
                          },
                          style: Theme.of(context).textButtonTheme.style,
                          child: Text(
                            'Start',
                          ),
                        ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Need an account? "),
                      Text(
                        "Sign Up",
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }
}
