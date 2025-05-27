import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_bloc.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/empty_data_notification_section.dart';
import 'package:mtaa_frontend/themes/app_theme.dart';

void main() {
  late ExceptionsBloc mockBloc;

  setUp(() {
    mockBloc = ExceptionsBloc();
  });

  testWidgets('EmptyErrorNotificationSectionWidget renders correctly and responds to Try again', (WidgetTester tester) async {
    await tester.pumpWidget(Builder(builder: (context) {
      return MaterialApp(
        theme: AppTheme.lightTheme(context),
        home: BlocProvider<ExceptionsBloc>.value(
            value: mockBloc,
            child: SingleChildScrollView(
                child: EmptyErrorNotificationSectionWidget(
              title: 'No Posts Found',
              onPressed: () {},
            ))),
      );
    }));

    expect(find.text('No Posts Found'), findsOneWidget);
    expect(find.text('Try again'), findsOneWidget);
  });
}
