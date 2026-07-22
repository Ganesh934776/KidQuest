import 'package:flutter/material.dart';

class TreasureChestCard extends StatelessWidget {
  final bool unlocked;
  final VoidCallback onOpen;

  const TreasureChestCard({
    super.key,
    required this.unlocked,
    required this.onOpen,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: unlocked ? onOpen : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: unlocked
                ? const [
                    Color(0xffF9A825),
                    Color(0xffFFD54F),
                  ]
                : [
                    Colors.grey.shade400,
                    Colors.grey.shade300,
                  ],
          ),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.amber.withValues(alpha: .35),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [

            Text(
              unlocked ? "🎁" : "🔒",
              style: const TextStyle(fontSize: 70),
            ),

            const SizedBox(height: 14),

            Text(
              unlocked
                  ? "Daily Treasure Ready!"
                  : "Complete all quests",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              unlocked
                  ? "Tap to claim today's reward!"
                  : "Finish today's quests to unlock.",
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}