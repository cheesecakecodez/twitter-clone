import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:twitter_clone/pages/home_page.dart';
import 'package:twitter_clone/pages/login_page.dart';
import 'package:twitter_clone/pages/register_page.dart';

void main() {
  group('RegisterPage', () {
    testWidgets('renders all four input fields', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: RegisterPage()));

      expect(find.text('Enter your name'), findsOneWidget);
      expect(find.text('Enter your email'), findsOneWidget);
      expect(find.text('Enter your password'), findsOneWidget);
      expect(find.text('Confirm Password'), findsOneWidget);
    });

    testWidgets('tapping Register navigates to HomePage', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: RegisterPage()));

      await tester.tap(find.text('Register'));
      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets('tapping Login Now navigates to LoginPage', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: RegisterPage()));

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
