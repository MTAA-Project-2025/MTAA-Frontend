import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mtaa_frontend/core/constants/colors.dart';
import 'package:mtaa_frontend/core/constants/route_constants.dart';
import 'package:mtaa_frontend/features/authentication/shared/blocs/verification_email_phone_bloc.dart';
import 'package:mtaa_frontend/features/authentication/shared/blocs/verification_email_phone_event.dart';
import 'package:mtaa_frontend/features/authentication/shared/data/network/identity_api.dart';
import 'package:mtaa_frontend/features/authentication/sign-up/data/models/requests/startSignUpEmailVerificationRequest.dart';
import 'package:mtaa_frontend/features/authentication/sign-up/presentation/widgets/startSignUpByEmailForm.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/dotLoader.dart';
import 'package:mtaa_frontend/themes/bloc/theme_bloc.dart';
import 'package:mtaa_frontend/themes/bloc/theme_event.dart';
import 'package:mtaa_frontend/themes/button_theme.dart';

class StartSignUpPage extends StatefulWidget {
  final IdentityApi identityApi;

  const StartSignUpPage({super.key, required this.identityApi});

  @override
  State<StartSignUpPage> createState() => _StartSignUpPageState();
}

class _StartSignUpPageState extends State<StartSignUpPage> {
  final GlobalKey<FormState> _emailformKey = GlobalKey<FormState>();
  bool isShowEmailForm = true;
  final emailController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final emailPhoneBloc = context.read<VerificationEmailPhoneBloc>();

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
                  'Enter phone or email',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: 14),
                ConstrainedBox(
                    constraints: const BoxConstraints.tightFor(width: 400),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          height: 43,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                            color: Theme.of(context).secondaryHeaderColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        isShowEmailForm = true;
                                      });
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor: isShowEmailForm
                                          ? whiteColor
                                          : whiteColor,
                                      backgroundColor: isShowEmailForm
                                          ? secondary1InvincibleColor
                                          : Theme.of(context)
                                              .secondaryHeaderColor,
                                      textStyle: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text('Email'),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        isShowEmailForm = false;
                                      });
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor: !isShowEmailForm
                                          ? whiteColor
                                          : whiteColor,
                                      backgroundColor: !isShowEmailForm
                                          ? secondary1InvincibleColor
                                          : Theme.of(context)
                                              .secondaryHeaderColor,
                                      textStyle: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    child: const Text('Phone'),
                                  )),
                            ],
                          ),
                        ),
                        const SizedBox(height: 19),
                        isShowEmailForm
                            ? StartSignUpByEmailForm(
                                formKey: _emailformKey,
                                emailController: emailController)
                            : const SizedBox(
                                height: 10), //TODO: change to LogInByPhoneForm,
                        const SizedBox(height: 4),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'View Terms of Service and Privacy Policy',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ), //Todo % change to navigation to privacy policy
                      ],
                    )),
                const SizedBox(height: 19),
                isLoading
                    ? const DotLoader()
                    : TextButton(
                        onPressed: () async {
                          if (_emailformKey.currentState!.validate()) {
                            setState(() => isLoading = true);
                            emailPhoneBloc.add(SetVerificationEmailPhoneEvent(
                                emailController.text));
                            bool res = await widget.identityApi
                                .signUpStartEmailVerification(
                                    StartSignUpEmailVerificationRequest(
                                        email: emailController.text));
                            setState(() => isLoading = false);
                            if (res == true) {
                              GoRouter.of(context)
                                  .push(signUpVerificationByEmailScreenRoute);
                            }
                          }
                        },
                        style: specialTextButtonThemeData.style,
                        child: Text(
                          'Next',
                        ),
                      ),
              ],
            ),
          )),
    );
  }
}
