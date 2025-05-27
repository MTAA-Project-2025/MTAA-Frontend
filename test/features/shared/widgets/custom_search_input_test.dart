import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mtaa_frontend/features/shared/presentation/widgets/customSearchInput.dart';
import 'package:mtaa_frontend/themes/app_theme.dart';

void main() {
  bool isSearched = false;
  testWidgets('CustomSearchInput renders and responds to actions', (WidgetTester tester) async {
    final controller = TextEditingController(text: '');

    await tester.pumpWidget(Builder(builder: (context) {
      return (MaterialApp(
        theme: AppTheme.lightTheme(context),
        home: Scaffold(
          body: CustomSearchInput(
            placeholder: 'Search',
            controller: controller,
            textInputType: TextInputType.visiblePassword,
            onSearch: () {
              isSearched=true;
            },
          ),
        ),
      ));
    }));

    expect(find.text('Search'), findsOneWidget);
    expect(find.byType(TextFormField), findsOneWidget);

    await tester.enterText(find.byType(TextFormField), 'Text');
    await tester.pump();

    await tester.tap(find.byKey(Key('search_icon')));
    await tester.pump();

    expect(isSearched, isTrue);
    expect(controller.text, 'Text');
  });
}
