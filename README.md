# Twitter Clone (Flutter + Firebase)

![Flutter CI](https://github.com/cheesecakecodez/twitter-clone/actions/workflows/flutter_ci.yml/badge.svg)

A Twitter-style social app built in Flutter, backed by Firebase (Auth + Firestore).
Built as a learning/portfolio project to practice Provider-based state management,
optimistic UI updates, and Firestore data modeling — with a CI/CD pipeline (GitHub
Actions) enforcing static analysis and tests on every push, and a branch-protected,
human-reviewed merge process into `main`.

> 🚧 **Status: in progress.** This README will be updated as features land.
> Currently working through: theming, authentication, user profiles.

## Features (planned / in progress)
- [x] Light/dark theme with Provider
- [x] Login / register UI + navigation flow
- [ ] Firebase email/password auth (login, register, auth gate)
- [ ] User profiles + bio editing
- [ ] Post / like / comment
- [ ] Follow / unfollow, For You & Following feeds
- [ ] Search users
- [ ] Report / block / delete account (App Store account-deletion requirement)

## Tech stack
- **Flutter** — UI framework
- **Provider** — state management
- **Firebase Auth** — authentication
- **Cloud Firestore** — database
- **GitHub Actions** — CI/CD (analyze, tests, branch protection)

## Architecture notes
The app separates concerns into three layers:
- **Services** (`lib/services/`) — talk directly to Firebase (raw auth/data operations)
- **Providers** (`lib/themes/theme_provider.dart` and future `*_provider.dart` files) —
  hold local app state, call services, notify listeners; this is what the UI actually
  talks to
- **UI** (`lib/pages/`, `lib/components/`) — never calls Firebase directly, only
  providers

This keeps the data layer swappable and the UI layer testable in isolation.

## Getting started

### Prerequisites
- Flutter SDK (see `pubspec.yaml` for the `sdk` constraint)
- A Firebase project with Authentication (email/password) and Firestore enabled
- FlutterFire CLI configured for your own Firebase project (`flutterfire configure`)

### Setup
```bash
git clone https://github.com/cheesecakecodez/twitter-clone.git
cd twitter-clone
flutter pub get
```

You'll need to connect your own Firebase project (this repo does not ship Firebase
credentials):
```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

### Run
```bash
flutter run
```

### Run tests / checks locally (same as CI)
```bash
flutter analyze
flutter test
```

---

## DevOps Timeline

This section documents the pipeline being exercised for real — not just configured,
but actually failing, getting fixed, reviewed, and merged.

### 1. Initial CI/CD setup
GitHub Actions workflow (`.github/workflows/flutter_ci.yml`) added: on every push to
a non-`main` branch and every PR into `main`, it runs `flutter pub get` →
`flutter analyze` → `flutter test`.

<!-- SCREENSHOT: first green Actions run after the workflow was added -->

### 2. First failing run
A test was pushed on branch `b` that failed against the real widget tree
(catch it here, not in production).

<!-- SCREENSHOT: red ❌ Actions run showing the failing job/step -->
<!-- SCREENSHOT: GitHub email notification for the failed run -->

**What failed and why:** _(fill in once captured)_

### 3. Fix committed, CI green again
Pushed a fix to the same branch; the workflow re-ran automatically.

<!-- SCREENSHOT: green ✅ Actions run after the fix -->

### 4. Pull request opened, review requested
Opened a PR from `b` into `main`. A second GitHub account (admin/reviewer) was
assigned as required reviewer — branch protection blocks merging without their
approval, independent of the CI check.

<!-- SCREENSHOT: PR page showing "Review required" status -->
<!-- SCREENSHOT: email notification received on the reviewer account -->

### 5. Reviewed and merged
Reviewer approved the PR. With both the CI check and the required approval
satisfied, the merge button unlocked and `b` was merged into `main`.

<!-- SCREENSHOT: PR showing "Approved" + merged state -->

---

## Bugs Fixed & Lessons Learned

A running log of real problems hit while building this — not staged for the
README, actually encountered and debugged.

### Environment setup
- **`flutterfire configure` not found** → Pub's global executables install to
  `%LOCALAPPDATA%\Pub\Cache\bin`, which isn't on Windows PATH by default.
  Learned: any Dart/Flutter global CLI tool needs this folder on PATH, permanently
  (System Environment Variables), not just per-session.
- **Symlink error building plugins** → Flutter plugins need Windows Developer
  Mode enabled (`start ms-settings:developers`) to create symlinks.
- **Kotlin daemon crash: "different roots"** → Caused by the project living on
  `D:\` while the Pub cache lives on `C:\`. Kotlin's incremental compiler tries
  to compute a relative path between the two for its cache and can't, since
  Windows has no relative path across drive letters. Fixed by disabling
  incremental Kotlin compilation in `android/gradle.properties`.
- **Gradle daemon OOM crash** → Confirmed via the JVM's own `hs_err_pid*.log`:
  genuinely out of RAM with Android Studio + emulator + VS Code + Gradle all
  running at once on a 15GB machine. Fixed by lowering `org.gradle.jvmargs`
  and disabling parallel workers, plus just closing unused apps.

### `const` in Dart
Learned that `const` requires every argument to be a **compile-time constant**.
A closure like `onTap: () {}` is created at runtime, not compile time — so any
widget taking a closure as an argument can't be constructed with `const`, and
neither can any parent wrapping it.

### The real auth navigation bug
Spent a long stretch debugging "why doesn't the app navigate to HomePage after
login." The architecture (`AuthGate` + `StreamBuilder` on `authStateChanges()`)
was actually correct. The real bug: the drawer's **Logout** button manually
pushed `LoginOrRegister()` with `Navigator.push` — without ever calling
`FirebaseAuth.signOut()`. That meant:
1. The user was never actually logged out, so signing back in with the same
   account produced no new `authStateChanges()` event (Firebase only fires on
   real transitions).
2. The manually-pushed login screen sat on top of `AuthGate` in the navigation
   stack, so `AuthGate` couldn't react even if it wanted to.

Fix: call `AuthService().logout()` and let `AuthGate` handle navigation on its
own — never manually push over it. Lesson: when using a stream-driven auth
gate pattern, *nothing else* in the app should manually navigate between the
authenticated/unauthenticated states — only real Firebase auth-state changes
should drive that.

### Testing Firebase-dependent widgets
`LoginPage`, `RegisterPage`, and `HomePage` (via `MyDrawer`) all construct
`AuthService()` immediately in their `State`, which reads `FirebaseAuth.instance`
— so just *building* these widgets in a test throws `[core/no-app]` if Firebase
was never initialized. Two mocking attempts:
1. First tried mocking the old-style `plugins.flutter.io/firebase_core` method
   channel — didn't work, because this `firebase_core` version uses newer
   Pigeon-based channels (`dev.flutter.pigeon...FirebaseCoreHostApi`).
2. Fixed by overriding `FirebasePlatform.instance` directly with a fake
   implementation — bypasses platform channels entirely, so it's resilient to
   `firebase_core`'s internal channel implementation changing again later.

Also learned: `flutter analyze`'s `depend_on_referenced_packages` lint fires
when you import a package (like `firebase_core_platform_interface`) that's
only a *transitive* dependency — fixed with
`flutter pub add dev:firebase_core_platform_interface`.

### Git hygiene
- `flutter analyze`'s `avoid_print` lint failed CI on leftover `print()` calls
  in `login_page.dart`, `drawer.dart`, and a debug print I'd added to
  `auth_gate.dart` while diagnosing the auth bug. Replaced the real ones with
  proper `AlertDialog` error handling; removed the debug one entirely.
- Accidentally committed a **289 MB `build.zip`** (from zipping folders to
  share for debugging) directly into git history — caused `git push` to
  fail with an HTTP 408 timeout. Since a plain delete-and-commit doesn't
  remove old blobs from history, had to rewrite history with
  `git filter-repo` and force-push. Lesson: `*.zip` now lives in root
  `.gitignore`, and JVM crash logs (`hs_err_pid*.log`, `replay_pid*.log`)
  are excluded too, after they nearly got committed from an earlier crash.

### Still open
- `register_page.dart` still has a leftover bug from before `AuthService`
  was wired in — its Register button bypasses real Firebase account creation
  entirely. Tracked as the next fix.
- Login's error handling is now consistent with Register's (`AlertDialog` on
  failure) — improved from silently swallowing errors via `print()`.

  ---
  
## Branch Protection Rules (`main`)
- ✅ Require a pull request before merging
- ✅ Require 1 approval before merging
- ✅ Require status checks to pass (`analyze_and_test`)

## Tests

| Layer | File | Covers |
|---|---|---|
| Unit | `test/theme/theme_provider_test.dart` | Theme toggle logic |
| Widget | `test/components/*` | Button, textfield, drawer tile, settings tile |
| Widget | `test/pages/*` | Login, register, home, settings navigation + rendering |
| Smoke | `test/widget_test.dart` | App boots to `LoginPage` |

## Roadmap
- [ ] Firebase Auth + Firestore integration
- [ ] Add build + deploy step (Firebase App Distribution) to complete the CD half
- [ ] Mirror the same test suite as a Jenkins pipeline, as a second CI implementation
      to demonstrate tool-agnostic pipeline design

## License
Personal/portfolio project — not published to pub.dev.