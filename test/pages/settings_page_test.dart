import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:twitter_clone/pages/settings_page.dart';
import 'package:twitter_clone/themes/theme_provider.dart';

void main() {
  Widget buildTestWidget(ThemeProvider provider) {
    return ChangeNotifierProvider<ThemeProvider>.value(
      value: provider,
      child: const MaterialApp(home: SettingsPage()),
    );
  }

  group('SettingsPage', () {
    testWidgets('renders all three setting rows', (tester) async {
      await tester.pumpWidget(buildTestWidget(ThemeProvider()));

      expect(find.text('Dark Mode'), findsOneWidget);
      expect(find.text('Blocked Users'), findsOneWidget);
      expect(find.text('Account Settings'), findsOneWidget);
    });

    testWidgets('dark mode switch reflects the provider state', (tester) async {
      final provider = ThemeProvider();
      await tester.pumpWidget(buildTestWidget(provider));

      final darkModeSwitch = tester.widget<CupertinoSwitch>(
        find.byType(CupertinoSwitch),
      );
      expect(darkModeSwitch.value, isFalse);
    });

    testWidgets('toggling the switch calls toogleTheme on the provider', (tester) async {
      final provider = ThemeProvider();
      await tester.pumpWidget(buildTestWidget(provider));

      await tester.tap(find.byType(CupertinoSwitch));
      await tester.pump();

      expect(provider.isDarkMode, isTrue);
    });
  });
}
