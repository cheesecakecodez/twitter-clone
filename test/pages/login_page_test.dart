import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:twitter_clone/pages/login_page.dart';
import 'package:twitter_clone/pages/register_page.dart';
import '../test_helpers/firebase_mock_setup.dart';

// NOTE: LoginPage's State constructs AuthService() immediately, which reads
// FirebaseAuth.instance -- so even just building LoginPage() requires a
// Firebase app to exist. setupFirebaseAppForTests() fakes just enough of
// firebase_core for that to succeed. We deliberately do NOT tap "Login"
// with credentials and assert a Firebase outcome here -- that would
// attempt a real network call. These tests cover rendering and the
// onTap-based navigation to RegisterPage (plain callback logic).
void main() {
  setUpAll(() async {
    await setupFirebaseAppForTests();
  });

  group('LoginPage', () {
    testWidgets('renders email and password fields', (tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginPage(onTap: () {})));

      expect(find.text('Enter email'), findsOneWidget);
      expect(find.text('Enter password'), findsOneWidget);
      expect(find.text("Welcome back, You've been missed!"), findsOneWidget);
    });

    testWidgets('tapping Register Now navigates to RegisterPage', (tester) async {
      await tester.pumpWidget(MaterialApp(home: LoginPage(onTap: () {})));

      await tester.ensureVisible(find.text('Register Now'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Register Now'));
      await tester.pumpAndSettle();

      expect(find.byType(RegisterPage), findsOneWidget);
    });
  });
}