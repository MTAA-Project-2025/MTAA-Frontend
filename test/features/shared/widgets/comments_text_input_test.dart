import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/commentsTextInput.dart';
import 'package:mtaa_frontend/themes/app_theme.dart';

void main() {
  testWidgets('CommentsTextInput renders and responds to actions', (WidgetTester tester) async {
    final controller = TextEditingController(text: '');
    bool cancelCalled = false;
    bool sendCalled = false;

    await tester.pumpWidget(Builder(builder: (context) {
      return (MaterialApp(
        theme: AppTheme.lightTheme(context),
        home: Scaffold(
          body: CommentsTextInput(
            placeholder: 'Write a comment...',
            controller: controller,
            isEnabled: true,
            minLines: 1,
            maxLines: 5,
            onCancel: () => cancelCalled = true,
            onSend: () => sendCalled = true,
          ),
        ),
      ));
    }));

    expect(find.text('Write a comment...'), findsOneWidget);
    expect(find.byType(TextFormField), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), 'Test comment');
    await tester.pump();

    expect(find.text('Cancel'), findsOneWidget);
    expect(find.text('Save'), findsOneWidget);

    await tester.tap(find.text('Cancel'));
    await tester.pump();
    expect(cancelCalled, true);

    await tester.tap(find.text('Save'));
    await tester.pump();
    expect(sendCalled, true);
    expect(controller.text, 'Test comment');
  });
}
