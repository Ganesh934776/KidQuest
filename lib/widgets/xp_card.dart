import 'package:flutter/material.dart';

class XPCard extends StatelessWidget {
  final int xp;
  final int level;

  const XPCard({
    super.key,
    required this.xp,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [

            const Icon(
              Icons.star,
              color: Colors.orange,
              size: 45,
            ),

            const SizedBox(height: 10),

            Text(
              "$xp XP",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "Level $level",
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}