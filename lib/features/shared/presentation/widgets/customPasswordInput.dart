import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mtaa_frontend/core/constants/colors.dart';

/// A customizable password input field with visibility toggle.
class CustomPasswordInput extends StatefulWidget {
  final String placeholder;
  final MultiValidator? validator;
  final TextInputType textInputType;
  final TextEditingController controller;

  /// Creates a [CustomPasswordInput] with required properties and optional validation.
  const CustomPasswordInput({
    super.key,
    this.placeholder = 'Password',
    this.validator,
    this.textInputType = TextInputType.text,
    required this.controller,
  });

  @override
  State<CustomPasswordInput> createState() => _CustomPasswordInputState();
}

/// Manages the state for the password input field, including focus and visibility.
class _CustomPasswordInputState extends State<CustomPasswordInput> {
  bool _isFocused = false;
  bool passwordVisible = false;

  /// Cleans up resources on widget disposal.
  @override
  void dispose() {
    super.dispose();
  }

  /// Initializes state with password visibility set to hidden.
  @override
  void initState() {
    super.initState();
    passwordVisible = false;
  }

  /// Builds the UI with a password input field and visibility toggle icon.
  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: Focus(
        onFocusChange: (focus) => setState(() => _isFocused = focus),
        child: TextFormField(
          key: const Key('password_input_field'),
          obscureText: !passwordVisible,
          validator: widget.validator?.call,
          style: Theme.of(context).textTheme.bodyMedium,
          cursorColor: Theme.of(context).textTheme.labelMedium?.decorationColor,
          controller: widget.controller,
          decoration: InputDecoration(
            labelText: widget.placeholder,
            labelStyle: TextStyle(
              fontSize: Theme.of(context).textTheme.labelMedium?.fontSize,
              color: _isFocused || widget.controller.text.isNotEmpty
                  ? Theme.of(context).textTheme.labelMedium?.decorationColor
                  : Theme.of(context).textTheme.labelMedium?.color,
            ),
            suffixIcon: IconButton(
              key: const Key('password_visibility_toggle'),
              icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
              color: Theme.of(context).textTheme.labelMedium?.decorationColor,
              onPressed: () {
                if (!mounted) return;
                setState(() {
                  passwordVisible = !passwordVisible;
                });
              },
            ),
            filled: true,
            fillColor: Theme.of(context).scaffoldBackgroundColor,
            contentPadding: const EdgeInsets.fromLTRB(28, 28, 12, 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: primarily0InvincibleColor,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: secondary1InvincibleColor,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: errorColor,
                width: 2,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: errorColor,
                width: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
