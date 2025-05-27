import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mtaa_frontend/main.dart';

import '../../configuration/account_test_data.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Full log in process', (tester) async {
    await tester.pumpWidget(await createApp());
    await tester.pumpAndSettle();

    expect(find.text('Log In'), findsOneWidget);
    await tester.tap(find.text('Log In'));
    await tester.pumpAndSettle();

    expect(find.byKey(Key('custom_text_input_field')), findsOneWidget);
    await tester.enterText(find.byKey(Key('custom_text_input_field')), testAccountEmail);

    expect(find.byKey(Key('password_input_field')), findsOneWidget);
    await tester.enterText(find.byKey(Key('password_input_field')), testAccountPassword);

    expect(find.text('Start'), findsOneWidget);
    await tester.tap(find.text('Start'));
    await tester.pumpAndSettle();
    expect(find.text('Settings'), findsOneWidget);
  });
}
