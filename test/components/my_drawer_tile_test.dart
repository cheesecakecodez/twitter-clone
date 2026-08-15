import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:twitter_clone/components/my_drawer_tile.dart';

void main() {
  group('MyDrawerTile', () {
    testWidgets('renders the title and icon', (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: MyDrawerTile(title: 'H O M E', icon: Icons.home, onTap: () {}),
        ),
      ));

      expect(find.text('H O M E'), findsOneWidget);
      expect(find.byIcon(Icons.home), findsOneWidget);
    });

    testWidgets('calls onTap when tapped', (tester) async {
      var tapped = false;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: MyDrawerTile(
            title: 'P R O F I L E',
            icon: Icons.person,
            onTap: () => tapped = true,
          ),
        ),
      ));

      await tester.tap(find.byType(ListTile));
      await tester.pump();

      expect(tapped, isTrue);
    });
  });
}
