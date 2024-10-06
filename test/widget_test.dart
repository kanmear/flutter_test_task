import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:live_beer/ui/widgets/custom_button.dart';
import 'package:live_beer/ui/widgets/toggle_error_text.dart';

import 'package:live_beer/routes/pages/authorization_page/authorization_page.dart';

void main() {
  testWidgets(
      'Authorization page should contain phone number TextField and button',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(MaterialApp(home: _wrapLocalizations(AuthorizationPage())));

    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(find.byType(NumberTextField), findsOneWidget);
    expect(find.byType(CustomButton), findsOneWidget);
  });

  testWidgets('Phone number is formatted correctly when entered',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(MaterialApp(home: _wrapLocalizations(AuthorizationPage())));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    final phoneNumberField = find.byType(NumberTextField);
    await tester.enterText(phoneNumberField, '1234567890');

    await tester.pump();

    expect(find.text('(123) 456 78 90'), findsOneWidget);
  });

  testWidgets('Check button validates phone number',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(MaterialApp(home: _wrapLocalizations(AuthorizationPage())));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    final phoneNumberField = find.byType(NumberTextField);
    await tester.enterText(phoneNumberField, '2222222222');
    await tester.pump();

    final checkButton = find.byType(CustomButton);
    await tester.tap(checkButton);
    await tester.pumpAndSettle(const Duration(seconds: 5));

    final toggleErrorText = find.descendant(
      of: find.byType(ToggleErrorText),
      matching: find.byType(Text),
    );
    expect(
      (toggleErrorText.evaluate().single.widget as Text).data!.isNotEmpty,
      true,
    );
  });

  testWidgets('Check button recognizes correct phone number',
      (WidgetTester tester) async {
    await tester
        .pumpWidget(MaterialApp(home: _wrapLocalizations(AuthorizationPage())));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    final phoneNumberField = find.byType(NumberTextField);
    await tester.enterText(phoneNumberField, '1111111111');
    await tester.pump();

    final checkButton = find.byType(CustomButton);
    await tester.tap(checkButton);
    await tester.pumpAndSettle(const Duration(seconds: 5));

    final toggleErrorText = find.descendant(
      of: find.byType(ToggleErrorText),
      matching: find.byType(Text),
    );
    expect(
      (toggleErrorText.evaluate().single.widget as Text).data!.isEmpty,
      true,
    );
  });
}

Widget _wrapLocalizations(Widget child) {
  return MaterialApp(
      home: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: child));
}
