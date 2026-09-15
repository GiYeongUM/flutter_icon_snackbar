import 'dart:async';

import 'package:flutter/material.dart';
import 'package:icon_animated/icon_animated.dart';

/// The status represented by an icon snack bar.
enum SnackBarType { success, fail, alert }

/// Shows animated status messages through the nearest ScaffoldMessenger.
class IconSnackBar {
  /// Shows a snack bar and returns its controller for dismissal or completion.
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> show(
    BuildContext context, {
    required String label,
    required SnackBarType snackBarType,
    Duration? duration,
    DismissDirection? direction,
    SnackBarBehavior behavior = SnackBarBehavior.fixed,
    Color? backgroundColor,
    Color iconColor = Colors.white,
    TextStyle labelTextStyle = const TextStyle(),
    int? maxLines,
  }) {
    assert(maxLines == null || maxLines > 0);
    final messenger = ScaffoldMessenger.of(context);
    final snackBar = SnackBar(
      duration: duration ?? const Duration(seconds: 2),
      dismissDirection: direction ?? DismissDirection.down,
      behavior: behavior,
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: SnackBarWidget(
        onPressed: () => messenger.removeCurrentSnackBar(),
        label: label,
        backgroundColor: backgroundColor ?? _getBackgroundColor(snackBarType),
        labelTextStyle: labelTextStyle,
        iconType: _getIconType(snackBarType),
        maxLines: maxLines,
        color: iconColor,
      ),
    );

    return messenger.showSnackBar(snackBar);
  }

  static Color _getBackgroundColor(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return Colors.green;
      case SnackBarType.fail:
        return Colors.red;
      case SnackBarType.alert:
        return Colors.black;
    }
  }

  static IconType _getIconType(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return IconType.check;
      case SnackBarType.fail:
        return IconType.fail;
      case SnackBarType.alert:
        return IconType.alert;
    }
  }
}

/// Animated snack bar content that invokes [onPressed] when tapped.
class SnackBarWidget extends StatefulWidget implements SnackBarAction {
  const SnackBarWidget({
    super.key,
    required this.iconType,
    required this.label,
    required this.onPressed,
    this.textColor,
    this.disabledTextColor,
    this.backgroundColor = Colors.black,
    this.labelTextStyle,
    this.disabledBackgroundColor = Colors.black,
    this.maxLines,
    this.color,
  }) : assert(maxLines == null || maxLines > 0);

  @override
  final Color? textColor;

  @override
  final Color? disabledTextColor;

  @override
  final String label;

  @override
  final VoidCallback onPressed;

  @override
  final Color backgroundColor;

  @override
  final Color disabledBackgroundColor;

  final TextStyle? labelTextStyle;
  final IconType iconType;
  final int? maxLines;
  final Color? color;

  @override
  State<SnackBarWidget> createState() => _SnackBarWidgetState();
}

class _SnackBarWidgetState extends State<SnackBarWidget> {
  var _fadeAnimationStart = false;
  Timer? _animationTimer;

  @override
  void initState() {
    super.initState();
    _animationTimer = Timer(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      setState(() => _fadeAnimationStart = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(15),
        child: AnimatedContainer(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          color: widget.backgroundColor,
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 400),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.transparent,
                child: IconAnimated(
                  color: _fadeAnimationStart
                      ? widget.color
                      : widget.backgroundColor,
                  active: true,
                  size: 40,
                  iconType: widget.iconType,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: AnimatedContainer(
                  margin: EdgeInsetsDirectional.only(
                    start: _fadeAnimationStart ? 0 : 10,
                  ),
                  duration: const Duration(milliseconds: 400),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: _fadeAnimationStart ? 1.0 : 0.0,
                    child: Text(
                      widget.label,
                      overflow: TextOverflow.ellipsis,
                      maxLines: widget.maxLines,
                      style: TextStyle(
                        fontSize: 16,
                        color: widget.textColor ?? Colors.white,
                      ).merge(widget.labelTextStyle),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationTimer?.cancel();
    super.dispose();
  }
}
