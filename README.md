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