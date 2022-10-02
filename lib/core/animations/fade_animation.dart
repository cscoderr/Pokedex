import 'package:flutter/material.dart';

class FadeAmination extends StatefulWidget {
  const FadeAmination({
    super.key,
    required this.child,
    this.delay = 0.0,
  }) : assert(delay >= 0 && delay <= 1.0, 'Delay must be between 0 and 1');

  final Widget child;
  final double delay;

  @override
  State<FadeAmination> createState() => _FadeAminationState();
}

class _FadeAminationState extends State<FadeAmination>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> scaleAnimation;
  late Animation<double> fadeAnimation;
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: (widget.delay * 1000).toInt(),
      ),
    )..forward();

    scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
      ),
    );

    fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 1.0, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeAnimation,
      child: ScaleTransition(
        scale: scaleAnimation,
        child: widget.child,
      ),
    );
  }
}
