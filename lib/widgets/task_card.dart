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
          content: Text("Submission time is over."),
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

  // ==========================
  // Difficulty Helpers
  // ==========================

  String getDifficulty() {
    final xp = widget.task.xp;

    if (xp <= 20) return "EASY";
    if (xp <= 40) return "MEDIUM";
    if (xp <= 70) return "HARD";

    return "EPIC";
  }

  Color getDifficultyColor() {
    switch (getDifficulty()) {
      case "EASY":
        return Colors.green;

      case "MEDIUM":
        return Colors.orange;

      case "HARD":
        return Colors.red;

      default:
        return Colors.purple;
    }
  }

  IconData getDifficultyIcon() {
    switch (getDifficulty()) {
      case "EASY":
        return Icons.sentiment_satisfied;

      case "MEDIUM":
        return Icons.local_fire_department;

      case "HARD":
        return Icons.whatshot;

      default:
        return Icons.workspace_premium;
    }
  }

  @override
  Widget build(BuildContext context) {    final task = widget.task;

    final completed = task.isCompleted;
    final expired = TaskHelper.isExpired(task);

    final color = TaskHelper.urgencyColor(task);
    final icon = TaskHelper.getIcon(task.icon);

    final progress = TaskHelper.progress(task);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),

      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          if (!completed && !expired)
            BoxShadow(
              color: color.withValues(alpha: 0.25),
              blurRadius: 24,
              spreadRadius: 2,
              offset: const Offset(0, 8),
            ),
          if (completed)
            BoxShadow(
              color: Colors.green.withValues(alpha: 0.25),
              blurRadius: 24,
              spreadRadius: 2,
              offset: const Offset(0, 8),
            ),
        ],
      ),

      child: Card(
        elevation: completed ? 4 : 10,
        shadowColor: color.withValues(alpha: 0.25),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
          side: BorderSide(
            color: completed
                ? Colors.green
                : color.withValues(alpha: 0.25),
            width: 1.5,
          ),
        ),

        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      getDifficultyColor(),
                      getDifficultyColor().withValues(alpha: 0.75),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    Icon(
                      getDifficultyIcon(),
                      color: Colors.white,
                      size: 18,
                    ),

                    const SizedBox(width: 8),

                    Text(
                      "${getDifficulty()} QUEST",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Hero(
                    tag: task.id,
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color.withValues(alpha: 0.15),
                        border: Border.all(
                          color: color,
                          width: 2,
                        ),
                      ),
                      child: Icon(
                        icon,
                        color: color,
                        size: 34,
                      ),
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
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          task.description,
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 15,
                          ),
                        ),

                        if (completed) ...[
                          const SizedBox(height: 10),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              borderRadius:
                                  BorderRadius.circular(20),
                            ),
                            child: const Text(
                              "✅ Quest Completed",
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 22),

              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _rewardChip(
                    Icons.star_rounded,
                    "+${task.xp} XP",
                    Colors.orange,
                  ),

                  _rewardChip(
                    Icons.monetization_on_rounded,
                    "+${task.coins} Coins",
                    Colors.amber,
                  ),

                  _rewardChip(
                    Icons.schedule_rounded,
                    task.submissionTime,
                    Colors.blue,
                  ),
                ],
              ),

              const SizedBox(height: 22),

              Text(
                completed
                    ? "🎉 Quest Completed"
                    : expired
                        ? "⛔ Quest Expired"
                        : "⏳ Time Remaining",
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: completed
                      ? Colors.green.withValues(alpha: 0.10)
                      : expired
                          ? Colors.red.withValues(alpha: 0.10)
                          : color.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(18),
                ),

                child: Row(
                  children: [

                    Icon(
                      completed
                          ? Icons.check_circle
                          : expired
                              ? Icons.cancel
                              : Icons.timer,
                      color: completed
                          ? Colors.green
                          : expired
                              ? Colors.red
                              : color,
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        completed
                            ? "Great Job!"
                            : TaskHelper.format(_remaining),
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: completed
                              ? Colors.green
                              : expired
                                  ? Colors.red
                                  : color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 10,
                  color: color,
                  backgroundColor: Colors.grey.shade300,
                ),
              ),

              const SizedBox(height: 24),              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton.icon(
                  onPressed: completed || expired || _loading
                      ? null
                      : _completeTask,
                  icon: _loading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white,
                          ),
                        )
                      : Icon(
                          completed
                              ? Icons.check_circle
                              : expired
                                  ? Icons.lock_clock
                                  : Icons.rocket_launch,
                        ),
                  label: Text(
                    completed
                        ? "Quest Completed"
                        : expired
                            ? "Quest Expired"
                            : "Complete Quest",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: completed
                        ? Colors.green
                        : expired
                            ? Colors.grey
                            : color,
                    foregroundColor: Colors.white,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(18),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 22),

              Row(
                children: [
                  const Icon(
                    Icons.flag_circle,
                    color: Colors.deepPurple,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    "Quest Progress",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "${(progress * 100).toInt()}%",
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 12,
                  color: color,
                  backgroundColor: Colors.grey.shade300,
                ),
              ),

              const SizedBox(height: 10),

              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  completed
                      ? "🏆 Quest Completed!"
                      : expired
                          ? "❌ Quest Failed"
                          : "Keep Going!",
                  style: TextStyle(
                    color: completed
                        ? Colors.green
                        : expired
                            ? Colors.red
                            : color,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    )
        .animate()
        .fade(duration: 500.ms)
        .slideY(begin: 0.20, end: 0)
        .scale(
          begin: const Offset(0.96, 0.96),
          end: const Offset(1, 1),
        );
  }

  Widget _rewardChip(
    IconData icon,
    String text,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withValues(alpha: 0.18),
            color.withValues(alpha: 0.08),
          ],
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: color.withValues(alpha: 0.35),
        ),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: color,
            child: Icon(
              icon,
              color: Colors.white,
              size: 16,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    )
        .animate()
        .fade(duration: 300.ms)
        .scale(
          begin: const Offset(0.9, 0.9),
          end: const Offset(1, 1),
        );
  }
}