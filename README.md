# flutter_icon_snackbar

Animated status snack bars with configurable icons, colors, and text.

## Installation

Requires Flutter 3.32+ and Dart 3.8+.

```sh
flutter pub add flutter_icon_snackbar
```

## Usage

```dart
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';

final controller = IconSnackBar.show(
  context,
  snackBarType: SnackBarType.success,
  label: 'Changes saved',
);

// Optionally close early, or await controller.closed.
controller.close();
```

The context must be below a ScaffoldMessenger with a registered Scaffold.
The context is a positional argument. Supported types are `success`, `fail`,
and `alert`.

Customize `duration`, `direction`, `behavior`, `backgroundColor`, `iconColor`,
`labelTextStyle`, and `maxLines`. The default duration is two seconds.
Tapping the snack bar dismisses it immediately.

![Animated snack bar](https://github.com/GiYeongUM/flutter_icon_snackbar/raw/main/images/snackbar_type_1.gif)

## Development

```sh
flutter pub get
dart format --output=none --set-exit-if-changed lib example test
flutter analyze --fatal-infos
flutter test
flutter pub publish --dry-run
```

CI checks the minimum supported Flutter version and the latest stable channel.

## Migration

This release requires Dart 3.8 and Flutter 3.32 or newer. Existing constructor
and method arguments remain supported. See [CHANGELOG.md](CHANGELOG.md) for fixes.

## License

MIT. See [LICENSE](LICENSE).


