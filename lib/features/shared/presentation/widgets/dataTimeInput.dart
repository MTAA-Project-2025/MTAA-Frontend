import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mtaa_frontend/core/constants/colors.dart';

class DateTimeInput extends StatefulWidget {
  final void Function(DateTime) onChanged;
  final String placeholder;

  DateTimeInput({super.key, required this.onChanged, required this.placeholder});

  @override
  _DateTimeInputState createState() => _DateTimeInputState();
}

class _DateTimeInputState extends State<DateTimeInput> {
  bool isFirstTime = true;
  DateTime date = DateTime.now();
  DateTime minDate = DateTime(1900);
  DateTime maxDisplayedDate = DateTime.now().add(Duration(days: 10));
  DateTime maxDate = DateTime.now();

  bool _decideWhichDayToEnable(DateTime day) {
    if ((day.isAfter(minDate) && day.isBefore(maxDate))) {
      return true;
    }
    return false;
  }

  _selectDate(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    assert(theme.platform != null);
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
                  width: double.infinity, // Occupy all available space
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
                                  fontFamily: 'Almarai',
                                )))
                        : OutlinedButton(
                            onPressed: () => _selectDate(context),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: primarily0InvincibleColor), // Border color
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8), // Rounded corners
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
                                  fontFamily: 'Almarai',
                                ))),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  buildCupertinoDatePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (picked) {
                if (picked != date) {
                  setState(() {
                    date = picked;
                    isFirstTime = false;
                  });
                  widget.onChanged(date);
                }
              },
              initialDateTime: date,
              minimumYear: minDate.year,
              maximumYear: maxDisplayedDate.year + 1,
            ),
          );
        });
  }

  buildMaterialDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: date,
      firstDate: minDate,
      lastDate: maxDisplayedDate,
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
      setState(() {
        date = picked;
        isFirstTime = false;
      });
      widget.onChanged(date);
    }
  }
}
