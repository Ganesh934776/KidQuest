import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {
  final String childName;
  final int level;
  final int xp;
  final int streak;

  const DashboardHeader({
    super.key,
    required this.childName,
    required this.level,
    required this.xp,
    required this.streak,
  });

  String _greeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "Good Morning";
    }

    if (hour < 17) {
      return "Good Afternoon";
    }

    return "Good Evening";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF4A90E2),
            Color(0xFF6C63FF),
          ],
        ),
        borderRadius: BorderRadius.circular(22),
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

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _InfoTile(
                icon: Icons.star,
                value: "$level",
                label: "Level",
              ),
              _InfoTile(
                icon: Icons.flash_on,
                value: "$xp",
                label: "XP",
              ),
              _InfoTile(
                icon: Icons.local_fire_department,
                value: "$streak",
                label: "Streak",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _InfoTile({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 28,
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}