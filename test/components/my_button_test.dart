import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:twitter_clone/components/my_button.dart';

void main() {
  Widget buildTestWidget({required VoidCallback onTap}) {
    return MaterialApp(
      home: Scaffold(
        body: MyButton(name: 'Login', onTap: onTap),
      ),
    );
  }

  group('MyButton', () {
    testWidgets('renders the given label text', (tester) async {
      await tester.pumpWidget(buildTestWidget(onTap: () {}));

      expect(find.text('Login'), findsOneWidget);
    });

    testWidgets('calls onTap when tapped', (tester) async {
      var tapped = false;
      await tester.pumpWidget(buildTestWidget(onTap: () => tapped = true));

      await tester.tap(find.byType(GestureDetector));
      await tester.pump();

      expect(tapped, isTrue);
    });
  });
}
