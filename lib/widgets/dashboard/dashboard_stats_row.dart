import 'package:flutter/material.dart';

class DashboardStatsRow extends StatelessWidget {
  final int children;
  final int tasks;
  final int xp;

  const DashboardStatsRow({
    super.key,
    required this.children,
    required this.tasks,
    required this.xp,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Expanded(
          child: _StatCard(
            icon: Icons.child_care,
            value: "$children",
            title: "Children",
            color: const Color(0xff6C63FF),
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: _StatCard(
            icon: Icons.check_circle,
            value: "$tasks",
            title: "Tasks",
            color: const Color(0xff38B36C),
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: _StatCard(
            icon: Icons.auto_awesome,
            value: "$xp",
            title: "XP",
            color: const Color(0xffFFB300),
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String title;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          CircleAvatar(
            radius: 20,
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
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}