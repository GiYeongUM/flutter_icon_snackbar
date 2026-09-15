# flutter_icon_snackbar

Status messages with motion, contrast, and a clear API.

[![pub package](https://img.shields.io/pub/v/flutter_icon_snackbar.svg)](https://pub.dev/packages/flutter_icon_snackbar)
[![CI](https://github.com/GiYeongUM/flutter_icon_snackbar/actions/workflows/ci.yml/badge.svg)](https://github.com/GiYeongUM/flutter_icon_snackbar/actions/workflows/ci.yml)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

[Quick start](#quick-start) · [Configuration](#configuration) ·
[Example](example/example.dart) · [Migration](MIGRATION.md) · [Changelog](CHANGELOG.md)

## At a glance

- Success, failure, and alert icons with theme-derived color pairs.
- A controller for early dismissal and completion results.
- Independent content and animation widgets, with no pending delay timers.
- RTL-aware entrance, reduced motion, and optional tap interaction.

## Quick start

**Requirements:** Flutter **3.32+** · Dart **3.8+**

```sh
flutter pub add flutter_icon_snackbar
```

To use this major version explicitly:

```yaml
dependencies:
  flutter_icon_snackbar: ^2.0.0
```

```dart
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';

final controller = showIconSnackBar(
  context,
  type: SnackBarType.success,
  label: 'Changes saved',
);

// Optional: await controller.closed or call controller.close() later.
```

## Configuration

| Option                      | Default                | Purpose                                                       |
| --------------------------- | ---------------------- | ------------------------------------------------------------- |
| context                     | required, positional   | Context below a ScaffoldMessenger with a registered Scaffold. |
| label / type                | required               | Message and SnackBarType.                                     |
| duration                    | 2 seconds              | How long the message remains visible.                         |
| dismissDirection            | DismissDirection.down  | Swipe dismissal direction.                                    |
| behavior                    | SnackBarBehavior.fixed | Fixed or floating presentation.                               |
| backgroundColor / iconColor | color scheme           | Optional appearance overrides.                                |
| textStyle                   | theme typography       | Optional text style override.                                 |
| maxLines                    | null                   | Optional positive limit; excess text is truncated.            |

## Status palette

| Type    | Icon  | ColorScheme pair                          |
| ------- | ----- | ----------------------------------------- |
| success | check | primaryContainer / onPrimaryContainer     |
| fail    | fail  | errorContainer / onErrorContainer         |
| alert   | alert | secondaryContainer / onSecondaryContainer |

An explicit background color uses a light or dark foreground unless you supply a text or
icon color. Translucent custom backgrounds should be checked against the surface
underneath them.

For custom presentation, use `IconSnackBarContent` directly. Its nullable `onPressed`
enables or disables tap interaction; it is a content widget, not a `SnackBarAction`. The
helper enables tap-to-dismiss.

## Package structure

```text
lib/
├── flutter_icon_snackbar.dart  # Public exports
└── src/
    ├── show_icon_snack_bar.dart
    ├── icon_snack_bar_content.dart
    ├── snack_bar_type.dart
    ├── theme/snack_bar_colors.dart
    └── widgets/snack_bar_entrance.dart
```

Import the package entry point. Files under `src/` are implementation details and are
not a supported import surface.

## Development

```sh
flutter pub get
dart format --output=none --set-exit-if-changed lib example test
flutter analyze --fatal-infos
flutter test
flutter pub publish --dry-run
```

CI validates Flutter 3.32.0 and the latest stable channel. When switching SDK versions
locally, run `flutter clean` before testing to avoid reusing incompatible compiled
shader assets.

## Upgrading from 1.x

Version 2.0 includes intentional API changes. Follow [MIGRATION.md](MIGRATION.md) before
changing an existing application's dependency constraint.

## Support and license

Report reproducible issues in
[GitHub Issues](https://github.com/GiYeongUM/flutter_icon_snackbar/issues). Include the
Flutter version and a minimal example.

Released under the [MIT license](LICENSE).
