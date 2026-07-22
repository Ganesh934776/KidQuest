import 'package:flutter/material.dart';

class Cloud extends StatelessWidget {
  final double left;
  final double top;

  const Cloud({
    super.key,
    required this.left,
    required this.top,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      child: const Text(
        "☁️",
        style: TextStyle(fontSize: 42),
      ),
    );
  }
}