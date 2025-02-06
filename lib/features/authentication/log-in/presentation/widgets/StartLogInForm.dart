import 'package:flutter/material.dart';
import 'package:mtaa_frontend/core/constants/validators.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/customPasswordInput.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/customTextInput.dart';

class StartLogInForm extends StatelessWidget {
  final TextEditingController loginController;
  final TextEditingController passwordController;

  const StartLogInForm({
    super.key,
    required this.formKey,
    required this.loginController,
    required this.passwordController,
  });

  final GlobalKey<FormState> formKey;

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
                  validator: passwordLogInValidator,
                  textInputType: TextInputType.visiblePassword,
                  controller: passwordController)),
          const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
              'Forgot Password?',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
        ],
      ),
    );
  }
}
