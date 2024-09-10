library flutter_icon_snackbar;

import 'package:flutter/material.dart';
import 'package:icon_animated/icon_animated.dart';

/// soon update more icons
/// If there is an icon you want, please request it in the github issue space

enum SnackBarType {
  success,
  fail,
  alert,
}

class IconSnackBar {
  /// Show snack bar
  ///
  /// [required]
  /// BuildContext
  /// label
  /// snackBarType
  ///
  /// [optional]
  /// Duration (animation)
  /// DismissDirection (swipe direction)
  /// SnackBarStyle

  static void show(BuildContext context, {
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
    final snackBar = SnackBar(
      duration: duration ?? const Duration(seconds: 2),
      dismissDirection: direction ?? DismissDirection.down,
      behavior: behavior,
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: SnackBarWidget(
        onPressed: () => ScaffoldMessenger.of(context).removeCurrentSnackBar(),
        label: label,
        backgroundColor: backgroundColor ?? _getBackgroundColor(snackBarType),
        labelTextStyle: labelTextStyle,
        iconType: _getIconType(snackBarType),
        maxLines: maxLines,
        color: iconColor,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Color _getBackgroundColor(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return Colors.green;
      case SnackBarType.fail:
        return Colors.red;
      case SnackBarType.alert:
      default:
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
      default:
        return IconType.alert;
    }
  }
}

/// If you click on the snack bar, the logic of the snack bar ends immediately.

class SnackBarWidget extends StatefulWidget implements SnackBarAction {
  const SnackBarWidget({
    Key? key,
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
  }) : super(key: key);

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
  var disposed = false;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (!disposed) {
        setState(() {
          _fadeAnimationStart = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: ClipRRect(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        borderRadius: BorderRadius.circular(15),
        child: AnimatedContainer(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          color: widget.backgroundColor,
          curve: Curves.easeInOut,
          duration: const Duration(milliseconds: 400),
          child: SizedBox(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white.withOpacity(0),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      child: IconAnimated(
                        color: _fadeAnimationStart
                            ? widget.color
                            : widget.backgroundColor,
                        active: true,
                        size: 40,
                        iconType: widget.iconType,
                      ),
                    )),
                const SizedBox(width: 8),
                Flexible(
                  child: AnimatedContainer(
                    margin: EdgeInsets.only(left: _fadeAnimationStart ? 0 : 10),
                    duration: const Duration(milliseconds: 400),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 400),
                      opacity: _fadeAnimationStart ? 1.0 : 0.0,
                      child: Text(
                        widget.label,
                        overflow: TextOverflow.ellipsis,
                        maxLines: widget.maxLines,
                        style: widget.labelTextStyle ??
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }
}
