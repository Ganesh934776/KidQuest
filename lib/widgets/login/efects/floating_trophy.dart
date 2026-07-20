import 'dart:math';
import 'package:flutter/material.dart';

class FloatingTrophy extends StatefulWidget {
  final double left;
  final double top;

  const FloatingTrophy({
    super.key,
    required this.left,
    required this.top,
  });

  @override
  State<FloatingTrophy> createState() => _FloatingTrophyState();
}

class _FloatingTrophyState extends State<FloatingTrophy>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
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
      right: widget.left,
      top: widget.top,
      child: AnimatedBuilder(
        animation: controller,
        builder: (_, __) {
          return Transform.translate(
            offset: Offset(
              0,
              sin(controller.value * 2 * pi) * 8,
            ),
            child: const Icon(
              Icons.emoji_events,
              color: Colors.amber,
              size: 70,
            ),
          );
        },
      ),
    );
  }
}