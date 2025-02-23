import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mtaa_frontend/core/constants/colors.dart';

class CustomPasswordInput extends StatefulWidget {
  final String placeholder;
  final MultiValidator? validator;
  final TextInputType textInputType;
  final TextEditingController controller;

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

class _CustomPasswordInputState extends State<CustomPasswordInput> {
  bool _isFocused = false;
  bool passwordVisible = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: Focus(
        onFocusChange: (focus) => setState(() => _isFocused = focus),
        child: TextFormField(
          obscureText: passwordVisible,
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
              icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
              color: Theme.of(context).textTheme.labelMedium?.decorationColor,
              onPressed: () {
                setState(
                  () {
                    passwordVisible = !passwordVisible;
                  },
                );
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
                color: Colors.red,
                width: 2,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
