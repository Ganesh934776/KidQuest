import 'package:flutter/material.dart';

class RewardRow extends StatelessWidget {
  final int xp;
  final int coins;
  final String submissionTime;

  const RewardRow({
    super.key,
    required this.xp,
    required this.coins,
    required this.submissionTime,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: [
        _chip(
          Icons.star,
          "+$xp XP",
          Colors.orange,
        ),

        _chip(
          Icons.monetization_on,
          "+$coins Coins",
          Colors.amber,
        ),

        _chip(
          Icons.schedule,
          submissionTime,
          Colors.blue,
        ),
      ],
    );
  }

  Widget _chip(
    IconData icon,
    String text,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .12),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: color.withValues(alpha: .30),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
            color: color,
          ),

          const SizedBox(width: 6),

          Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}