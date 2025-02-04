import 'package:flutter/material.dart';
import 'package:mtaa_frontend/core/constants/validators.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/customTextInput.dart';

class StartSignUpByEmailForm extends StatelessWidget {
  final TextEditingController emailController;

  const StartSignUpByEmailForm({
    super.key,
    required this.formKey,
    required this.emailController,
  });

  final GlobalKey<FormState> formKey;
  
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
