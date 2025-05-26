import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mtaa_frontend/core/constants/route_constants.dart';
import 'package:mtaa_frontend/core/utils/app_injections.dart';
import 'package:mtaa_frontend/themes/bloc/theme_bloc.dart';
import 'package:mtaa_frontend/themes/bloc/theme_event.dart';
import 'package:mtaa_frontend/themes/button_theme.dart';

/// Initial screen for the app, providing options to sign up or log in.
class StartScreen extends StatelessWidget {
  /// Creates a [StartScreen] widget.
  const StartScreen({super.key});

  /// Builds the UI with a responsive layout, logo, and navigation buttons.
  @override
  Widget build(BuildContext context) {
    if (getIt.isRegistered<BuildContext>()) {
      getIt.unregister<BuildContext>();
    }
    getIt.registerSingleton<BuildContext>(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            title: constraints.maxHeight <= 900
                ? Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    SvgPicture.asset('assets/svgs/small_logo.svg', height: 24),
                    const SizedBox(width: 4),
                    SvgPicture.asset('assets/svgs/logo_text_white.svg', height: 18),
                  ])
                : null,
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
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (constraints.maxHeight > 900)
                  Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/svgs/small_logo.svg',
                            width: 100,
                            height: 100,
                          ),
                          const SizedBox(width: 10),
                          SvgPicture.asset(
                            'assets/svgs/logo_text.svg',
                            height: 80,
                          ),
                        ],
                      )),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            'assets/svgs/start_svg_1.svg',
                            width: 200,
                            height: 200,
                          ),
                          SvgPicture.asset(
                            'assets/svgs/start_svg_3.svg',
                            width: 200,
                            height: 200,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            'assets/svgs/start_svg_2.svg',
                            width: 200,
                            height: 200,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Welcome to Likely',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 10),
                Text(
                  'The best messenger in the world',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const Spacer(),
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 28),
                    child: Column(children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints.tightFor(width: 300),
                        child: SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () {
                              GoRouter.of(context).push(startSignUpPageRoute);
                            },
                            style: Theme.of(context).textButtonTheme.style,
                            child: Text('Sign Up'),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ConstrainedBox(
                        constraints: const BoxConstraints.tightFor(width: 300),
                        child: SizedBox(
                          width: double.infinity,
                          child: TextButton(
                            onPressed: () {
                              GoRouter.of(context).push(logInScreenRoute);
                            },
                            style: specialTextButtonThemeData.style,
                            child: Text('Log In'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
