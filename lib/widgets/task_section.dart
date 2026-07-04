import 'package:flutter/material.dart';
import 'package:kidquest/models/task.dart';
import 'package:kidquest/widgets/task_card.dart';

class TaskSection extends StatelessWidget {
  final List<Task> tasks;
  final Future<void> Function(Task task) onComplete;

  const TaskSection({
    super.key,
    required this.tasks,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return const Center(
        child: Text(
          "No tasks assigned.",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];

        return TaskCard(
          task: task,
          onComplete: () => onComplete(task),
        );
      },
    );
  }
}