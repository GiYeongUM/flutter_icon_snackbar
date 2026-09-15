import 'package:flutter/material.dart';

/// Owns the entrance animation separately from status/content presentation.
class SnackBarEntrance extends StatefulWidget {
  const SnackBarEntrance({super.key, required this.child});
  final Widget child;

  @override
  State<SnackBarEntrance> createState() => _SnackBarEntranceState();
}

class _SnackBarEntranceState extends State<SnackBarEntrance>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final CurvedAnimation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.value = 1;
    } else {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
    opacity: _animation,
    alwaysIncludeSemantics: true,
    child: SlideTransition(
      position: Tween(
        begin: const Offset(0.05, 0),
        end: Offset.zero,
      ).animate(_animation),
      textDirection: Directionality.of(context),
      child: widget.child,
    ),
  );

  @override
  void dispose() {
    _animation.dispose();
    _controller.dispose();
    super.dispose();
  }
}
