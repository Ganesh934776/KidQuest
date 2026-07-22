import 'package:flutter/material.dart';

class FlowerWidget extends StatelessWidget {
  final double left;

  const FlowerWidget({
    super.key,
    required this.left,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 55,
      left: left,
      child: const Text(
        "🌸",
        style: TextStyle(fontSize: 26),
      ),
    );
  }
}