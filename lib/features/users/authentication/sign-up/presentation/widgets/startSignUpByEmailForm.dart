import 'package:flutter/material.dart';
import 'package:mtaa_frontend/core/constants/validators.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/customTextInput.dart';

/// Form widget for entering an email address during signup.
class StartSignUpByEmailForm extends StatelessWidget {
  final TextEditingController emailController;
  final GlobalKey<FormState> formKey;

  /// Creates a [StartSignUpByEmailForm] with required form key and controller.
  const StartSignUpByEmailForm({
    super.key,
    required this.formKey,
    required this.emailController,
  });

  /// Builds the UI with a single email input field.
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
            CustomTextInput(
              placeholder: 'Email',
              validator: emailValidator,
              textInputType: TextInputType.emailAddress,
              controller: emailController
            )
        ],
      ),
    );
  }
}
