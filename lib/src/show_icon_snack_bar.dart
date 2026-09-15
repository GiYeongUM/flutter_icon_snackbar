import 'package:flutter/material.dart';
import 'icon_snack_bar_content.dart';
import 'snack_bar_type.dart';
import 'theme/snack_bar_colors.dart';

/// Shows a status message and returns its dismissal/completion controller.
ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showIconSnackBar(
  BuildContext context, {
  required String label,
  required SnackBarType type,
  Duration duration = const Duration(seconds: 2),
  DismissDirection dismissDirection = DismissDirection.down,
  SnackBarBehavior behavior = SnackBarBehavior.fixed,
  Color? backgroundColor,
  Color? iconColor,
  TextStyle? textStyle,
  int? maxLines,
}) {
  assert(!duration.isNegative);
  assert(maxLines == null || maxLines > 0);
  final messenger = ScaffoldMessenger.of(context);
  final colors = statusColors(Theme.of(context).colorScheme, type);
  final foreground = backgroundColor == null
      ? colors.foreground
      : contrastingForeground(backgroundColor);
  return messenger.showSnackBar(
    SnackBar(
      duration: duration,
      dismissDirection: dismissDirection,
      behavior: behavior,
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: IconSnackBarContent(
        label: label,
        iconType: type.icon,
        onPressed: messenger.removeCurrentSnackBar,
        backgroundColor: backgroundColor ?? colors.background,
        iconColor: iconColor ?? foreground,
        textStyle: TextStyle(color: foreground).merge(textStyle),
        maxLines: maxLines,
      ),
    ),
  );
}
