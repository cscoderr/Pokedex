import 'package:flutter/material.dart';

class FadeAmination extends StatefulWidget {
  const FadeAmination({
    super.key,
    required this.child,
    required this.delay,
  });

  final Widget child;
  final double delay;

  @override
  State<FadeAmination> createState() => _FadeAminationState();
}

class _FadeAminationState extends State<FadeAmination>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animation;
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: widget.delay.toInt(),
      ),
    )..forward();

    animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
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
    return ScaleTransition(
      scale: animation,
      child: FadeTransition(
        opacity: Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeIn,
          ),
        ),
        child: widget.child,
      ),
    );
  }
}
