import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mtaa_frontend/core/constants/route_constants.dart';
import 'package:mtaa_frontend/features/users/account/data/models/requests/updateAccountBirthDateRequest.dart';
import 'package:mtaa_frontend/features/users/account/data/network/account_api.dart';
import 'package:mtaa_frontend/features/users/account/presentation/widgets/birthDateForm.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/dotLoader.dart';
import 'package:mtaa_frontend/themes/bloc/theme_bloc.dart';
import 'package:mtaa_frontend/themes/bloc/theme_event.dart';

/// Screen for updating the user's birth date during initial setup.
class FirstUpdateBirthDateScreen extends StatefulWidget {
  final AccountApi accountApi;

  /// Creates a [FirstUpdateBirthDateScreen] with required API dependency.
  const FirstUpdateBirthDateScreen({super.key, required this.accountApi});

  @override
  State<FirstUpdateBirthDateScreen> createState() => _FirstUpdateBirthDateScreenState();
}

/// Manages the state for birth date selection and submission.
class _FirstUpdateBirthDateScreenState extends State<FirstUpdateBirthDateScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final birthDateController = TextEditingController();
  bool isLoading = false;
  DateTime? selectedDate;
  bool isError = false;

  /// Cleans up resources on widget disposal.
  @override
  void dispose() {
    birthDateController.dispose();
    super.dispose();
  }

  /// Navigates to the avatar update screen.
  void _navigateToGroupListScreen() {
    Future.microtask(() {
      if (!mounted) return;
      GoRouter.of(context).push(firstUpdateAvatarScreenRoute);
    });
  }

  /// Builds the UI with birth date form and action buttons.
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
              'How old are you?',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 18),
            if (isError)
              Text(
                'Please select your birth date',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            BirthDateForm(
              formKey: _formKey,
              onChanged: (date) async {
                if (!mounted) return;
                setState(() {
                  selectedDate = date;
                  isError = false;
                });
              },
            ),
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
                        child: Text('Skip'),
                      ),
                      const SizedBox(width: 5),
                      TextButton(
                        onPressed: () async {
                          if (selectedDate == null) {
                            if (!mounted) return;
                            setState(() {
                              isError = true;
                            });
                            return;
                          } else {
                            isError = false;
                            if (_formKey.currentState!.validate()) {
                              if (!mounted) return;
                              setState(() => isLoading = true);
                              bool res = await widget.accountApi.updateAccountBirthDate(UpdateAccountBirthDateRequest(birthDate: selectedDate ?? DateTime.now()));
                              if(!mounted)return;
                              setState(() => isLoading = false);
                              if (res) {
                                _navigateToGroupListScreen();
                              }
                            }
                          }
                        },
                        style: Theme.of(context).textButtonTheme.style,
                        child: Text('Create'),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
