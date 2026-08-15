import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:twitter_clone/components/my_textfield.dart';

void main() {
  group('MyTextField', () {
    testWidgets('shows the hint text', (tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: MyTextField(
            controller: controller,
            hintText: 'Enter email',
            obscureText: false,
          ),
        ),
      ));

      expect(find.text('Enter email'), findsOneWidget);
    });

    testWidgets('updates the controller when text is entered', (tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: MyTextField(
            controller: controller,
            hintText: 'Enter email',
            obscureText: false,
          ),
        ),
      ));

      await tester.enterText(find.byType(TextField), 'test@example.com');

      expect(controller.text, 'test@example.com');
    });

    testWidgets('obscures input when obscureText is true', (tester) async {
      final controller = TextEditingController();

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: MyTextField(
            controller: controller,
            hintText: 'Enter password',
            obscureText: true,
          ),
        ),
      ));

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.obscureText, isTrue);
    });
  });
}
