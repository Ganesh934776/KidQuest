import 'package:flutter/material.dart';

class StreakCard extends StatelessWidget {

  final int streak;

  const StreakCard({
    super.key,
    required this.streak,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orange.shade50,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [

            const Icon(
              Icons.local_fire_department,
              color: Colors.red,
              size: 45,
            ),

            const SizedBox(height: 10),

            Text(
              "$streak Days",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const Text("Current Streak"),
          ],
        ),
      ),
    );
  }
}