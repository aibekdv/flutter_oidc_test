
# Flutter OIDC Demo

This is a Flutter demo project for integrating OpenID Connect (OIDC) authentication. The app demonstrates login, logout and refresh token functionality and page navigation using `GoRouter`.

## Prerequisites

Make sure you have the following installed on your machine:

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/) for Flutter development
- [Xcode](https://developer.apple.com/xcode/) for iOS development (if you're working on macOS)

## Setup

Follow these steps to set up the project on your machine:

1. **Clone the repository:**

   ```bash
   git clone https://github.com/aibekdv/flutter_oidc_test.git
   cd flutter_oidc_test
   ```

2. **Install dependencies:**

   Run the following command to fetch the required packages:

   ```bash
   flutter pub get
   ```

3. **Run the app:**

   For Android:

   ```bash
   flutter run
   ```

   For iOS:

   ```bash
   flutter run --target=lib/main.dart
   ```

## Development

- Make sure to run `flutter doctor` to verify your Flutter environment.
- If you run into issues, use `flutter clean` to remove old build files and rebuild the app.

## Features

- Login via OpenID Connect.
- Logout functionality.
- Refresh Token functionality.
- GoRouter-based navigation for switching between the Login and Home pages.
