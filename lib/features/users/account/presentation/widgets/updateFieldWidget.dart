import 'package:flutter/material.dart';
import 'package:mtaa_frontend/core/constants/colors.dart';

class ProfileFieldEditor extends StatelessWidget {
  final TextEditingController controller;
  final String iconPath;
  final String label;
  final String hintText;
  final bool isDate;
  final Function(DateTime)? onDateSelected;
  final TextInputType keyboardType;

  const ProfileFieldEditor({
    Key? key,
    required this.controller,
    required this.iconPath,
    required this.label,
    required this.hintText,
    this.isDate = false,
    this.onDateSelected,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          iconPath,
          width: 30,
          height: 30,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: primarily0InvincibleColor,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
              isDate
                  ? GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: _buildTextField(),
                      ),
                    )
                  : _buildTextField(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextField() {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color.fromRGBO(204, 204, 204, 1),
          fontSize: 14,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 8),
        isDense: true,
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1)),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color.fromRGBO(238, 238, 238, 1)),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: lightSecondary1Color, width: 2),
        ),
      ),
      style: const TextStyle(
        color: lightPrimarily1Color,
        fontSize: 16,
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    if (!isDate || onDateSelected == null) return;

    DateTime initialDate;
    try {
      final parts = controller.text.split('/');
      if (parts.length == 3) {
        final day = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        final year = int.parse(parts[2]);
        initialDate = DateTime(year, month, day);
      } else {
        initialDate = DateTime.now();
      }
    } catch (e) {
      initialDate = DateTime.now();
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: lightSecondary1Color,
              onPrimary: whiteColor,
              onSurface: lightPrimarily1Color,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: lightSecondary1Color,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      onDateSelected!(picked);
    }
  }
}
