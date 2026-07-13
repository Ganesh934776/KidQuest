import 'package:flutter/material.dart';

class EmptyTaskCard extends StatelessWidget {
  const EmptyTaskCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(22),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 36,
        ),
        child: Column(
          children: const [
            Icon(
              Icons.task_alt,
              size: 70,
              color: Colors.green,
            ),

            SizedBox(height: 16),

            Text(
              "Awesome!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10),

            Text(
              "No tasks assigned for today.\nEnjoy your free time!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}