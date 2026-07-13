import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kidquest/models/task.dart';
import 'package:kidquest/services/achievement_service.dart';
import 'package:kidquest/utils/routine_templates.dart';

class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final AchievementService _achievementService =
      AchievementService();

  // ==========================
// Routine Window (1 AM Reset)
// ==========================

DateTime _routineStart() {
  final now = DateTime.now();

  var start = DateTime(
    now.year,
    now.month,
    now.day,
    1, // 1:00 AM
  );

  // Before 1 AM, still consider yesterday's routine
  if (now.isBefore(start)) {
    start = start.subtract(
      const Duration(days: 1),
    );
  }

  return start;
}

DateTime _routineEnd() {
  return _routineStart().add(
    const Duration(days: 1),
  );
}
// ==========================
// Delete Old Tasks
// ==========================
Future<void> _deleteOldTasks(String childId) async {
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

  print(
    "🗑 Deleted ${snapshot.docs.length} old tasks",
  );
}

  // ==========================
  // Generate Today's Tasks
  // ==========================

  Future<void> generateDailyTasks(String childId) async {
  try {
    await _deleteOldTasks(childId);
    print("========== GENERATING DAILY TASKS ==========");
    print("Child ID: $childId");

    final today = _routineStart();
    final tomorrow = _routineEnd();
    final currentRoutineDate = DateTime(
  today.year,
  today.month,
  today.day,
);

final nextRoutineDate = currentRoutineDate.add(
  const Duration(days: 1),
);

    final existing = await _firestore
        .collection('tasks')
        .where("childId", isEqualTo: childId)
        .where(
  "dueDate",
  isGreaterThanOrEqualTo:
      Timestamp.fromDate(currentRoutineDate),
)
.where(
  "dueDate",
  isLessThan:
      Timestamp.fromDate(nextRoutineDate),
)
        .get();

    print("Existing tasks: ${existing.docs.length}");

    if (existing.docs.isNotEmpty) {
      print("Tasks already exist");
      return;
    }

    final templates = RoutineTemplates.getTasks(childId);

    print("Templates found: ${templates.length}");

    final batch = _firestore.batch();

    for (final routine in templates) {
      print("Adding task: ${routine["title"]}");

      final doc = _firestore.collection("tasks").doc();

      final task = Task(
        id: doc.id,
        childId: childId,
        title: routine["title"],
        description: routine["description"],
        icon: routine["icon"],
        color: routine["color"],
        xp: routine["xp"],
        coins: routine["coins"],
        dueDate: DateTime(
  today.year,
  today.month,
  today.day,
),
        submissionTime: routine["submissionTime"],
        isCompleted: false,
        completedAt: null,
        status: TaskStatus.pending,
      );

      batch.set(doc, task.toMap());
    }

    print("Committing batch...");

    await batch.commit();

    print("✅ Tasks generated successfully.");
  } catch (e, stackTrace) {
    print("❌ ERROR WHILE GENERATING TASKS");
    print(e);
    print(stackTrace);
  }
}

  // ==========================
  // Old API Compatibility
  // ==========================

  Future<void> addTask(Task task) async {
    final doc =
        _firestore.collection("tasks").doc();

    await doc.set(
      task.copyWith(
        id: doc.id,
      ).toMap(),
    );
  }

  // ==========================
  // Child Tasks
  // ==========================

 Stream<List<Task>> getTasksForChild(
    String childId) {
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
            Timestamp.fromDate(currentRoutineDate),
      )
      .where(
        "dueDate",
        isLessThan:
            Timestamp.fromDate(nextRoutineDate),
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
  //}

  // ==========================
  // Parent View
  // ==========================

  Stream<List<Task>> getAllTasks() {
    return _firestore
        .collection("tasks")
        .orderBy("dueDate", descending: true)
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

  // ==========================
  // Complete Task
  // ==========================

  Future<bool> completeTask(
      Task task) async {
    if (task.isCompleted) {
      return false;
    }

    await _firestore
        .collection("tasks")
        .doc(task.id)
        .update({
      "isCompleted": true,
    });

    final childRef =
        _firestore.collection("children").doc(
              task.childId,
            );

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

        final Timestamp? lastTime =
            data["lastCompletedDate"];

        final today = DateTime.now();

        int streak = 1;

        if (lastTime != null) {
          final previous =
              lastTime.toDate();

          final difference =
              DateTime(
            today.year,
            today.month,
            today.day,
          )
                  .difference(
            DateTime(
              previous.year,
              previous.month,
              previous.day,
            ),
          )
                  .inDays;

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
                Timestamp.fromDate(today),
          },
        );
      },
    );

    final completed =
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
          completed.docs.length,
    );

    return true;
  }

  // ==========================
  // Update
  // ==========================

  Future<void> updateTask(
      Task task) async {
    await _firestore
        .collection("tasks")
        .doc(task.id)
        .update(task.toMap());
  }

  // ==========================
  // Delete
  // ==========================

  Future<void> deleteTask(
      String taskId) async {
    await _firestore
        .collection("tasks")
        .doc(taskId)
        .delete();
  }
}