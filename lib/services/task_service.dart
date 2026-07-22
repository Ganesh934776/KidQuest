import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:kidquest/models/task.dart';
import 'package:kidquest/services/achievement_service.dart';
import 'package:kidquest/utils/routine_templates.dart';

class TaskService {
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance;

  final AchievementService _achievementService =
      AchievementService();

  // ==========================================================
  // ROUTINE WINDOW
  // (1:00 AM -> Next Day 1:00 AM)
  // ==========================================================

  DateTime _routineStart() {
    final now = DateTime.now();

    DateTime start = DateTime(
      now.year,
      now.month,
      now.day,
      1,
    );

    if (now.isBefore(start)) {
      start = start.subtract(
        const Duration(days: 1),
      );
    }

    return start;
  }

  DateTime _routineEnd() {
    final start = _routineStart();

    return start.add(
      const Duration(days: 1),
    );
  }

  // ==========================================================
  // DELETE EXPIRED TASKS
  // ==========================================================

  Future<void> _deleteOldTasks(
    String childId,
  ) async {
    final start = _routineStart();

    final currentRoutineDate = DateTime(
      start.year,
      start.month,
      start.day,
    );

    final snapshot = await _firestore
        .collection("tasks")
        .where(
          "childId",
          isEqualTo: childId,
        )
        .where(
          "dueDate",
          isLessThan:
              Timestamp.fromDate(currentRoutineDate),
        )
        .get();

    if (snapshot.docs.isEmpty) {
      return;
    }

    final batch = _firestore.batch();

    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();

    debugPrint(
      "Deleted ${snapshot.docs.length} expired tasks.",
    );
  }

  // ==========================================================
  // GENERATE DAILY TASKS
  // ==========================================================

  Future<void> generateDailyTasks(
    String childId,
  ) async {    try {
      await _deleteOldTasks(childId);

      debugPrint(
        "========== GENERATING DAILY TASKS ==========",
      );

      final today = _routineStart();

      final currentRoutineDate = DateTime(
        today.year,
        today.month,
        today.day,
      );

      final nextRoutineDate =
          currentRoutineDate.add(
        const Duration(days: 1),
      );

      final existing = await _firestore
          .collection("tasks")
          .where(
            "childId",
            isEqualTo: childId,
          )
          .where(
            "dueDate",
            isGreaterThanOrEqualTo:
                Timestamp.fromDate(
              currentRoutineDate,
            ),
          )
          .where(
            "dueDate",
            isLessThan:
                Timestamp.fromDate(
              nextRoutineDate,
            ),
          )
          .get();

      if (existing.docs.isNotEmpty) {
        debugPrint(
          "Today's tasks already exist.",
        );
        return;
      }

      final templates =
          RoutineTemplates.getTasks(
        childId,
      );

      final batch = _firestore.batch();

      for (final routine in templates) {
        final doc =
            _firestore.collection("tasks").doc();

        final task = Task(
          id: doc.id,
          childId: childId,
          title: routine["title"],
          description:
              routine["description"],
          icon: routine["icon"],
          color: routine["color"],
          xp: routine["xp"],
          coins: routine["coins"],
          dueDate: currentRoutineDate,
          submissionTime:
              routine["submissionTime"],
          isCompleted: false,
          completedAt: null,
          status: TaskStatus.pending,
        );

        batch.set(
          doc,
          task.toMap(),
        );
      }

      await batch.commit();

      debugPrint(
        "Daily tasks generated successfully.",
      );
    } catch (e, stackTrace) {
      debugPrint(
        "Failed to generate daily tasks.",
      );

      debugPrint(e.toString());

      debugPrint(
        stackTrace.toString(),
      );
    }
  }

  // ==========================================================
  // ADD TASK
  // ==========================================================

  Future<void> addTask(
    Task task,
  ) async {
    final doc =
        _firestore.collection("tasks").doc();

    await doc.set(
      task.copyWith(
        id: doc.id,
      ).toMap(),
    );
  }

  // ==========================================================
  // CHILD TASKS
  // ==========================================================

  Stream<List<Task>> getTasksForChild(
    String childId,
  ) {
    final start = _routineStart();

    final currentRoutineDate = DateTime(
      start.year,
      start.month,
      start.day,
    );

    final nextRoutineDate =
        currentRoutineDate.add(
      const Duration(days: 1),
    );

    return _firestore
        .collection("tasks")
        .where(
          "childId",
          isEqualTo: childId,
        )
        .where(
          "dueDate",
          isGreaterThanOrEqualTo:
              Timestamp.fromDate(
            currentRoutineDate,
          ),
        )
        .where(
          "dueDate",
          isLessThan:
              Timestamp.fromDate(
            nextRoutineDate,
          ),
        )
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => Task.fromMap(
                  doc.id,
                  doc.data(),
                ),
              )
              .toList(),
        );
  }

  // ==========================================================
  // ALL TASKS (PARENT)
  // ==========================================================

  Stream<List<Task>> getAllTasks() {
    return _firestore
        .collection("tasks")
        .orderBy(
          "dueDate",
          descending: true,
        )
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => Task.fromMap(
                  doc.id,
                  doc.data(),
                ),
              )
              .toList(),
        );
  }

  // ==========================================================
  // COMPLETE TASK
  // ==========================================================

  Future<bool> completeTask(
    Task task,
  ) async {    if (task.isCompleted) {
      return false;
    }

    await _firestore
        .collection("tasks")
        .doc(task.id)
        .update({
      "isCompleted": true,
    });

    final childRef = _firestore
        .collection("children")
        .doc(task.childId);

    int latestXP = 0;

    await _firestore.runTransaction(
      (transaction) async {
        final snapshot =
            await transaction.get(childRef);

        final data = snapshot.data()!;

        final currentXP =
            data["xp"] ?? 0;

        final currentCoins =
            data["coins"] ?? 0;

        final currentStreak =
            data["streak"] ?? 0;

        latestXP =
            currentXP + task.xp;

        final latestCoins =
            currentCoins + task.coins;

        final Timestamp? lastCompleted =
            data["lastCompletedDate"];

        final today = DateTime.now();

        int streak = 1;

        if (lastCompleted != null) {
          final previous =
              lastCompleted.toDate();

          final difference = DateTime(
            today.year,
            today.month,
            today.day,
          ).difference(
            DateTime(
              previous.year,
              previous.month,
              previous.day,
            ),
          ).inDays;

          if (difference == 0) {
            streak = currentStreak;
          } else if (difference == 1) {
            streak = currentStreak + 1;
          }
        }

        transaction.update(
          childRef,
          {
            "xp": latestXP,
            "coins": latestCoins,
            "streak": streak,
            "lastCompletedDate":
                Timestamp.fromDate(
              today,
            ),
          },
        );
      },
    );

    final completedTasks =
        await _firestore
            .collection("tasks")
            .where(
              "childId",
              isEqualTo: task.childId,
            )
            .where(
              "isCompleted",
              isEqualTo: true,
            )
            .get();

    await _achievementService
        .checkAchievements(
      childId: task.childId,
      xp: latestXP,
      completedTasks:
          completedTasks.docs.length,
    );

    return true;
  }

  // ==========================================================
  // UPDATE TASK
  // ==========================================================

  Future<void> updateTask(
    Task task,
  ) async {
    await _firestore
        .collection("tasks")
        .doc(task.id)
        .update(
          task.toMap(),
        );
  }  // ==========================================================
  // DELETE TASK
  // ==========================================================

  Future<void> deleteTask(
    String taskId,
  ) async {
    await _firestore
        .collection("tasks")
        .doc(taskId)
        .delete();
  }
}