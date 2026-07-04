import 'dart:math';

import 'package:flutter/material.dart';

class DailyQuoteCard extends StatelessWidget {
  const DailyQuoteCard({super.key});

  static const List<String> _quotes = [
    "Small steps every day lead to big success! 🌟",
    "Every completed task makes you stronger! 💪",
    "Learning is today's superpower! 🚀",
    "Keep going, you're doing amazing! ⭐",
    "Great kids never stop trying! 🎯",
    "Dream big and work hard! 🌈",
    "Believe in yourself every single day! ❤️",
    "Success starts with one completed task! 🏆",
  ];

  @override
  Widget build(BuildContext context) {
    final quote = _quotes[Random().nextInt(_quotes.length)];

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            const Icon(
              Icons.lightbulb,
              color: Colors.amber,
              size: 40,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                quote,
                style: const TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}