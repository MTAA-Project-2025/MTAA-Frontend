import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/dataTimeInput.dart';
import 'package:mtaa_frontend/themes/app_theme.dart';

void main() {
  testWidgets('DateTimeInput renders and responds to actions', (WidgetTester tester) async {
    late DateTime selectedDate;

    final minDate = DateTime(2000, 1, 1);
    final maxDate = DateTime(2030, 12, 31);
    final maxDisplayedDate = DateTime(2025, 12, 31);
    final today = DateTime.now();

    await tester.pumpWidget(Builder(builder: (context) {
      return (MaterialApp(
        theme: AppTheme.lightTheme(context),
        home: Scaffold(
          body: DateTimeInput(
            placeholder: 'Select a date',
            minDate: minDate,
            maxDate: maxDate,
            maxDisplayedDate: maxDisplayedDate,
            onChanged: (date) {
              selectedDate = date;
            },
          ),
        ),
      ));
    }));

    expect(find.text('Select a date'), findsOneWidget);
    await tester.tap(find.byType(OutlinedButton));
    await tester.pumpAndSettle();

    final validDay = today.isAfter(minDate) && today.isBefore(maxDate)
        ? today
        : minDate.add(const Duration(days: 1));

    await tester.tap(find.text('${validDay.day}'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Select'));
    await tester.pumpAndSettle();

    final formattedDate = '${validDay.year}-${validDay.month}-${validDay.day}';
    expect(find.text(formattedDate), findsOneWidget);
    expect(selectedDate.year, validDay.year);
  });
}
