import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mtaa_frontend/core/constants/route_constants.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/blocs/verification_email_phone_bloc.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/blocs/verification_email_phone_state.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/data/models/token.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/data/network/identity_api.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/data/storages/tokenStorage.dart';
import 'package:mtaa_frontend/features/users/authentication/sign-up/data/models/requests/signUpByEmailRequest.dart';
import 'package:mtaa_frontend/features/users/authentication/sign-up/presentation/widgets/createAccountForm.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/dotLoader.dart';
import 'package:mtaa_frontend/themes/bloc/theme_bloc.dart';
import 'package:mtaa_frontend/themes/bloc/theme_event.dart';

class UserGroupListScreen extends StatefulWidget {
  final IdentityApi identityApi;

  const UserGroupListScreen({super.key, required this.identityApi});

  @override
  State<UserGroupListScreen> createState() => _UserGroupListScreenState();
}

class _UserGroupListScreenState extends State<UserGroupListScreen> {
  final GlobalKey<FormState> _emailformKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _navigateToFirstUpdateDisplayNameScreenRoute() {
    Future.microtask(() {
      if (!mounted) return;
      GoRouter.of(context).push(firstUpdateDisplayNameScreenRoute);
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
        child: Center(child: Column(
          children: [
            Text(
              'User group list screen',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 18),
            CreateAccountForm(
                formKey: _emailformKey,
                usernameController: usernameController,
                passwordController: passwordController),
            const SizedBox(height: 19),
            isLoading
                ? const DotLoader():
                BlocBuilder<VerificationEmailPhoneBloc,
                                VerificationEmailPhoneState>(
                            builder: (context, state) {
                          return TextButton(
                    onPressed: () async {
                      if (_emailformKey.currentState!.validate()) {
                        setState(() => isLoading = true);
                        Token? res = await widget.identityApi.signUpByEmail(SignUpByEmailRequest(email:state.str, username: usernameController.text, password: passwordController.text));
                        setState(() => isLoading = false);
                        if(res != null)
                        {
                          TokenStorage.saveToken(res.token);
                          _navigateToFirstUpdateDisplayNameScreenRoute();
                        }
                      }
                    },
                    style: Theme.of(context).textButtonTheme.style,
                    child: Text(
                      'Create',
                    ),);},
                  ),
          ],
        ),
      ))
    );
  }
}
