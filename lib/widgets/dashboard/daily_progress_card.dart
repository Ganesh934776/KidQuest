import 'package:flutter/material.dart';


class DailyProgressCard extends StatelessWidget {
  final int completed;
  final int total;

  const DailyProgressCard({
    super.key,
    required this.completed,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final progress =
        total == 0 ? 0.0 : completed / total;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          children: [

            const Text(
              "⭐ Today's Progress",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 18),

            ClipRRect(
              borderRadius:
                  BorderRadius.circular(20),
              child: LinearProgressIndicator(
                minHeight: 14,
                value: progress,
              ),
            ),

            const SizedBox(height: 14),

            Text(
              "$completed of $total Quests Completed",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}