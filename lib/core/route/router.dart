import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mtaa_frontend/core/constants/route_constants.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
import 'package:mtaa_frontend/features/authentication/shared/data/network/identity_api.dart';
import 'package:mtaa_frontend/features/authentication/shared/presentation/screens/firstAddFullNameScreen.dart';
import 'package:mtaa_frontend/features/authentication/sign-up/presentation/screens/createAccountScreen.dart';
import 'package:mtaa_frontend/features/authentication/sign-up/presentation/screens/signUpVerificationByEmailScreen.dart';
import 'package:mtaa_frontend/features/authentication/sign-up/presentation/screens/startScreen.dart';
import 'package:mtaa_frontend/features/authentication/sign-up/presentation/screens/startSignUpScreen.dart';
import 'package:mtaa_frontend/features/authentication/log-in/presentation/screens/startLogInScreen.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const StartScreen(),
      ),
      GoRoute(
        path: startSignUpPageRoute,
        builder: (context, state) => StartSignUpScreen(
          identityApi: getIt<IdentityApi>(),
        ),
      ),
      GoRoute(
        path: signUpVerificationByEmailScreenRoute,
        builder: (context, state) => SignUpVerificationByEmailScreen(identityApi: getIt<IdentityApi>()),
      ),
      GoRoute(
        path: createAccountScreenRoute,
        builder: (context, state) => CreateAccountScreen(identityApi: getIt<IdentityApi>()),
      ),
      GoRoute(
        path: firstAddFullNameScreenRoute,
        builder: (context, state) => FirstAddFullNameScreen(identityApi: getIt<IdentityApi>()),
      ),
      GoRoute(
        path: startLogInPageRoute,
        builder: (context, state) => StartLogInScreen(
          identityApi: getIt<IdentityApi>(),
        ),
      ),
    ],
  );
}
