import 'package:flutter/material.dart';
import 'package:mtaa_frontend/core/constants/validators.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/customTextInput.dart';

class DisplayNameForm extends StatelessWidget {
  final TextEditingController displayNameController;

  const DisplayNameForm({
    super.key,
    required this.formKey,
    required this.displayNameController,
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
                placeholder: 'Display Name',
                validator: usernameValidator,
                textInputType: TextInputType.name,
                controller: displayNameController),
          ),
        ],
      ),
    );
  }
}
