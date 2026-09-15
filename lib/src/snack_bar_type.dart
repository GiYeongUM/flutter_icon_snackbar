import 'package:icon_animated/icon_animated.dart';

/// The outcome communicated by a snack bar.
enum SnackBarType {
  success,
  fail,
  alert;

  /// The matching outline icon.
  IconType get icon => switch (this) {
    success => IconType.check,
    fail => IconType.fail,
    alert => IconType.alert,
  };
}
