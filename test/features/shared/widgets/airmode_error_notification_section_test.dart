import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_bloc.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/airmode_error_notification_section.dart';
import 'package:mtaa_frontend/themes/app_theme.dart';

void main() {
  late ExceptionsBloc mockBloc;
  late bool tryAgainCalled;

  setUp(() {
    mockBloc = ExceptionsBloc();
    tryAgainCalled = false;
  });

  testWidgets('AirModeErrorNotificationSectionWidget renders correctly and responds to Try again', (WidgetTester tester) async {
    await tester.pumpWidget(Builder(builder: (context) {
      return MaterialApp(
        theme: AppTheme.lightTheme(context),
        home: BlocProvider<ExceptionsBloc>.value(
          value: mockBloc,
          child: AirModeErrorNotificationSectionWidget(
            onPressed: () {
              tryAgainCalled = true;
            },
          ),
        ),
      );
    }));

    expect(find.text('You are in airplane mode'), findsOneWidget);
    expect(find.text('Please turn off airplane mode to load new posts'), findsOneWidget);
    expect(find.text('Open settings'), findsOneWidget);
    expect(find.text('Try again'), findsOneWidget);

    await tester.tap(find.text('Try again'));
    await tester.pump();

    expect(tryAgainCalled, true);
  });
}
