import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:twitter_clone/pages/login_page.dart';
import 'package:twitter_clone/pages/register_page.dart';

// NOTE: LoginPage now calls AuthService() -> FirebaseAuth.instance, which
// isn't available in a plain widget test (no Firebase app initialized).
// We deliberately do NOT tap the "Login" button and assert a Firebase
// outcome here -- that's covered separately once AuthService is made
// mockable/injectable. These tests cover the parts that are safely
// testable without a live Firebase connection: rendering and the
// onTap-based navigation to RegisterPage (which is plain callback logic,
// not Firebase-driven).
void main() {
  group('LoginPage', () {
    testWidgets('renders email and password fields', (tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginPage(onTap: () {})));

      expect(find.text('Enter email'), findsOneWidget);
      expect(find.text('Enter password'), findsOneWidget);
      expect(find.text("Welcome back, You've been missed!"), findsOneWidget);
    });

    testWidgets('tapping Register Now navigates to RegisterPage', (tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginPage(onTap: () {})));
      // The page is scrollable, so scroll the target into view before tapping.
      await tester.ensureVisible(find.text('Register Now'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Register Now'));
      await tester.pumpAndSettle();

      expect(find.byType(RegisterPage), findsOneWidget);
    });
  });
}