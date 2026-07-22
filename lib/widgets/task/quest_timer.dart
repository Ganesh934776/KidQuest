import 'package:flutter/material.dart';

class QuestTimer extends StatelessWidget {
  final bool completed;
  final bool expired;
  final String remainingTime;
  final Color color;

  const QuestTimer({
    super.key,
    required this.completed,
    required this.expired,
    required this.remainingTime,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          completed
              ? "🏆 Quest Completed"
              : expired
                  ? "❌ Quest Closed"
                  : "⏳ Time Remaining",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          completed
              ? "Excellent!"
              : remainingTime,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: completed
                ? Colors.green
                : expired
                    ? Colors.red
                    : color,
          ),
        ),
      ],
    );
  }
}