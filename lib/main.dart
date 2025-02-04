import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mtaa_frontend/core/config/app_config.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
import 'package:mtaa_frontend/features/authentication/shared/blocs/verification_email_phone_bloc.dart';
import 'package:mtaa_frontend/features/authentication/sign-up/presentation/pages/signUpVerificationByEmailScreen.dart';
import 'package:mtaa_frontend/themes/app_theme.dart';
import 'package:mtaa_frontend/themes/bloc/theme_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mtaa_frontend/themes/bloc/theme_state.dart';
import 'package:mtaa_frontend/core/route/router.dart' as router;

void main() {
  const environment =
      String.fromEnvironment('ENV', defaultValue: 'development');
  AppConfig.loadConfig(environment);
  setupDependencies();
  HttpOverrides.global = MyHttpOverrides();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<ThemeBloc>(
        create: (_) => ThemeBloc(),
      ),
      BlocProvider<VerificationEmailPhoneBloc>(
        create: (_) => VerificationEmailPhoneBloc(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp.router(
          title: 'Flutter Demo',
          theme: AppTheme.lightTheme(context),
          darkTheme: AppTheme.darkTheme(context),
          themeMode: state.themeMode,
          routerConfig: router.AppRouter.router,
        );
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
