import 'package:flutter/material.dart';

class SlideAmination extends StatefulWidget {
  const SlideAmination({
    super.key,
    required this.child,
    this.isEven = false,
  });

  final Widget child;
  final bool isEven;

  @override
  State<SlideAmination> createState() => _SlideAminationState();
}

class _SlideAminationState extends State<SlideAmination>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> scaleAnimation;
  late Animation<double> fadeAnimation;
  late Animation<Offset> slideAnimation;
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(
        // milliseconds: widget.delay.toInt(),
        milliseconds: 500,
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
        curve: const Interval(0.3, 1.0, curve: Curves.easeInOut),
      ),
    );

    slideAnimation = Tween<Offset>(
      // begin: widget.isEven ? const Offset(1.0, 0.0) : Offset.zero,
      // end: widget.isEven ? Offset.zero : const Offset(0.0, 1.0),
      begin: widget.isEven ? const Offset(-1.0, 0.0) : const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 1.0, curve: Curves.easeInOut),
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
      child: SlideTransition(
        position: slideAnimation,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: widget.child,
        ),
      ),
    );
  }
}
