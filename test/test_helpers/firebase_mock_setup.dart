import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

/// Fakes just enough of the firebase_core platform channel so that
/// Firebase.initializeApp() / Firebase.app() succeed in widget tests,
/// without needing a real Firebase project or network connection.
///
/// This does NOT fake firebase_auth itself -- so real auth calls
/// (signIn, createUser, etc.) will still fail if actually invoked.
/// It only lets code that merely *references* FirebaseAuth.instance
/// (like AuthService's constructor) run without crashing.
Future<void> setupFirebaseAppForTests() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  const channel = MethodChannel('plugins.flutter.io/firebase_core');

  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
    if (methodCall.method == 'Firebase#initializeCore') {
      return [
        {
          'name': '[DEFAULT]',
          'options': {
            'apiKey': 'fake-api-key',
            'appId': 'fake-app-id',
            'messagingSenderId': 'fake-sender-id',
            'projectId': 'fake-project-id',
          },
          'pluginConstants': {},
        }
      ];
    }
    if (methodCall.method == 'Firebase#initializeApp') {
      return {
        'name': methodCall.arguments['appName'],
        'options': methodCall.arguments['options'],
        'pluginConstants': {},
      };
    }
    return null;
  });

  await Firebase.initializeApp();
}