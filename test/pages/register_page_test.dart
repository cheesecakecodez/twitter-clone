import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:twitter_clone/pages/login_page.dart';
import 'package:twitter_clone/pages/register_page.dart';

// NOTE: RegisterPage calls AuthService() -> FirebaseAuth.instance for actual
// account creation, which isn't available in a plain widget test. We don't
// tap "Register" with valid matching credentials here (that would hit real
// Firebase and throw). The password-mismatch case below is genuinely safe
// to test though: registerMethod() checks pwController.text == cpwController.text
// BEFORE ever touching Firebase, so it's pure, offline, testable logic.
void main() {
  group('RegisterPage', () {
    testWidgets('renders all four input fields', (tester) async {
      await tester.pumpWidget(MaterialApp(home: RegisterPage(onTap: () {})));

      expect(find.text('Enter your name'), findsOneWidget);
      expect(find.text('Enter your email'), findsOneWidget);
      expect(find.text('Enter your password'), findsOneWidget);
      expect(find.text('Confirm Password'), findsOneWidget);
    });

    testWidgets('mismatched passwords show an error dialog', (tester) async {
      await tester.pumpWidget(MaterialApp(home: RegisterPage(onTap: () {})));

      await tester.enterText(find.widgetWithText(TextField, 'Enter your password'), 'password123');
      await tester.enterText(find.widgetWithText(TextField, 'Confirm Password'), 'differentPassword');

      await tester.ensureVisible(find.text('Register'));
      await tester.tap(find.text('Register'));
      await tester.pump(); // let the dialog build; no Firebase call happens on this path

      expect(find.text("Passwords don't match"), findsOneWidget);
    });

    testWidgets('tapping Login Now navigates to LoginPage', (tester) async {
      await tester.pumpWidget(MaterialApp(home: RegisterPage(onTap: () {})));

      // RegisterPage has more fields than LoginPage, so it's more likely to
      // need scrolling before this link is tappable.
      await tester.ensureVisible(find.text('Login Now'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Login Now'));
      await tester.pumpAndSettle();

      expect(find.byType(LoginPage), findsOneWidget);
    });
  });
}