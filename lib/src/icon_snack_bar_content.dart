import 'package:flutter/material.dart';
import 'package:icon_animated/icon_animated.dart';
import 'theme/snack_bar_colors.dart';
import 'widgets/snack_bar_entrance.dart';

/// Animated message content. A null [onPressed] disables tap dismissal.
class IconSnackBarContent extends StatelessWidget {
  const IconSnackBarContent({
    super.key,
    required this.iconType,
    required this.label,
    this.onPressed,
    this.backgroundColor,
    this.iconColor,
    this.textStyle,
    this.maxLines,
  }) : assert(maxLines == null || maxLines > 0);

  final IconType iconType;
  final String label;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  final TextStyle? textStyle;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final background = backgroundColor ?? theme.colorScheme.inverseSurface;
    final foreground = backgroundColor == null
        ? theme.colorScheme.onInverseSurface
        : contrastingForeground(background);
    final style = (theme.textTheme.bodyMedium ?? const TextStyle())
        .copyWith(color: foreground)
        .merge(textStyle);
    return Material(
      color: background,
      borderRadius: BorderRadius.circular(15),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              IconAnimated(
                active: true,
                size: 40,
                iconType: iconType,
                color: iconColor ?? style.color,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: SnackBarEntrance(
                  child: Text(
                    label,
                    style: style,
                    maxLines: maxLines,
                    overflow: maxLines == null
                        ? TextOverflow.clip
                        : TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
