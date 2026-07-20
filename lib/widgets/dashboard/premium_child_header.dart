import 'package:flutter/material.dart';

class PremiumChildHeader extends StatelessWidget {
  final String childName;
  final int level;
  final int xp;
  final int coins;
  final int streak;
  final double progress;

  const PremiumChildHeader({
    super.key,
    required this.childName,
    required this.level,
    required this.xp,
    required this.coins,
    required this.streak,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: const LinearGradient(
          colors: [
            Color(0xff6C63FF),
            Color(0xff4F46E5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withValues(alpha: .30),
            blurRadius: 24,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Stack(
        children: [

          Positioned(
            top: -50,
            right: -40,
            child: Container(
              width: 170,
              height: 170,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: .08),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Positioned(
            bottom: -45,
            left: -30,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: .08),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [

                Row(
                  children: [

                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .18),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.face,
                        color: Colors.white,
                        size: 42,
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [

                          const Text(
                            "Welcome Back 👋",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                            ),
                          ),

                          Text(
                            childName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Text(
                            "Level $level Hero ⭐",
                            style: const TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius:
                            BorderRadius.circular(18),
                      ),
                      child: Row(
                        children: [

                          const Icon(
                            Icons.monetization_on,
                            color: Colors.white,
                          ),

                          const SizedBox(width: 4),

                          Text(
                            "$coins",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                Row(
                  children: [

                    Expanded(
                      child: _Stat(
                        Icons.local_fire_department,
                        "$streak",
                        "Day Streak",
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: _Stat(
                        Icons.auto_awesome,
                        "$xp",
                        "Total XP",
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(12),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 14,
                    backgroundColor:
                        Colors.white24,
                    valueColor:
                        const AlwaysStoppedAnimation(
                      Colors.amber,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                const Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Next Level Progress",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String title;

  const _Stat(
    this.icon,
    this.value,
    this.title,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .14),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        children: [

          Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),

          const SizedBox(height: 10),

          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            title,
            style: const TextStyle(
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }
}