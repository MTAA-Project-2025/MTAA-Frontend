import 'package:flutter/material.dart';
import 'package:mtaa_frontend/core/constants/validators.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/customPasswordInput.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/customTextInput.dart';

/// Form widget for creating a new account with username and password inputs.
class CreateAccountForm extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  /// Creates a [CreateAccountForm] with required form key and controllers.
  const CreateAccountForm({
    super.key,
    required this.formKey,
    required this.usernameController,
    required this.passwordController,
  });

  /// Builds the UI with constrained username and password input fields.
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints.tightFor(width: 300),
            child: CustomTextInput(
                placeholder: 'Username',
                validator: usernameValidator,
                textInputType: TextInputType.name,
                controller: usernameController),
          ),
          const SizedBox(height: 16),
          ConstrainedBox(
              constraints: const BoxConstraints.tightFor(width: 300),
              child: CustomPasswordInput(
                  validator: passwordValidator,
                  textInputType: TextInputType.visiblePassword,
                  controller: passwordController)),
        ],
      ),
    );
  }
}
