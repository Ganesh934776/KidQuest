import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:kidquest/models/task.dart';
import 'package:kidquest/utils/task_helper.dart';

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

  late Timer _timer;

  Duration _remaining = Duration.zero;

  @override
  void initState() {
    super.initState();

    _remaining = TaskHelper.remaining(widget.task);

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (!mounted) return;

        setState(() {
          _remaining = TaskHelper.remaining(widget.task);
        });
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _completeTask() async {
    if (_loading) return;

    if (!TaskHelper.canComplete(widget.task)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Submission time is over.",
          ),
        ),
      );
      return;
    }

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

    final completed = task.isCompleted;

    final expired = TaskHelper.isExpired(task);

    final color = TaskHelper.urgencyColor(task);

    final icon = TaskHelper.getIcon(task.icon);

    final progress = TaskHelper.progress(task);

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      child: Card(
        elevation: 10,
        shadowColor: color.withValues(alpha: 0.25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [              Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: color,
                    child: Icon(
                      icon,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          task.description,
                          style: TextStyle(
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (completed)
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 34,
                    ),
                ],
              ),

              const SizedBox(height: 20),

              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _rewardChip(
                    Icons.star,
                    "${task.xp} XP",
                    Colors.orange,
                  ),

                  _rewardChip(
                    Icons.monetization_on,
                    "${task.coins} Coins",
                    Colors.amber,
                  ),

                  _rewardChip(
                    Icons.schedule,
                    task.submissionTime,
                    Colors.blue,
                  ),
                ],
              ),

              const SizedBox(height: 22),

              Text(
                completed
                    ? "Completed Successfully 🎉"
                    : expired
                        ? "Submission Closed"
                        : "Time Remaining",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                completed
                    ? "Great Job!"
                    : TaskHelper.format(_remaining),
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: completed
                      ? Colors.green
                      : expired
                          ? Colors.red
                          : color,
                ),
              ),

              const SizedBox(height: 18),

              ClipRRect(
                borderRadius:
                    BorderRadius.circular(20),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 10,
                  color: color,
                  backgroundColor:
                      Colors.grey.shade300,
                ),
              ),

              const SizedBox(height: 22),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed:
                      completed || expired || _loading
                          ? null
                          : _completeTask,

                  icon: _loading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child:
                              CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Icon(
                          completed
                              ? Icons.check
                              : Icons.task_alt,
                        ),

                  label: Text(
                    completed
                        ? "Completed"
                        : expired
                            ? "Missed"
                            : "Complete Task",
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  style: ElevatedButton.styleFrom(
                    backgroundColor: completed
                        ? Colors.green
                        : expired
                            ? Colors.grey
                            : color,
                    foregroundColor: Colors.white,
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),            ],
          ),
        ),
      ),
    )
        .animate()
        .fade(
          duration: 500.ms,
        )
        .slideY(
          begin: 0.20,
          end: 0,
        );
  }

  Widget _rewardChip(
    IconData icon,
    String text,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: color.withValues(alpha: 0.30),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 18,
            color: color,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}