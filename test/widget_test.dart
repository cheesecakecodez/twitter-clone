import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/services/auth/login_or_register.dart';
import 'package:twitter_clone/pages/login_page.dart';
import 'package:twitter_clone/themes/theme_provider.dart';

// NOTE: We test LoginOrRegister here instead of MyApp/AuthGate directly.
// AuthGate calls FirebaseAuth.instance.authStateChanges(), which requires
// a real initialized Firebase app -- something widget tests don't have.
// LoginOrRegister is the part of the "logged out" flow that's actually
// testable without Firebase, since it doesn't touch FirebaseAuth itself.
void main() {
  testWidgets('unauthenticated flow starts on the LoginPage', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        child: const MaterialApp(home: LoginOrRegister()),
      ),
    );

    expect(find.byType(LoginPage), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });
}