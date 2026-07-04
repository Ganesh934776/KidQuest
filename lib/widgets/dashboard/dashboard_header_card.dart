import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DashboardHeaderCard extends StatelessWidget {
  final String parentName;

  const DashboardHeaderCard({
    super.key,
    required this.parentName,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    String greeting;

    if (now.hour < 12) {
      greeting = "Good Morning";
    } else if (now.hour < 17) {
      greeting = "Good Afternoon";
    } else {
      greeting = "Good Evening";
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF4F8EF7),
            Color(0xFF6C63FF),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 34,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.family_restroom,
              color: Color(0xFF4F8EF7),
              size: 36,
            ),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$greeting 👋",
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  parentName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  DateFormat('EEEE, MMM d').format(now),
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
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