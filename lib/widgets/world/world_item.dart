import 'package:flutter/material.dart';

class WorldItem extends StatelessWidget {
  final String emoji;
  final double left;
  final double top;
  final double size;

  const WorldItem({
    super.key,
    required this.emoji,
    required this.left,
    required this.top,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      top: top,
      child: Text(
        emoji,
        style: TextStyle(fontSize: size),
      ),
    );
  }
}