import 'package:flutter/material.dart';

class AchievementCard extends StatelessWidget {

  final String title;
  final String emoji;
  final bool unlocked;

  const AchievementCard({
    super.key,
    required this.title,
    required this.emoji,
    required this.unlocked,
  });

  @override
  Widget build(BuildContext context) {

    return Card(
      color: unlocked
          ? Colors.green.shade100
          : Colors.grey.shade300,
      child: ListTile(
        leading: Text(
          emoji,
          style: const TextStyle(fontSize: 30),
        ),
        title: Text(title),
        trailing: Icon(
          unlocked
              ? Icons.check_circle
              : Icons.lock,
        ),
      ),
    );
  }
}