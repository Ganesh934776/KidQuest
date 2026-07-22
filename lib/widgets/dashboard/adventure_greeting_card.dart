import 'package:flutter/material.dart';
import 'package:kidquest/theme/app_colors.dart';

class AdventureGreetingCard extends StatelessWidget {
  final String childName;
  final int level;
  final int streak;
  final int coins;

  const AdventureGreetingCard({
    super.key,
    required this.childName,
    required this.level,
    required this.streak,
    required this.coins,
  });

  String _greeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) return "Good Morning";
    if (hour < 17) return "Good Afternoon";
    return "Good Evening";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: .30),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            "${_greeting()},",
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 18,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            childName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 18),

          const Text(
            "🌟 Ready for today's adventure?",
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),

          const SizedBox(height: 22),

          Row(
            children: [

              _stat(
                Icons.local_fire_department,
                "$streak Days",
              ),

              const SizedBox(width: 16),

              _stat(
                Icons.workspace_premium,
                "Lv $level",
              ),

              const SizedBox(width: 16),

              _stat(
                Icons.monetization_on,
                "$coins",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stat(IconData icon, String value) {
    return Expanded(
      child: Container(
        height: 68,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: .18),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Icon(
              icon,
              color: Colors.white,
            ),

            const SizedBox(height: 6),

            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}