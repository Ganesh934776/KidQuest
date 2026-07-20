import 'dart:math';
import 'package:flutter/material.dart';

class FloatingStar extends StatefulWidget {
  final double left;
  final double top;
  final double size;

  const FloatingStar({
    super.key,
    required this.left,
    required this.top,
    required this.size,
  });

  @override
  State<FloatingStar> createState() => _FloatingStarState();
}

class _FloatingStarState extends State<FloatingStar>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2 + Random().nextInt(3)),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: widget.left,
      top: widget.top,
      child: FadeTransition(
        opacity: Tween(begin: .3, end: 1.0).animate(controller),
        child: Icon(
          Icons.auto_awesome,
          color: Colors.amber,
          size: widget.size,
        ),
      ),
    );
  }
}