import 'package:flutter/material.dart';
import 'package:mtaa_frontend/core/constants/validators.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/customPasswordInput.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/customTextInput.dart';

/// Form widget for user login input fields.
class StartLogInForm extends StatelessWidget {
  final TextEditingController loginController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  /// Creates a [StartLogInForm] with required form key and controllers.
  const StartLogInForm({
    super.key,
    required this.formKey,
    required this.loginController,
    required this.passwordController,
  });

  /// Builds the UI with email/phone and password input fields.
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints.tightFor(width: 300),
            child: CustomTextInput(
                placeholder: 'Email or Phone Number',
                validator: loginValidator,
                textInputType: TextInputType.name,
                controller: loginController),
          ),
          const SizedBox(height: 16),
          ConstrainedBox(
              constraints: const BoxConstraints.tightFor(width: 300),
              child: CustomPasswordInput(
                  validator: passwordValidator,
                  textInputType: TextInputType.visiblePassword,
                  controller: passwordController)),
          const SizedBox(height: 8),
          ConstrainedBox(
            constraints: const BoxConstraints.tightFor(width: 300),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Forgot Password?',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
