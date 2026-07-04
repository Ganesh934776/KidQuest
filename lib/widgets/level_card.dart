import 'package:flutter/material.dart';
import 'package:kidquest/utils/level_helper.dart';
import 'package:kidquest/widgets/animated_progress_bar.dart';

class LevelCard extends StatelessWidget {
  final int xp;

  const LevelCard({
    super.key,
    required this.xp,
  });

  @override
  Widget build(BuildContext context) {
    final level = LevelHelper.getLevel(xp);
    final nextXP = LevelHelper.nextLevelXP(level);
    final progress = LevelHelper.progress(xp);

    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(
              Icons.emoji_events,
              color: Colors.amber,
              size: 55,
            ),

            const SizedBox(height: 12),

            Text(
              "Level $level",
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 18),

            AnimatedProgressBar(
              progress: progress,
              color: Colors.blue,
            ),

            const SizedBox(height: 12),

            Text(
              "$xp / $nextXP XP",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 6),

            Text(
              "${nextXP - xp} XP until Level ${level + 1}",
              style: TextStyle(
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}