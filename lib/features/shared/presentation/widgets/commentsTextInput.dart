import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mtaa_frontend/core/constants/colors.dart';

/// A text input field for entering comments with cancel and save actions.
class CommentsTextInput extends StatefulWidget {
  final String placeholder;
  final MultiValidator? validator;
  final TextInputType textInputType;
  final TextEditingController controller;
  final int? minLines;
  final int? maxLines;
  final bool isEnabled;
  final void Function() onCancel;
  final void Function() onSend;
  final bool isLoading;

  /// Creates a [CommentsTextInput] with required properties and callbacks.
  const CommentsTextInput({
    super.key,
    required this.placeholder,
    this.validator,
    this.textInputType = TextInputType.text,
    required this.controller,
    this.minLines,
    this.maxLines,
    required this.isEnabled,
    required this.onCancel,
    required this.onSend,
    this.isLoading = false,
  });

  @override
  State<CommentsTextInput> createState() => _CommentsTextInputState();
}

/// Manages the state for the comment input field, including focus and button visibility.
class _CommentsTextInputState extends State<CommentsTextInput> {
  bool _isFocused = false;

  /// Cleans up resources on widget disposal.
  @override
  void dispose() {
    super.dispose();
  }

  /// Builds the UI with a text input field and conditional action buttons.
  @override
  Widget build(BuildContext context) {
    return FocusScope(
        child: Stack(children: [
      Focus(
        onFocusChange: (focus) => setState(() => _isFocused = focus),
        child: TextFormField(
          validator: widget.validator?.call,
          style: Theme.of(context).textTheme.bodyMedium,
          cursorColor: Theme.of(context).textTheme.labelMedium?.decorationColor,
          controller: widget.controller,
          minLines: widget.isEnabled || _isFocused || widget.controller.text.isNotEmpty ? widget.minLines : null,
          maxLines: widget.isEnabled || _isFocused || widget.controller.text.isNotEmpty ? widget.maxLines : null,
          decoration: InputDecoration(
            labelText: widget.placeholder,
            labelStyle: TextStyle(
              fontSize: Theme.of(context).textTheme.labelMedium?.fontSize,
              color: _isFocused || widget.controller.text.isNotEmpty ? Theme.of(context).textTheme.labelMedium?.decorationColor : Theme.of(context).textTheme.labelMedium?.color,
            ),
            filled: true,
            fillColor: Theme.of(context).scaffoldBackgroundColor,
            contentPadding: const EdgeInsets.fromLTRB(10, 28, 8, 16),
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
      if (widget.isEnabled || _isFocused || widget.controller.text.isNotEmpty)
        Positioned(
            bottom: 10,
            right: 10,
            child: Row(
              children: [
                TextButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    widget.onCancel();
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.secondary,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    minimumSize: Size(0, 0),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                  child: Text(
                    'Cancel',
                  ),
                ),
                const SizedBox(width: 5),
                TextButton(
                  onPressed: () {
                    if (widget.isLoading) return;
                    FocusScope.of(context).unfocus();
                    widget.onSend();
                  },
                  style: Theme.of(context).textButtonTheme.style!.copyWith(
                        minimumSize: WidgetStateProperty.all(Size(0, 0)),
                        padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                      ),
                  child: widget.isLoading
                      ? CircularProgressIndicator()
                      : Text(
                          'Save',
                        ),
                ),
              ],
            ))
    ]));
  }
}
