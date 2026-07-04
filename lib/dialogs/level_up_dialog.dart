import 'package:flutter/material.dart';

class LevelUpDialog extends StatelessWidget {
  final int level;

  const LevelUpDialog({
    super.key,
    required this.level,
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
          const Icon(
            Icons.emoji_events,
            color: Colors.amber,
            size: 80,
          ),

          const SizedBox(height: 20),

          const Text(
            "LEVEL UP!",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            "You reached Level $level 🎉",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),

          const SizedBox(height: 25),

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