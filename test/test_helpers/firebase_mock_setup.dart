import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';

/// Fakes the Firebase Core platform delegate directly, bypassing method
/// channels entirely. This is version-proof against firebase_core changing
/// its channel implementation (e.g. the Pigeon-based migration), since we
/// never talk to a platform channel at all -- we just swap out
/// FirebasePlatform.instance with an object that returns a fake app.
class _FakeFirebaseAppPlatform extends FirebaseAppPlatform {
  _FakeFirebaseAppPlatform()
      : super(
          defaultFirebaseAppName,
          const FirebaseOptions(
            apiKey: 'fake-api-key',
            appId: 'fake-app-id',
            messagingSenderId: 'fake-sender-id',
            projectId: 'fake-project-id',
          ),
        );
}

class _FakeFirebasePlatform extends FirebasePlatform {
  final _fakeApp = _FakeFirebaseAppPlatform();

  @override
  FirebaseAppPlatform app([String name = defaultFirebaseAppName]) => _fakeApp;

  @override
  Future<FirebaseAppPlatform> initializeApp({
    String? name,
    FirebaseOptions? options,
  }) async =>
      _fakeApp;

  @override
  List<FirebaseAppPlatform> get apps => [_fakeApp];
}

Future<void> setupFirebaseAppForTests() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  FirebasePlatform.instance = _FakeFirebasePlatform();
  await Firebase.initializeApp();
}