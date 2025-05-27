import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/customPasswordInput.dart';
import 'package:mtaa_frontend/themes/app_theme.dart';

void main() {
  testWidgets('CustomPasswordInput renders and responds to actions', (WidgetTester tester) async {
    final controller = TextEditingController(text: '');

    await tester.pumpWidget(Builder(builder: (context) {
      return (MaterialApp(
        theme: AppTheme.lightTheme(context),
        home: Scaffold(
          body: CustomPasswordInput(
            placeholder: 'Password',
            controller: controller,
            textInputType: TextInputType.visiblePassword,
          ),
        ),
      ));
    }));

    expect(find.text('Password'), findsOneWidget);
    expect(find.byType(TextFormField), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), '1234578');
    await tester.pump();

    EditableText field = tester.widget(find.byType(EditableText));
    expect(field.obscureText, isTrue);

    await tester.tap(find.byKey(Key('password_visibility_toggle')));
    await tester.pump();

    field = tester.widget(find.byType(EditableText));
    expect(field.obscureText, isFalse);

    await tester.tap(find.byKey(Key('password_visibility_toggle')));
    await tester.pump();

    field = tester.widget(find.byType(EditableText));
    expect(field.obscureText, isTrue);
    expect(controller.text, '1234578');
  });
}
