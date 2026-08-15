import 'package:flutter_test/flutter_test.dart';
import 'package:twitter_clone/themes/dark_mode.dart';
import 'package:twitter_clone/themes/light_mode.dart';
import 'package:twitter_clone/themes/theme_provider.dart';

void main() {
  group('ThemeProvider', () {
    test('starts in light mode', () {
      final provider = ThemeProvider();

      expect(provider.isDarkMode, isFalse);
      expect(provider.themeData, lightmode);
    });

    test('toogleTheme switches from light to dark', () {
      final provider = ThemeProvider();

      provider.toogleTheme();

      expect(provider.isDarkMode, isTrue);
      expect(provider.themeData, darkmode);
    });

    test('toogleTheme called twice returns to light mode', () {
      final provider = ThemeProvider();

      provider.toogleTheme();
      provider.toogleTheme();

      expect(provider.isDarkMode, isFalse);
      expect(provider.themeData, lightmode);
    });

    test('notifies listeners when the theme changes', () {
      final provider = ThemeProvider();
      var notified = false;
      provider.addListener(() => notified = true);

      provider.toogleTheme();

      expect(notified, isTrue);
    });
  });
}
