import 'package:flutter/material.dart';

class XPCelebrationCard extends StatelessWidget {
  final int xp;

  const XPCelebrationCard({
    super.key,
    required this.xp,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber.shade50,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 28,
          vertical: 22,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.star_rounded,
              color: Colors.amber,
              size: 55,
            ),
            const SizedBox(height: 12),
            Text(
              "+$xp XP",
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Great Job!",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}