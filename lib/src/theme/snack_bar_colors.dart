import 'package:flutter/material.dart';
import '../snack_bar_type.dart';

/// Resolves paired surface/foreground colors from the application's color scheme.
({Color background, Color foreground}) statusColors(
  ColorScheme colors,
  SnackBarType type,
) => switch (type) {
  SnackBarType.success => (
    background: colors.primaryContainer,
    foreground: colors.onPrimaryContainer,
  ),
  SnackBarType.fail => (
    background: colors.errorContainer,
    foreground: colors.onErrorContainer,
  ),
  SnackBarType.alert => (
    background: colors.secondaryContainer,
    foreground: colors.onSecondaryContainer,
  ),
};

/// Chooses readable text for an explicitly supplied surface.
Color contrastingForeground(Color background) =>
    ThemeData.estimateBrightnessForColor(background) == Brightness.dark
    ? Colors.white
    : Colors.black;
