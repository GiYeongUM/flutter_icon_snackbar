import 'package:flutter/material.dart';
import 'package:icon_animated/icon_animated.dart';

enum SnackBarType {
  save,
  fail,
  alert,
}

class SnackBarStyle {
  final Color? backgroundColor;
  final Color iconColor;
  final TextStyle labelTextStyle;
  final bool showIconFirst;

  const SnackBarStyle({this.backgroundColor, this.iconColor = Colors.white, this.labelTextStyle = const TextStyle(), this.showIconFirst = false});
}

class IconSnackBar {
  static show({
    required BuildContext context,
    required String label,
    required SnackBarType snackBarType,
    double? iconAvatarRadius,
    Duration? duration,
    DismissDirection? direction,
    SnackBarStyle snackBarStyle = const SnackBarStyle(),
  }) {
    switch (snackBarType) {
      case SnackBarType.save:
        return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: duration ?? const Duration(seconds: 2),
          dismissDirection: direction ?? DismissDirection.down,
          behavior: SnackBarBehavior.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: SnackBarWidget(
            onPressed: () {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
            },
            label: label,
            backgroundColor: snackBarStyle.backgroundColor ?? Colors.green,
            labelTextStyle: snackBarStyle.labelTextStyle, iconType: IconType.check, showIconFirst: snackBarStyle.showIconFirst,
          ),
        ));
      case SnackBarType.fail:
        return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: duration ?? const Duration(seconds: 2),
          dismissDirection: direction ?? DismissDirection.down,
          behavior: SnackBarBehavior.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: SnackBarWidget(
            onPressed: () {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
            },
            label: label,
            backgroundColor: snackBarStyle.backgroundColor ?? Colors.red,
            labelTextStyle: snackBarStyle.labelTextStyle, iconType: IconType.fail, showIconFirst: snackBarStyle.showIconFirst,
          ),
        ));
      case SnackBarType.alert:
        return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: duration ?? const Duration(seconds: 2),
          dismissDirection: direction ?? DismissDirection.down,
          behavior: SnackBarBehavior.fixed,
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: SnackBarWidget(
            onPressed: () {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
            },
            label: label,
            backgroundColor: snackBarStyle.backgroundColor ?? Colors.black,
            labelTextStyle: snackBarStyle.labelTextStyle, iconType: IconType.alert, showIconFirst: snackBarStyle.showIconFirst,
          ),
        ));
    }
  }
}


class SnackBarWidget extends StatefulWidget implements SnackBarAction {
  const SnackBarWidget({
    Key? key,
    this.textColor,
    this.disabledTextColor,
    required this.label,
    required this.onPressed,
    this.backgroundColor = Colors.black,
    this.labelTextStyle, this.showIconFirst = false, required this.iconType,
  }) : super(key: key);

  @override
  final Color? textColor;

  @override
  final Color? disabledTextColor;

  @override
  final String label;

  @override
  final VoidCallback onPressed;

  final Color backgroundColor;
  final TextStyle? labelTextStyle;
  final bool showIconFirst;
  final IconType iconType;

  @override
  State<SnackBarWidget> createState() => _SnackBarWidgetState();

}

class _SnackBarWidgetState extends State<SnackBarWidget> with SingleTickerProviderStateMixin {

  var _changeAnimationStart = false;
  var _fadeAnimationStart = false;
  var _animationDisposed = false;

  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOutCirc));
    _handleAnimation();
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    _animationDisposed = true;
    super.dispose();
  }

  void _handleAnimation() {
    if(!_animationDisposed) {
      widget.showIconFirst ? _showIconFirst() : _showBarFirst();
    }
  }

  void _showIconFirst() {
    _animationController.forward();
    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        _changeAnimationStart = true;
      });
      Future.delayed(const Duration(milliseconds: 50), () {
        setState(() {
          _fadeAnimationStart = true;
        });
      });
    });
  }

  void _showBarFirst() {
    Future.delayed(const Duration(milliseconds: 300), () {
      _animationController.forward();
      setState(() {
        _fadeAnimationStart = true;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    if (widget.showIconFirst) {
      return InkWell(
        onTap: widget.onPressed,
        child: ClipRRect(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          borderRadius: BorderRadius.circular(15),
          child: AnimatedContainer(
            color: _changeAnimationStart ? widget.backgroundColor : Colors.white
                .withOpacity(0),
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 200),
            height: 50,
            child: !_changeAnimationStart ? Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.only(left: 8),
                height: 50,
                width: 40,
                child: Center(
                    child: IconAnimated(
                      color: widget.backgroundColor,
                      progress: _animation,
                      size: 40,
                      iconType: widget.iconType,
                    )),
              ),
            ) : SizedBox(
              height: 50,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(left: 8),
                      width: 40,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        child: IconAnimated(
                          color: _fadeAnimationStart
                              ? Colors.white
                              : widget.backgroundColor,
                          progress: _animation,
                          size: 40,
                          iconType: widget.iconType,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  AnimatedContainer(
                    margin: EdgeInsets.only(left: _fadeAnimationStart ? 0 : 10),
                    duration: const Duration(milliseconds: 300),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 300),
                      opacity: _fadeAnimationStart ? 1.0 : 0.0,
                      child: Text(widget.label,
                          overflow: TextOverflow.ellipsis,
                          style: widget.labelTextStyle ??
                              TextStyle(
                                  fontSize: 16,
                                  color: widget.backgroundColor == Colors.white
                                      ? Colors.black
                                      : Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return InkWell(
        onTap: widget.onPressed,
        child: ClipRRect(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          borderRadius: BorderRadius.circular(15),
          child: AnimatedContainer(
            color: widget.backgroundColor,
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 400),
            height: 50,
            child: SizedBox(
              height: 50,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(left: 8),
                      width: 40,
                      child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white.withOpacity(0),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            child: IconAnimated(
                              color: _fadeAnimationStart
                                  ? Colors.white
                                  : widget.backgroundColor,
                              progress: _animation,
                              size: 40,
                              iconType: widget.iconType,
                            ),
                          )),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedContainer(
                        margin:
                        EdgeInsets.only(left: _fadeAnimationStart ? 0 : 10),
                        duration: const Duration(milliseconds: 400),
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 400),
                          opacity: _fadeAnimationStart ? 1.0 : 0.0,
                          child: Text(widget.label,
                              overflow: TextOverflow.visible,
                              maxLines: 1,
                              style: widget.labelTextStyle ??
                                  const TextStyle(
                                      fontSize: 16, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

}

