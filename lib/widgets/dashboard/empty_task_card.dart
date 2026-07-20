import 'package:flutter/material.dart';

class DashboardStatsRow extends StatelessWidget {
  final int children;
  final int xp;
  final int tasks;
  final int rewards;

  const DashboardStatsRow({
    super.key,
    required this.children,
    required this.xp,
    required this.tasks,
    required this.rewards,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Expanded(
          child: _StatItem(
            icon: Icons.child_care_rounded,
            color: const Color(0xff6C63FF),
            title: "Children",
            value: children.toString(),
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: _StatItem(
            icon: Icons.auto_awesome,
            color: Colors.amber,
            title: "XP",
            value: xp.toString(),
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: _StatItem(
            icon: Icons.assignment,
            color: Colors.green,
            title: "Tasks",
            value: tasks.toString(),
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: _StatItem(
            icon: Icons.card_giftcard,
            color: Colors.redAccent,
            title: "Rewards",
            value: rewards.toString(),
          ),
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: color.withValues(alpha: .12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                icon,
                color: color,
              ),
            ),

            const Spacer(),

            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),

            Text(
              title,
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}