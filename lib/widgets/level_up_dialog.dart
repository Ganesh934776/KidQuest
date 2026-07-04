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
      title: const Text("🎉 Level Up!"),
      content: Text(
        "Congratulations!\n\nYou reached Level $level!",
        textAlign: TextAlign.center,
      ),
      actions: [
        FilledButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Awesome!"),
        ),
      ],
    );
  }
}