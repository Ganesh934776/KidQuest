import 'package:flutter/material.dart';

class QuestHeader extends StatelessWidget {
  final String title;
  final String originalTitle;
  final String difficulty;
  final Color difficultyColor;
  final IconData icon;
  final Color iconColor;
  final bool completed;

  const QuestHeader({
    super.key,
    required this.title,
    required this.originalTitle,
    required this.difficulty,
    required this.difficultyColor,
    required this.icon,
    required this.iconColor,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: iconColor.withValues(alpha: .15),
          child: Icon(
            icon,
            color: iconColor,
            size: 30,
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              Text(
                title,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                originalTitle,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color:
                difficultyColor.withValues(alpha: .15),
            borderRadius:
                BorderRadius.circular(20),
          ),
          child: Text(
            difficulty,
            style: TextStyle(
              color: difficultyColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        if (completed)
          const Padding(
            padding: EdgeInsets.only(left: 8),
            child: Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
          ),
      ],
    );
  }
}