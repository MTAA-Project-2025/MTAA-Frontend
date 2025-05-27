import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/full_data_time_input.dart';
import 'package:mtaa_frontend/themes/app_theme.dart';

void main() {
  testWidgets('FullDateTimeInput renders and responds to actions', (WidgetTester tester) async {
    late DateTime selectedDate;

    final minDate = DateTime(2000, 1, 1);
    final maxDate = DateTime(2030, 12, 31);
    final maxDisplayedDate = DateTime(2025, 12, 31);
    final today = DateTime.now();

    await tester.pumpWidget(Builder(builder: (context) {
      return (MaterialApp(
        theme: AppTheme.lightTheme(context),
        home: Scaffold(
          body: FullDateTimeInput(
            placeholder: 'Select a date',
            minDate: minDate,
            maxDate: maxDate,
            maxDisplayedDate: maxDisplayedDate,
            onChanged: (date) {
              selectedDate = date;
            },
            initialIsFirstTime: false,
            initialDate: today,
          ),
        ),
      ));
    }));
    await tester.tap(find.byKey(Key('select_date_button')));
    await tester.pumpAndSettle();

    final validDay = today.isAfter(minDate) && today.isBefore(maxDate)
        ? today
        : minDate.add(const Duration(days: 1));

    await tester.tap(find.text('${validDay.day}'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Select'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    final formattedDate = '${validDay.year}-${validDay.month}-${validDay.day}-${validDay.hour}:${validDay.minute}';
    expect(find.text(formattedDate), findsOneWidget);

    expect(selectedDate.year, today.year);
    expect(selectedDate.month, today.month);
    expect(selectedDate.day, today.day);
    expect(selectedDate.hour, today.hour);
  });
}
