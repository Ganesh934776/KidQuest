import 'package:flutter/material.dart';

class LevelUpDialog extends StatelessWidget {
  final int level;

  const LevelUpDialog({
    super.key,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.emoji_events,
              color: Colors.amber,
              size: 90,
            ),

            const SizedBox(height: 20),

            const Text(
              "LEVEL UP!",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 18),

            Text(
              "You reached Level $level",
              style: const TextStyle(
                fontSize: 22,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text("Awesome!"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}