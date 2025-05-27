import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/customTextInput.dart';
import 'package:mtaa_frontend/themes/app_theme.dart';

void main() {
  testWidgets('CustomTextInput renders and responds to actions', (WidgetTester tester) async {
    final controller = TextEditingController(text: '');

    await tester.pumpWidget(Builder(builder: (context) {
      return (MaterialApp(
        theme: AppTheme.lightTheme(context),
        home: Scaffold(
          body: CustomTextInput(
            placeholder: 'Test Input',
            controller: controller,
            textInputType: TextInputType.text,
            maxLines: 10,
            minLines: 5,
          ),
        ),
      ));
    }));

    expect(find.text('Test Input'), findsOneWidget);
    expect(find.byType(TextFormField), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), 'text');
    await tester.pump();

    EditableText field = tester.widget(find.byType(EditableText));
    expect(field.minLines, 5);
    expect(field.maxLines, 10);
    expect(controller.text, 'text');
  });
}
