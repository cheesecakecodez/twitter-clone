import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/services/auth/login_or_register.dart';
import 'package:twitter_clone/pages/login_page.dart';
import 'package:twitter_clone/themes/theme_provider.dart';
import 'test_helpers/firebase_mock_setup.dart';

// NOTE: We test LoginOrRegister here instead of MyApp/AuthGate directly.
// AuthGate calls FirebaseAuth.instance.authStateChanges(), a real stream
// subscription that's a bigger ask to fake reliably than the one-shot
// app-existence check LoginOrRegister's children need. LoginOrRegister ->
// LoginPage still needs a Firebase app to exist (see firebase_mock_setup.dart).
void main() {
  setUpAll(() async {
    await setupFirebaseAppForTests();
  });

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