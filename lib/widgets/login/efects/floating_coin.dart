import 'dart:math';
import 'package:flutter/material.dart';

class FloatingCoin extends StatefulWidget {
  final double left;
  final double top;

  const FloatingCoin({
    super.key,
    required this.left,
    required this.top,
  });

  @override
  State<FloatingCoin> createState() => _FloatingCoinState();
}

class _FloatingCoinState extends State<FloatingCoin>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
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
              0,
              sin(controller.value * 2 * pi) * 10,
            ),
            child: const Icon(
              Icons.monetization_on,
              color: Colors.amber,
              size: 34,
            ),
          );
        },
      ),
    );
  }
}