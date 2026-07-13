import 'package:flutter/material.dart';

class ParentDashboardHeaderCard extends StatelessWidget {
  final String parentName;

  const ParentDashboardHeaderCard({
    super.key,
    required this.parentName,
  });

  String get greeting {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return "Good Morning";
    } else if (hour < 17) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xff5B86E5),
            Color(0xff36D1DC),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.25),
            blurRadius: 20,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.8, end: 1.0),
            duration: const Duration(milliseconds: 700),
            builder: (_, value, child) {
              return Transform.scale(
                scale: value,
                child: child,
              );
            },
            child: const CircleAvatar(
              radius: 42,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.family_restroom,
                size: 45,
                color: Color(0xff5B86E5),
              ),
            ),
          ),

          const SizedBox(height: 18),

          Text(
            "$greeting 👋",
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 17,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            parentName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            "Let's build great habits today!",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}