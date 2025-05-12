import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:mtaa_frontend/core/constants/colors.dart';

class CustomSearchInput extends StatefulWidget {
  final String placeholder;
  final MultiValidator? validator;
  final TextInputType textInputType;
  final TextEditingController controller;
  final void Function() onSearch;

  const CustomSearchInput({
    super.key,
    this.placeholder = 'Search',
    this.validator,
    this.textInputType = TextInputType.text,
    required this.onSearch,
    required this.controller,
  });

  @override
  State<CustomSearchInput> createState() => _CustomSearchInputState();
}

class _CustomSearchInputState extends State<CustomSearchInput> {
  bool _isFocused = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: Focus(
        onFocusChange: (focus) {
          if(!mounted)return;
          setState(() => _isFocused = focus);
          if(!_isFocused){
            widget.onSearch.call();
          }
        },
        child: TextFormField(
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
            prefixIcon: IconButton(
              icon: Icon(Icons.search_rounded),
              color: Theme.of(context).textTheme.labelMedium?.decorationColor,
              onPressed: () {
                if(!mounted)return;
                setState(
                  () {
                    _isFocused=!_isFocused;
                    widget.onSearch.call();
                  },
                );
              },
            ),
            filled: true,
            fillColor: Theme.of(context).scaffoldBackgroundColor,
            contentPadding: const EdgeInsets.fromLTRB(15, 15, 12, 16),
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
