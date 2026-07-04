import 'package:flutter/material.dart';

class ProgressRing extends StatelessWidget {
  final double progress;
  final double size;
  final Widget? child;
  final Color color;
  final double strokeWidth;

  const ProgressRing({
    super.key,
    required this.progress,
    this.size = 120,
    this.child,
    this.color = Colors.blue,
    this.strokeWidth = 10,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            strokeWidth: strokeWidth,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation(color),
          ),
          if (child != null) child!,
        ],
      ),
    );
  }
}