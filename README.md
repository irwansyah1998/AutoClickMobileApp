# Auto Clicker

A lightweight Android-first Flutter application with native Android support for accessibility and overlay-based automation.

## Overview

This project provides a professional dashboard for configuring tap automation, executing click jobs, and monitoring runtime status while staying within Android’s security model. The Flutter layer handles the UI and configuration, while the Android layer is responsible for accessibility services, overlay behavior, and native permission checks.

## Architecture

- Flutter: UI, configuration, state, and persistence
- Kotlin/Android: accessibility dispatch, permission checks, and native lifecycle handling
- MethodChannel: native command bridge between Flutter and Android

## Directory structure

- lib/core
- lib/data
- lib/features
- android/app/src/main/kotlin/com/example/autoclickmobileapp

## Flutter/native communication

The app uses a single native MethodChannel named `autoclickmobileapp/native` for commands such as:

- `startClicker`
- `pauseClicker`
- `resumeClicker`
- `stopClicker`
- `checkAccessibility`
- `checkOverlayPermission`

## Accessibility Service explanation

Android requires a user-granted Accessibility Service for automation actions that target UI elements outside the app itself. This app only uses the feature when the user explicitly enables it and only for the click actions the user has configured.

## Overlay permission explanation

The overlay permission is required if the application wants to display a floating control panel above other apps. The permission is requested explicitly and checked before the overlay is shown.

## Setup

1. Install Flutter 3.29 or later.
2. Run `flutter pub get`.
3. Open the Android project in Android Studio if you need device-specific debugging.

## Build

```bash
flutter test
flutter build apk --debug
```

## Debugging

- Use `flutter logs` for Flutter runtime logs.
- Check Android Studio Logcat for Kotlin and accessibility events.
- Confirm overlay and accessibility permissions in Settings.

## Testing

```bash
flutter test
```

## Android compatibility

The project targets modern Android behavior and keeps version-specific branches isolated. Accessibility and overlay features depend on the Android device’s runtime permissions and service state.

## Known limitations

- Native automation must respect Android accessibility and overlay restrictions.
- Screen tapping is limited by Android security and app visibility rules.
- Real timing precision can vary by device and OS scheduling.

## Performance considerations

- UI rebuilds are kept lightweight.
- The app avoids excessive event flooding from the native layer.
- Click scheduling is intentionally minimal and OS-aware.
