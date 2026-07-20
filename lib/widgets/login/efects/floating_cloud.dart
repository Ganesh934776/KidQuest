import 'dart:math';
import 'package:flutter/material.dart';

class FloatingCloud extends StatefulWidget {
  final double left;
  final double top;
  final double width;

  const FloatingCloud({
    super.key,
    required this.left,
    required this.top,
    required this.width,
  });

  @override
  State<FloatingCloud> createState() => _FloatingCloudState();
}

class _FloatingCloudState extends State<FloatingCloud>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
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
      child: AnimatedBuilder(
        animation: controller,
        builder: (_, __) {
          return Transform.translate(
            offset: Offset(
              sin(controller.value * 2 * pi) * 15,
              0,
            ),
            child: Icon(
              Icons.cloud,
              color: Colors.white.withValues(alpha: .55),
              size: widget.width,
            ),
          );
        },
      ),
    );
  }
}