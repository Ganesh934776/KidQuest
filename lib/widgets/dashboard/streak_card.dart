import 'package:flutter/material.dart';

class StreakCard extends StatelessWidget {
  final int streak;

  const StreakCard({
    super.key,
    required this.streak,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shadowColor: Colors.deepOrange.withValues(alpha: 0.25),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: const BoxDecoration(
                color: Colors.deepOrange,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.local_fire_department,
                color: Colors.white,
                size: 36,
              ),
            ),

            const SizedBox(width: 18),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Daily Streak",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "$streak Day${streak == 1 ? '' : 's'}",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade700,
                    ),
                  ),

                  const SizedBox(height: 10),

                  LinearProgressIndicator(
                    value: (streak % 7) / 7,
                    minHeight: 8,
                    borderRadius:
                        BorderRadius.circular(20),
                    backgroundColor:
                        Colors.orange.shade100,
                    valueColor:
                        const AlwaysStoppedAnimation(
                      Colors.deepOrange,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            const Icon(
              Icons.whatshot,
              color: Colors.deepOrange,
              size: 34,
            ),
          ],
        ),
      ),
    );
  }
}