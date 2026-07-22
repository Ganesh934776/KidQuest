import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TreasureRewardDialog extends StatelessWidget {
  const TreasureRewardDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final rewards = [
      {
        "emoji": "🪙",
        "title": "100 Coins",
      },
      {
        "emoji": "⭐",
        "title": "50 XP",
      },
      {
        "emoji": "🏅",
        "title": "Rare Badge",
      },
      {
        "emoji": "🎁",
        "title": "Mystery Gift",
      },
    ];

    final reward = rewards[Random().nextInt(rewards.length)];

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Text(
              reward["emoji"]!,
              style: const TextStyle(
                fontSize: 90,
              ),
            )
                .animate()
                .scale(
                  duration: 700.ms,
                ),

            const SizedBox(height: 20),

            const Text(
              "Treasure Opened!",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 18),

            Text(
              reward["title"]!,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),

            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Awesome!",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}