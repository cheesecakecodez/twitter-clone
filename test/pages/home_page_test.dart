import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:twitter_clone/pages/home_page.dart';
import '../test_helpers/firebase_mock_setup.dart';
// ...
void main() {
  setUpAll(() async {
    await setupFirebaseAppForTests();
  });
  group('HomePage', () {
    testWidgets('shows the app bar title and has a drawer', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomePage()));

      expect(find.text('H O M E'), findsOneWidget);

      final scaffoldState = tester.state<ScaffoldState>(find.byType(Scaffold));
      expect(scaffoldState.hasDrawer, isTrue);
    });

    testWidgets('opening the drawer shows the menu tiles', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: HomePage()));

      final scaffoldState = tester.state<ScaffoldState>(find.byType(Scaffold));
      scaffoldState.openDrawer();
      await tester.pumpAndSettle();

      expect(find.text('P R O F I L E'), findsOneWidget);
      expect(find.text('S E A R C H'), findsOneWidget);
      expect(find.text('S E T T I N G S'), findsOneWidget);
      expect(find.text('L O G O U T'), findsOneWidget);
    });
  });
}
