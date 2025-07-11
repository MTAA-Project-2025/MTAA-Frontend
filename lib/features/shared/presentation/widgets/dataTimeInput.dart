import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mtaa_frontend/core/constants/colors.dart';

/// A date input widget that supports platform-specific date pickers.
class DateTimeInput extends StatefulWidget {
  final void Function(DateTime) onChanged;
  final String placeholder;
  final DateTime minDate;
  final DateTime maxDate;
  final DateTime maxDisplayedDate;

  /// Creates a [DateTimeInput] with required properties and callback.
  DateTimeInput({
    super.key,
    required this.onChanged,
    required this.placeholder,
    required this.minDate,
    required this.maxDate,
    required this.maxDisplayedDate,
  });

  @override
  _DateTimeInputState createState() => _DateTimeInputState();
}

// Created partly with GPT
/// Manages the state for the date input, including date selection and picker display.
class _DateTimeInputState extends State<DateTimeInput> {
  bool isFirstTime = true;
  DateTime date = DateTime.now();

  /// Determines if a day is selectable based on min and max date constraints.
  bool _decideWhichDayToEnable(DateTime day) {
    if ((day.isAfter(widget.minDate) && day.isBefore(widget.maxDate))) {
      return true;
    }
    return false;
  }

  /// Selects the appropriate date picker based on the platform.
  _selectDate(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return buildMaterialDatePicker(context);
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return buildCupertinoDatePicker(context);
    }
  }

  /// Builds the UI with a button displaying the selected date or placeholder.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            ConstrainedBox(
                constraints: const BoxConstraints.tightFor(width: 250),
                child: SizedBox(
                  width: double.infinity,
                  child: FocusScope(
                    child: isFirstTime
                        ? OutlinedButton(
                            onPressed: () => _selectDate(context),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: primarily0InvincibleColor),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              foregroundColor: Theme.of(context).colorScheme.secondary,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                            ),
                            child: Text(widget.placeholder,
                                style: TextStyle(
                                  fontSize: Theme.of(context).textTheme.labelMedium?.fontSize,
                                  fontWeight: FontWeight.w500,
                                  color: !isFirstTime ? Theme.of(context).textTheme.labelMedium?.decorationColor : Theme.of(context).textTheme.labelMedium?.color,
                                )))
                        : OutlinedButton(
                            onPressed: () => _selectDate(context),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: primarily0InvincibleColor),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              foregroundColor: Theme.of(context).colorScheme.secondary,
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                            ),
                            child: Text('${date.year}-${date.month}-${date.day}',
                                style: TextStyle(
                                  fontSize: Theme.of(context).textTheme.labelMedium?.fontSize,
                                  fontWeight: FontWeight.w500,
                                  color: !isFirstTime ? Theme.of(context).textTheme.labelMedium?.decorationColor : Theme.of(context).textTheme.labelMedium?.color,
                                ))),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  /// Displays a Cupertino-style date picker for iOS/macOS platforms.
  buildCupertinoDatePicker(BuildContext context) {
    if (!context.mounted) return;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: whiteColor,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (picked) {
                if (picked != date) {
                  if(!mounted)return;
                  setState(() {
                    date = picked;
                    isFirstTime = false;
                  });
                  widget.onChanged(date);
                }
              },
              initialDateTime: date,
              minimumYear: widget.minDate.year,
              maximumYear: widget.maxDisplayedDate.year + 1,
            ),
          );
        });
  }

  /// Displays a Material-style date picker for Android and other platforms.
  buildMaterialDatePicker(BuildContext context) async {
    if (!context.mounted) return;
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: widget.minDate,
      lastDate: widget.maxDisplayedDate,
      initialEntryMode: DatePickerEntryMode.calendar,
      initialDatePickerMode: DatePickerMode.day,
      selectableDayPredicate: _decideWhichDayToEnable,
      helpText: 'Select date',
      cancelText: 'Not now',
      confirmText: 'Select',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter date in valid range',
      fieldLabelText: 'Date',
      fieldHintText: 'Month/Date/Year',
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(),
          child: child ?? Container(),
        );
      },
    );
    if (picked != null && picked != date) {
      if (!mounted) return;
      setState(() {
        date = picked;
        isFirstTime = false;
      });
      widget.onChanged(date);
    }
  }
}
