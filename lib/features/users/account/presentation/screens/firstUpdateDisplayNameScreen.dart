import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mtaa_frontend/core/constants/route_constants.dart';
import 'package:mtaa_frontend/features/users/account/data/models/requests/updateAccountDisplayNameRequest.dart';
import 'package:mtaa_frontend/features/users/account/data/network/account_api.dart';
import 'package:mtaa_frontend/features/users/account/presentation/widgets/displayNameForm.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/dotLoader.dart';
import 'package:mtaa_frontend/themes/bloc/theme_bloc.dart';
import 'package:mtaa_frontend/themes/bloc/theme_event.dart';

class FirstUpdateDisplayNameScreen extends StatefulWidget {
  final AccountApi accountApi;

  const FirstUpdateDisplayNameScreen({super.key, required this.accountApi});

  @override
  State<FirstUpdateDisplayNameScreen> createState() => _FirstUpdateDisplayNameScreenState();
}

class _FirstUpdateDisplayNameScreenState extends State<FirstUpdateDisplayNameScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final displayNameController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    displayNameController.dispose();
    super.dispose();
  }

  void _navigateToUpdateBirthDateScreen() {
    Future.microtask(() {
      if (!mounted) return;
      GoRouter.of(context).push(firstUpdateBirthDateScreenRoute);
    });
  }

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
        child: Column(
          children: [
            Text(
              'What`s your name?',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 18),
            DisplayNameForm(formKey: _formKey, displayNameController: displayNameController),
            const SizedBox(height: 19),
            isLoading
                ? const DotLoader()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          GoRouter.of(context).go(userRecommendationsScreenRoute);
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Theme.of(context).colorScheme.secondary,
                          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        child: Text(
                          'Skip',
                        ),
                      ),
                      const SizedBox(width: 5),
                      TextButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            if(!mounted)return;
                            setState(() => isLoading = true);
                            bool res = await widget.accountApi.updateAccountDisplayName(UpdateAccountDisplayNameRequest(displayName: displayNameController.text));
                            
                            if(!mounted)return;
                            setState(() => isLoading = false);
                            if (res) {
                              _navigateToUpdateBirthDateScreen();
                            }
                          }
                        },
                        style: Theme.of(context).textButtonTheme.style,
                        child: Text(
                          'Create',
                        ),
                      ),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
