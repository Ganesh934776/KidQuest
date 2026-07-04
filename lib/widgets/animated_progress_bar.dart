import 'package:flutter/material.dart';

class AnimatedProgressBar extends StatelessWidget {
  final double progress;
  final double height;
  final Color color;
  final String? label;

  const AnimatedProgressBar({
    super.key,
    required this.progress,
    this.height = 14,
    this.color = Colors.blue,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
        ],
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: TweenAnimationBuilder<double>(
            tween: Tween(
              begin: 0,
              end: progress.clamp(0.0, 1.0),
            ),
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOut,
            builder: (context, value, child) {
              return LinearProgressIndicator(
                value: value,
                minHeight: height,
                backgroundColor: Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation(color),
              );
            },
          ),
        ),
      ],
    );
  }
}