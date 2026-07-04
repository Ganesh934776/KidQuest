import 'package:flutter/material.dart';
import 'package:kidquest/models/child.dart';
import 'package:kidquest/models/task.dart';
import 'package:kidquest/services/task_service.dart';
import 'package:kidquest/utils/level_helper.dart';

class AnalyticsScreen extends StatelessWidget {
  final Child child;

  const AnalyticsScreen({
    super.key,
    required this.child,
  });

  Widget statCard({
    required IconData icon,
    required Color color,
    required String title,
    required String value,
  }) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: color.withValues(alpha: 0.15),
              child: Icon(
                icon,
                color: color,
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final level = LevelHelper.getLevel(child.xp);

    return Scaffold(
      appBar: AppBar(
        title: Text("${child.name}'s Analytics"),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Task>>(
        stream: TaskService().getTasksForChild(child.id),
        builder: (context, snapshot) {
          final tasks = snapshot.data ?? [];

          final completed =
              tasks.where((t) => t.isCompleted).length;

          final pending =
              tasks.where((t) => !t.isCompleted).length;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              statCard(
                icon: Icons.star,
                color: Colors.orange,
                title: "Total XP",
                value: "${child.xp}",
              ),

              statCard(
                icon: Icons.emoji_events,
                color: Colors.amber,
                title: "Current Level",
                value: "Level $level",
              ),

              statCard(
                icon: Icons.local_fire_department,
                color: Colors.deepOrange,
                title: "Daily Streak",
                value: "${child.streak} Days",
              ),

              statCard(
                icon: Icons.check_circle,
                color: Colors.green,
                title: "Completed Tasks",
                value: "$completed",
              ),

              statCard(
                icon: Icons.pending_actions,
                color: Colors.blue,
                title: "Pending Tasks",
                value: "$pending",
              ),

              statCard(
                icon: Icons.task_alt,
                color: Colors.purple,
                title: "Total Tasks",
                value: "${tasks.length}",
              ),
            ],
          );
        },
      ),
    );
  }
}