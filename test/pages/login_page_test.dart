import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:twitter_clone/pages/home_page.dart';
import 'package:twitter_clone/pages/login_page.dart';
import 'package:twitter_clone/pages/register_page.dart';

void main() {
  group('LoginPage', () {
    testWidgets('renders email and password fields', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));

      expect(find.text('Enter email'), findsOneWidget);
      expect(find.text('Enter password'), findsOneWidget);
      expect(find.text("Welcome back, You've been missed!"), findsOneWidget);
    });

    testWidgets('tapping Login navigates to HomePage', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));

      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets('tapping Register Now navigates to RegisterPage', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: LoginPage()));

      await tester.tap(find.text('Register Now'));
      await tester.pumpAndSettle();

      expect(find.byType(RegisterPage), findsOneWidget);
    });
  });
}
