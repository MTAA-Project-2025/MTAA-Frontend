import 'package:flutter/material.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/dataTimeInput.dart';

/// Form widget for selecting a birth date.
class BirthDateForm extends StatefulWidget {
  final void Function(DateTime) onChanged;
  final GlobalKey<FormState> formKey;
  final String placeholder;

  /// Creates a [BirthDateForm] with required form key and change callback.
  const BirthDateForm({
    super.key,
    required this.formKey,
    required this.onChanged,
    this.placeholder = 'Select your birth date',
  });

  @override
  State<BirthDateForm> createState() => _BirthDateFormState();
}

/// Manages the state for birth date selection.
class _BirthDateFormState extends State<BirthDateForm> {
  DateTime? birthDate;
  bool isError = false;

  /// Builds the UI with a date input field.
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 12),
          SizedBox(
            height: 65,
            child: DateTimeInput(
                placeholder: widget.placeholder,
                onChanged: (date) async {
                  birthDate = date;
                  widget.onChanged(date);
                },
                minDate: DateTime(1900),
                maxDisplayedDate: DateTime.now().add(Duration(days: 10)),
                maxDate: DateTime.now()),
          )
        ],
      ),
    );
  }
}
