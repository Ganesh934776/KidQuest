import 'package:flutter/material.dart';
import 'package:kidquest/models/task.dart';

class TaskHelper {
  /// Returns task deadline
  static DateTime getDeadline(Task task) {
    final parts = task.submissionTime.split(":");

    final hour = int.tryParse(parts[0]) ?? 23;
    final minute =
        parts.length > 1 ? int.tryParse(parts[1]) ?? 59 : 59;

    return DateTime(
      task.dueDate.year,
      task.dueDate.month,
      task.dueDate.day,
      hour,
      minute,
    );
  }

  /// Remaining time
  static Duration remaining(Task task) {
    return getDeadline(task).difference(DateTime.now());
  }

  /// Deadline crossed?
  static bool isExpired(Task task) {
    return remaining(task).isNegative;
  }

  /// Can complete?
  static bool canComplete(Task task) {
    return !task.isCompleted && !isExpired(task);
  }

  /// Countdown text
  static String format(Duration duration) {
    if (duration.isNegative) {
      return "Time Over";
    }

    String two(int value) =>
        value.toString().padLeft(2, "0");

    return "${two(duration.inHours)}:"
        "${two(duration.inMinutes % 60)}:"
        "${two(duration.inSeconds % 60)}";
  }

  /// Progress for timer
  static double progress(Task task) {
    final deadline = getDeadline(task);

    final start = DateTime(
      deadline.year,
      deadline.month,
      deadline.day,
      0,
      0,
    );

    final total = deadline.difference(start).inSeconds;

    if (total <= 0) return 0;

    final left =
        deadline.difference(DateTime.now()).inSeconds;

    return (left / total).clamp(0.0, 1.0);
  }

  /// Card color based on urgency
  static Color urgencyColor(Task task) {
    final remain = remaining(task);

    if (remain.isNegative) {
      return Colors.red;
    }

    if (remain.inMinutes <= 30) {
      return Colors.deepOrange;
    }

    if (remain.inHours <= 2) {
      return Colors.orange;
    }

    return Colors.green;
  }

  /// Friendly status text
  static String status(Task task) {
    if (task.isCompleted) {
      return "Completed";
    }

    if (isExpired(task)) {
      return "Missed";
    }

    return "Pending";
  }

  /// Returns icon from stored name
  static IconData getIcon(String icon) {
    switch (icon) {
      case "wb_sunny":
        return Icons.wb_sunny;
      case "shower":
        return Icons.shower;
      case "breakfast_dining":
        return Icons.breakfast_dining;
      case "school":
        return Icons.school;
      case "menu_book":
        return Icons.menu_book;
      case "dinner_dining":
        return Icons.dinner_dining;
      case "auto_stories":
        return Icons.auto_stories;
      case "bed":
        return Icons.bed;
      default:
        return Icons.task_alt;
    }
  }
}