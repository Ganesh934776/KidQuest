import 'package:flutter/material.dart';
import 'package:kidquest/models/task.dart';

class TaskCard extends StatefulWidget {
  final Task task;
  final Future<void> Function() onComplete;

  const TaskCard({
    super.key,
    required this.task,
    required this.onComplete,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _loading = false;

  Future<void> _handleComplete() async {
    if (_loading || widget.task.isCompleted) return;

    setState(() {
      _loading = true;
    });

    try {
      await widget.onComplete();
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final task = widget.task;

    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 4,
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Icon(
              task.isCompleted
                  ? Icons.check_circle
                  : Icons.radio_button_unchecked,
              color: task.isCompleted ? Colors.green : Colors.grey,
              size: 32,
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "Deadline: ${task.deadline}",
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    "⭐ ${task.xp} XP",
                    style: const TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            SizedBox(
              width: 110,
              height: 42,
              child: ElevatedButton(
                onPressed: task.isCompleted || _loading
                    ? null
                    : _handleComplete,
                child: _loading
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        task.isCompleted ? "Done" : "Complete",
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}