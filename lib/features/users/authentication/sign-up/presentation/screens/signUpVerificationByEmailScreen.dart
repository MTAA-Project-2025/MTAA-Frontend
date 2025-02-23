import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:mtaa_frontend/core/constants/colors.dart';
import 'package:mtaa_frontend/core/constants/route_constants.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/blocs/verification_email_phone_bloc.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/blocs/verification_email_phone_state.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/data/network/identity_api.dart';
import 'package:mtaa_frontend/features/users/authentication/shared/presentation/widgets/resendCodeButton.dart';
import 'package:mtaa_frontend/features/users/authentication/sign-up/data/models/requests/StartSignUpEmailVerificationRequest.dart';
import 'package:mtaa_frontend/features/users/authentication/sign-up/data/models/requests/signUpVerifyEmailRequest.dart';
import 'package:mtaa_frontend/features/users/authentication/sign-up/presentation/widgets/verificationCodeInput.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/dotLoader.dart';
import 'package:mtaa_frontend/themes/bloc/theme_bloc.dart';
import 'package:mtaa_frontend/themes/bloc/theme_event.dart';

class SignUpVerificationByEmailScreen extends StatefulWidget {
  final IdentityApi identityApi;

  const SignUpVerificationByEmailScreen({super.key, required this.identityApi});

  @override
  State<SignUpVerificationByEmailScreen> createState() =>
      _SignUpVerificationByEmailScreenState();
}

class _SignUpVerificationByEmailScreenState
    extends State<SignUpVerificationByEmailScreen> {
  bool isLoading = false;

  void _navigateToCreateAccount() {
    Future.microtask(() {
      if (!mounted) return;
      GoRouter.of(context).push(createAccountScreenRoute);
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
        body: Container(
            padding: const EdgeInsets.all(28),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(children: [
                    Text(
                      'Verify Your Email',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 9),
                    BlocBuilder<VerificationEmailPhoneBloc,
                        VerificationEmailPhoneState>(builder: (context, state) {
                      return Text.rich(
                          textAlign: TextAlign.center,
                          TextSpan(
                            text:
                                'We sent a confirmation Email to the ${state.str}. ',
                            style: Theme.of(context).textTheme.bodyMedium,
                            children: [
                              TextSpan(
                                text: 'Wrong email?',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          ));
                    }),
                  ]),
                  Spacer(flex: 1),
                  Column(
                    children: [
                      Text(
                        'Enter 6-digit code',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      isLoading
                          ? Container(
                              width: (6 * 32) + (3 * 4) + 16,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 28),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: primarily0InvincibleColor, width: 1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: DotLoader(),
                            )
                          : BlocBuilder<VerificationEmailPhoneBloc,
                                  VerificationEmailPhoneState>(
                              builder: (context, state) {
                              return VerificationCodeInput(
                                  onCompleted: (code) async {
                                if (mounted) {
                                  setState(() => isLoading = true);
                                }
                                bool res = await widget.identityApi
                                    .signUpVerifyEmail(SignUpVerifyEmailRequest(
                                        email: state.str, code: code));

                                if (mounted) {
                                  setState(() => isLoading = false);
                                }

                                if (!mounted) return;
                                if (res == true) {
                                  _navigateToCreateAccount();
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "The code is invalid",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: whiteColor,
                                      fontSize: 16.0);
                                }
                              });
                            }),
                    ],
                  ),
                  Spacer(flex: 1),
                  BlocBuilder<VerificationEmailPhoneBloc,
                      VerificationEmailPhoneState>(builder: (context, state) {
                    return ResendEmailButton(
                      onTriggered: () async {
                        setState(() => isLoading = true);
                        await widget.identityApi.signUpStartEmailVerification(
                            StartSignUpEmailVerificationRequest(
                                email: state.str));
                        setState(() => isLoading = false);
                      },
                    );
                  }),
                ])));
  }
}
