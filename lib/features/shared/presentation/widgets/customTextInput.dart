import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mtaa_frontend/core/constants/colors.dart';

class CustomTextInput extends StatefulWidget {
  final String placeholder;
  final MultiValidator? validator;
  final TextInputType textInputType;
  final TextEditingController controller;
  final int? minLines;
  final int? maxLines;

  const CustomTextInput({
    super.key,
    required this.placeholder,
    this.validator,
    this.textInputType = TextInputType.text,
    required this.controller,
    this.minLines,
    this.maxLines,
  });

  @override
  State<CustomTextInput> createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  bool _isFocused = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: Focus(
        onFocusChange: (focus) => setState(() => _isFocused = focus),
        child: TextFormField(
          key: const Key('custom_text_input_field'),
          validator: widget.validator?.call,
          style: Theme.of(context).textTheme.bodyMedium,
          cursorColor: Theme.of(context).textTheme.labelMedium?.decorationColor,
          controller:widget.controller,
          minLines: widget.minLines,
          maxLines: widget.maxLines,
          decoration: InputDecoration(
            labelText: widget.placeholder,
            labelStyle: TextStyle(
              fontSize: Theme.of(context).textTheme.labelMedium?.fontSize,
              color: _isFocused || widget.controller.text.isNotEmpty
                  ? Theme.of(context).textTheme.labelMedium?.decorationColor
                  : Theme.of(context).textTheme.labelMedium?.color,
              fontFamily: 'Almarai',
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