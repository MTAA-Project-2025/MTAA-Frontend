import 'package:flutter/material.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/dataTimeInput.dart';

class BirthDateForm extends StatefulWidget {
  final void Function(DateTime) onChanged;
  final GlobalKey<FormState> formKey;

  const BirthDateForm({super.key, required this.formKey, required this.onChanged});

  @override
  State<BirthDateForm> createState() => _BirthDateFormState();
}

class _BirthDateFormState extends State<BirthDateForm> {
  DateTime? birthDate;
  bool isError = false;

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
                placeholder: 'Select your birth date',
                onChanged: (date) async {
                  birthDate = date;
                  widget.onChanged(date);
                }),
          )
        ],
      ),
    );
  }
}
