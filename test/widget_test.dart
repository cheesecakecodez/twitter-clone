import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/main.dart';
import 'package:twitter_clone/pages/login_page.dart';
import 'package:twitter_clone/themes/theme_provider.dart';

void main() {
  testWidgets('app boots to the LoginPage', (tester) async {
    // MyApp reads ThemeProvider via Provider.of, same as main() sets up.
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
        child: const MyApp(),
      ),
    );

    expect(find.byType(LoginPage), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });
}
