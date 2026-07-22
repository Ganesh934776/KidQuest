import 'package:flutter/material.dart';

class TreeWidget extends StatelessWidget {
  final double left;

  const TreeWidget({
    super.key,
    required this.left,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 80,
      left: left,
      child: const Text(
        "🌳",
        style: TextStyle(fontSize: 44),
      ),
    );
  }
}