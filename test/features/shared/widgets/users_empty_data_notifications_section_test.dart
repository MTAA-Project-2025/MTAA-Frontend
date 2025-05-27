import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mtaa_frontend/features/shared/bloc/exceptions_bloc.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/users_empty_data_notifications_section.dart';
import 'package:mtaa_frontend/themes/app_theme.dart';

void main() {
  late ExceptionsBloc mockBloc;

  setUp(() {
    mockBloc = ExceptionsBloc();
  });

  testWidgets('UsersEmptyErrorNotificationSectionWidget renders correctly and responds to Try again', (WidgetTester tester) async {
    await tester.pumpWidget(Builder(builder: (context) {
      return MaterialApp(
        theme: AppTheme.lightTheme(context),
        home: BlocProvider<ExceptionsBloc>.value(
          value: mockBloc,
          child: SingleChildScrollView(
                child: UsersEmptyErrorNotificationSectionWidget(
              title: 'No Users Found',
              onPressed: () {},
            ))),
      );
    }));

    expect(find.text('No Users Found'), findsOneWidget);
    expect(find.text('Try again'), findsOneWidget);
  });
}
