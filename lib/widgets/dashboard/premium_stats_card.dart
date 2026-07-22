import 'package:flutter/material.dart';
import 'package:kidquest/theme/app_colors.dart';

class PremiumStatsCard extends StatelessWidget {
  final int level;
  final int streak;
  final int coins;

  const PremiumStatsCard({
    super.key,
    required this.level,
    required this.streak,
    required this.coins,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [

            Expanded(
              child: _item(
                Icons.local_fire_department,
                Colors.orange,
                "$streak",
                "Day Streak",
              ),
            ),

            Container(
              width: 1,
              height: 55,
              color: Colors.grey.shade300,
            ),

            Expanded(
              child: _item(
                Icons.workspace_premium,
                AppColors.primary,
                "$level",
                "Level",
              ),
            ),

            Container(
              width: 1,
              height: 55,
              color: Colors.grey.shade300,
            ),

            Expanded(
              child: _item(
                Icons.monetization_on,
                Colors.amber,
                "$coins",
                "Coins",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _item(
    IconData icon,
    Color color,
    String value,
    String label,
  ) {
    return Column(
      children: [

        CircleAvatar(
          radius: 22,
          backgroundColor: color.withValues(alpha: .12),
          child: Icon(
            icon,
            color: color,
          ),
        ),

        const SizedBox(height: 10),

        Text(
          value,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        Text(
          label,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}