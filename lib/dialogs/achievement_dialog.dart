import 'package:flutter/material.dart';

class AchievementDialog extends StatelessWidget {
  final String title;
  final String description;
  final String icon;

  const AchievementDialog({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            icon,
            style: const TextStyle(fontSize: 70),
          ),

          const SizedBox(height: 16),

          const Text(
            "Achievement Unlocked!",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 12),

          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 8),

          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Awesome!"),
            ),
          ),
        ],
      ),
    );
  }
}