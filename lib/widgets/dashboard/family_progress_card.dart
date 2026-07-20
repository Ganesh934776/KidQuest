import 'package:flutter/material.dart';

class FamilyProgressCard extends StatelessWidget {
  final int totalXP;
  final int children;
  final int completedTasks;
  final int totalTasks;

  const FamilyProgressCard({
    super.key,
    required this.totalXP,
    required this.children,
    required this.completedTasks,
    required this.totalTasks,
  });

  @override
  Widget build(BuildContext context) {
    final progress = totalTasks == 0
        ? 0.0
        : completedTasks / totalTasks;

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [
            Color(0xff6C63FF),
            Color(0xff7E7BFF),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withValues(alpha: .25),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: const [

              Icon(
                Icons.favorite,
                color: Colors.white,
              ),

              SizedBox(width: 10),

              Text(
                "Today's Family Progress",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          Text(
            "$totalXP XP",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            "$children Children",
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),

          const SizedBox(height: 24),

          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 12,
              backgroundColor: Colors.white24,
              valueColor:
                  const AlwaysStoppedAnimation(
                Colors.white,
              ),
            ),
          ),

          const SizedBox(height: 12),

          Text(
            "$completedTasks of $totalTasks tasks completed",
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}