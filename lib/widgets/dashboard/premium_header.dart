import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PremiumHeader extends StatelessWidget {
  final String childName;
  final int level;
  final int coins;
  final int streak;
  final int currentXP;
  final int requiredXP;
  final double progress;

  const PremiumHeader({
    super.key,
    required this.childName,
    required this.level,
    required this.coins,
    required this.streak,
    required this.currentXP,
    required this.requiredXP,
    required this.progress,
  });

  String _greeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "Good Morning ☀️";
    } else if (hour < 17) {
      return "Good Afternoon 🌤️";
    } else {
      return "Good Evening 🌙";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 22),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [
            Color(0xff6C63FF),
            Color(0xff8A7CFF),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withValues(alpha: 0.30),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [

              Container(
                height: 72,
                width: 72,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    "🧒",
                    style: TextStyle(fontSize: 36),
                  ),
                ),
              ),

              const SizedBox(width: 18),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    Text(
                      _greeting(),
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.85),
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      childName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      "Let's complete today's adventures!",
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.90),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          Row(
            children: [

              Expanded(
                child: _infoCard(
                  icon: Icons.workspace_premium,
                  title: "Level",
                  value: level.toString(),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _infoCard(
                  icon: Icons.monetization_on,
                  title: "Coins",
                  value: coins.toString(),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _infoCard(
                  icon: Icons.local_fire_department,
                  title: "Streak",
                  value: "$streak Days",
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          Text(
            "Level Progress",
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.95),
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 12,
              backgroundColor:
                  Colors.white.withValues(alpha: 0.25),
              valueColor:
                  const AlwaysStoppedAnimation(
                Colors.white,
              ),
            ),
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
            children: [

              Text(
                "$currentXP XP",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                "$requiredXP XP",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    )
        .animate()
        .fade(duration: 700.ms)
        .slideY(begin: -.2);
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
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
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          Text(
            title,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.90),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}