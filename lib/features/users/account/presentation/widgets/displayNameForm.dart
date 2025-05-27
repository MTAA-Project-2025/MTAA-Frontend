import 'package:flutter/material.dart';
import 'package:mtaa_frontend/core/constants/validators.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/customTextInput.dart';

/// Form widget for entering a display name.
class DisplayNameForm extends StatelessWidget {
  final TextEditingController displayNameController;
  final GlobalKey<FormState> formKey;

  /// Creates a [DisplayNameForm] with required form key and controller.
  const DisplayNameForm({
    super.key,
    required this.formKey,
    required this.displayNameController,
  });

  /// Builds the UI with a constrained text input for display name.
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
                validator: abstractNameValidator,
                textInputType: TextInputType.name,
                controller: displayNameController),
          ),
        ],
      ),
    );
  }
}
