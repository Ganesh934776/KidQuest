import 'package:flutter/material.dart';

class ChildOverviewCard extends StatelessWidget {
  final String name;
  final int level;
  final int xp;

  const ChildOverviewCard({
    super.key,
    required this.name,
    required this.level,
    required this.xp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [

          const CircleAvatar(
            radius: 30,
            backgroundColor: Color(0xffE9E8FF),
            child: Icon(
              Icons.face,
              color: Color(0xff6C63FF),
              size: 34,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  "Level $level",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),

                const SizedBox(height: 14),

                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    value: (xp % 100) / 100,
                    minHeight: 8,
                    backgroundColor:
                        Colors.grey.shade200,
                    valueColor:
                        const AlwaysStoppedAnimation(
                      Color(0xff6C63FF),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: const Color(0xffF4F1FF),
              borderRadius:
                  BorderRadius.circular(16),
            ),
            child: Text(
              "$xp XP",
              style: const TextStyle(
                color: Color(0xff6C63FF),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}