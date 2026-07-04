import 'package:flutter/material.dart';

class LifeTree extends StatelessWidget {
  final int completedTasks;

  const LifeTree({
    super.key,
    required this.completedTasks,
  });

  @override
  Widget build(BuildContext context) {
    String emoji;
    String title;

    if (completedTasks == 0) {
      emoji = "🌱";
      title = "Tiny Seed";
    } else if (completedTasks <= 2) {
      emoji = "🌿";
      title = "Growing Plant";
    } else if (completedTasks <= 4) {
      emoji = "🌳";
      title = "Young Tree";
    } else if (completedTasks <= 6) {
      emoji = "🌳🍎";
      title = "Healthy Tree";
    } else {
      emoji = "🌳✨";
      title = "Golden Tree";
    }

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            Text(
              emoji,
              style: const TextStyle(fontSize: 70),
            ),

            const SizedBox(height: 10),

            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "$completedTasks / 8 Tasks Completed",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}