import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mtaa_frontend/core/constants/route_constants.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
import 'package:mtaa_frontend/features/authentication/data/network/identity_api.dart';
import 'package:mtaa_frontend/features/authentication/sign-up/presentation/pages/signUpVerificationByEmailScreen.dart';
import 'package:mtaa_frontend/features/authentication/sign-up/presentation/pages/startPage.dart';
import 'package:mtaa_frontend/features/authentication/sign-up/presentation/pages/startSignUpPage.dart';

class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const StartPage(),
      ),
      GoRoute(
        path: startSignUpPageRoute,
        builder: (context, state) => StartSignUpPage(
          identityApi: getIt<IdentityApi>(),
        ),
      ),
      GoRoute(
        path: signUpVerificationByEmailScreenRoute,
        builder: (context, state) => SignUpVerificationByEmailScreen(),
      ),
    ],
  );
}
