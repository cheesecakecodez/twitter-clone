import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:twitter_clone/components/my_settings_tile.dart';

void main() {
  testWidgets('MySettingsTile renders its title and action widget', (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: MySettingsTile(
          title: 'Dark Mode',
          action: CupertinoSwitch(value: false, onChanged: (_) {}),
        ),
      ),
    ));

    expect(find.text('Dark Mode'), findsOneWidget);
    expect(find.byType(CupertinoSwitch), findsOneWidget);
  });
}
