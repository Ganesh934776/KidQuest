import 'package:flutter/material.dart';

class AchievementDialog extends StatelessWidget {
  final String title;
  final String description;

  const AchievementDialog({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("🏆 Achievement Unlocked"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.emoji_events,
            size: 60,
            color: Colors.amber,
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [
        FilledButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Great!"),
        ),
      ],
    );
  }
}