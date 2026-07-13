import 'package:flutter/material.dart';

class LevelProgressCard extends StatelessWidget {
  final int level;
  final double progress;
  final int currentXP;
  final int requiredXP;
  final int remainingXP;
  final String levelName;

  const LevelProgressCard({
    super.key,
    required this.level,
    required this.progress,
    required this.currentXP,
    required this.requiredXP,
    required this.remainingXP,
    required this.levelName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: Colors.blue.withValues(alpha: 0.25),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 34,
              backgroundColor: Color(0xFFFFD54F),
              child: Icon(
                Icons.emoji_events,
                size: 36,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              "Level $level",
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              levelName,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 22),

            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 14,
                backgroundColor: Colors.grey.shade300,
                valueColor: const AlwaysStoppedAnimation(
                  Colors.green,
                ),
              ),
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$currentXP XP",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "$requiredXP XP",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius:
                    BorderRadius.circular(30),
              ),
              child: Text(
                "$remainingXP XP until Level ${level + 1}",
                style: const TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}